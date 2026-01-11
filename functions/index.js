/* eslint-disable max-len */
// 1. Initialize admin first.
const admin = require("firebase-admin");
admin.initializeApp();

// 2. NOW import functions and other modules.
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {onRequest} = require("firebase-functions/v2/https");
const {setGlobalOptions} = require("firebase-functions/v2");
const {defineSecret} = require("firebase-functions/params"); // NEW
const Razorpay = require("razorpay");
const {GoogleAuth} = require("google-auth-library");
const {google} = require("googleapis");

// Set global options
setGlobalOptions({region: "us-central1"});

// Initialize Firestore
const db = admin.firestore();

// 3. DEFINE the secrets our functions will need
const RAZORPAY_KEY_ID = defineSecret("RAZORPAY_KEY_ID");
const RAZORPAY_KEY_SECRET = defineSecret("RAZORPAY_KEY_SECRET");

// 4. YOUR NEW RAZORPAY FUNCTIONS (v2 Syntax)
exports.createRazorpayOrder = onCall(
    {secrets: [RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET]},
    async (request) => {
      console.log("🔥 AUTH RECEIVED:", request.auth);
      if (!request.auth) {
        throw new HttpsError(
            "unauthenticated",
            "You must be logged in to make a payment.",
        );
      }
      // Initialize Razorpay *INSIDE* the function
      const razorpay = new Razorpay({
        key_id: RAZORPAY_KEY_ID.value(), // Access the secret value
        key_secret: RAZORPAY_KEY_SECRET.value(),
      });
      const amount = request.data.amount;
      const currency = "INR";
      const receipt = `receipt_naapjaap_${new Date().getTime()}`;
      if (!amount || typeof amount !== "number" || amount <= 0) {
        throw new HttpsError(
            "invalid-argument",
            "The function must be called with a valid 'amount'.",
        );
      }
      try {
        const options = {
          amount: amount, // Amount in smallest unit (paisa)
          currency: currency,
          receipt: receipt,
          payment_capture: 1, // Auto-capture payment
        };
        const order = await razorpay.orders.create(options);
        return {order_id: order.id};
      } catch (error) {
        console.error("Razorpay order creation failed:", error);
        throw new HttpsError(
            "internal",
            "Failed to create Razorpay order.",
        );
      }
    });

exports.grantPremiumAccessOnPayment = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError(
        "unauthenticated",
        "You must be logged in.",
    );
  }
  const uid = request.auth.uid;
  try {
    await db.collection("users").doc(uid).update({
      isPremium: true,
    });
    return {status: "success", message: "Premium access granted."};
  } catch (error) {
    console.error("Failed to grant premium access:", error);
    throw new HttpsError(
        "internal",
        "Failed to update user profile.",
    );
  }
});


// 5. ALL YOUR OLD FUNCTIONS (Converted to v2 Syntax)
exports.sendDailyReminders = onSchedule(
    {schedule: "every day 09:00", timeZone: "Asia/Kolkata"},
    async (event) => {
      const usersSnapshot = await db
          .collection("users")
          .where("settings.enableReminders", "==", true)
          .get();

      if (usersSnapshot.empty) {
        console.log("No users with reminders enabled.");
        return;
      }

      const now = new Date();
      const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

      const messages = [];
      for (const userDoc of usersSnapshot.docs) {
        const userData = userDoc.data();
        const fcmToken = userData.fcmToken;
        let lastChantDate = null;
        if (userData.lastChantDate) {
          lastChantDate = userData.lastChantDate.toDate();
        }

        if (
          fcmToken &&
        (!lastChantDate || lastChantDate.getTime() < today.getTime())
        ) {
          messages.push({
            notification: {
              title: "🌟 Your spiritual journey awaits!",
              body:
              "A moment of peace is just a tap away. Let's continue our Japa practice.",
            },
            token: fcmToken,
          });
        }
      }

      if (messages.length > 0) {
        console.log(`Sending ${messages.length} reminders.`);
        await admin.messaging().sendEach(messages);
      } else {
        console.log("All users are up to date. No reminders sent.");
      }
    });

exports.resetWeeklyLeaderboard = onSchedule(
    {schedule: "every monday 00:00", timeZone: "Asia/Kolkata"},
    async (event) => {
      const usersRef = db.collection("users");
      const usersSnapshot = await usersRef
          .where("weekly_total_japps", ">", 0)
          .get();

      if (usersSnapshot.empty) {
        console.log("No users with weekly japps. No reset needed.");
        return;
      }

      const batch = db.batch();
      usersSnapshot.forEach((doc) => {
        batch.update(doc.ref, {weekly_total_japps: 0});
      });

      await batch.commit();
      console.log(
          `Reset weekly_total_japps for ${usersSnapshot.size} users.`,
      );
    });

exports.sendDailyQuote = onSchedule({
  schedule: "0 1 * * *", // 1:00 AM IST
  timeZone: "Asia/Kolkata",
}, async (event) => {
  console.log("Running 'Grand Library' daily quote function...");
  try {
    // --- 1. Get the Bhagavad Gita Quote ---
    const gitaQuotesSnapshot = await db.collection("quotes").get();
    if (!gitaQuotesSnapshot.empty) {
      const gitaQuotes = gitaQuotesSnapshot.docs;
      // Pick a random index based on the current date to ensure rotation
      const dayOfYear = Math.floor((new Date() - new Date(new Date().getFullYear(), 0, 0)) / 1000 / 60 / 60 / 24);
      const gitaIndex = dayOfYear % gitaQuotes.length;
      const gitaQuote = gitaQuotes[gitaIndex].data();
      // Add a timestamp field so the client knows it's new
      await db.collection("app_config").doc("daily_gita_quote").set({
        ...gitaQuote,
        lastUpdated: admin.firestore.FieldValue.serverTimestamp(),
      });
      console.log(`Successfully set daily Gita quote: ${gitaQuote.source}`);
    }

    // --- 2. Get the Ramayana Quote ---
    const ramayanaQuotesSnapshot = await db.collection("ramayana_quotes").get();
    if (!ramayanaQuotesSnapshot.empty) {
      const ramayanaQuotes = ramayanaQuotesSnapshot.docs;
      // Same logic for Ramayana
      const dayOfYear = Math.floor((new Date() - new Date(new Date().getFullYear(), 0, 0)) / 1000 / 60 / 60 / 24);
      const ramayanaIndex = (dayOfYear + 5) % ramayanaQuotes.length; // Offset by 5 to desync from Gita

      const ramayanaQuote = ramayanaQuotes[ramayanaIndex].data();
      await db.collection("app_config").doc("daily_ramayana_quote").set({
        ...ramayanaQuote,
        lastUpdated: admin.firestore.FieldValue.serverTimestamp(),
      });
      console.log(`Successfully set daily Ramayana quote: ${ramayanaQuote.source}`);
    }
    console.log("Daily wisdom documents have been successfully updated.");
  } catch (error) {
    console.error("Error setting daily quotes:", error);
  }
});

// eslint-disable-next-line valid-jsdoc
/**
 * Get an authenticated Google Sheets client.
 *
 * @returns {Promise<import('googleapis').sheets_v4.Sheets>} An authenticated Sheets API client.
 */
async function getSheetsClient() {
  const auth = new GoogleAuth({
    scopes: ["https://www.googleapis.com/auth/spreadsheets.readonly"],
  });
  const authClient = await auth.getClient();
  return google.sheets({version: "v4", auth: authClient});
}

// onRequest function (v2 Syntax)
exports.addQuoteFromSheet = onRequest(async (req, res) => {
  try {
    const sheets = await getSheetsClient();
    const spreadsheetId = "1-gHIE-i7B-g8y42d7B-BR--8GN2Y-Rss-b_H-4-k2nI";
    const range = "Sheet1!A2:B2";

    const response = await sheets.spreadsheets.values.get({
      spreadsheetId,
      range,
    });

    const values = response.data.values;
    if (!values || values.length === 0) {
      res.status(404).send("No data found in sheet.");
      return;
    }

    const quoteText = values[0][0];
    const sourceText = values[0][1];

    await db.collection("app_config").doc("daily_gita_quote").set(
        {
          text: quoteText,
          source: sourceText,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        {merge: true},
    );

    res.status(200).send("Successfully updated daily quote.");
  } catch (error) {
    console.error("Error adding quote from sheet:", error);
    res.status(500).send("Error adding quote.");
  }
});

// onRequest function (v2 Syntax)
exports.addQuotesInBatch = onRequest(async (req, res) => {
  try {
    const sheets = await getSheetsClient();
    const spreadsheetId = "1-gHIE-i7B-g8y4com/spreadsheets/d/1-gHIE-i7B-g8y42d7B-BR--8GN2Y-Rss-b_H-4-k2nI"; // Your sheet ID
    const range = "Sheet1!A:C";

    const response = await sheets.spreadsheets.values.get({
      spreadsheetId,
      range,
    });

    const values = response.data.values;
    if (!values || values.length === 0) {
      res.status(404).send("No data found in sheet.");
      return;
    }

    const batch = db.batch();
    let count = 0;
    for (let i = 1; i < values.length; i++) { // Start from 1 to skip header
      const row = values[i];
      const quoteText = row[0];
      const sourceText = row[1];
      const type = row[2] || "gita";

      if (quoteText && sourceText) {
        const docRef = db.collection("quotes").doc();
        batch.set(docRef, {
          text: quoteText,
          source: sourceText,
          type: type,
        });
        count++;
      }
    }

    await batch.commit();
    res
        .status(200)
        .send(`Successfully added ${count} quotes in batch.`);
  } catch (error) {
    console.error("Error adding quotes in batch:", error);
    res.status(500).send("Error adding quotes.");
  }
});
