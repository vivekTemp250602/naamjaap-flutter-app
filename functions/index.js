/* eslint-disable max-len */
const admin = require("firebase-admin");
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {onSchedule} = require("firebase-functions/v2/scheduler");

admin.initializeApp();
const db = admin.firestore();

// ===================================================================
// Function 1: Send Daily Reminder Notifications
// ===================================================================
// Runs every day at 8:00 PM Indian Standard Time (IST).
exports.sendDailyReminders = onSchedule({
  schedule: "0 20 * * *",
  timeZone: "Asia/Kolkata",
}, async (event) => {
  console.log("Running daily reminder function...");
  const now = new Date();
  const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  const todayTimestamp = admin.firestore.Timestamp.fromDate(today);

  const usersSnapshot = await db.collection("users")
      .where("settings.enableReminders", "==", true).get();

  if (usersSnapshot.empty) {
    console.log("No users with reminders enabled.");
    return null;
  }

  const tokensToSend = [];
  usersSnapshot.forEach((doc) => {
    const userData = doc.data();
    const lastChant = userData.lastChantDate;
    if (userData.fcmToken && (!lastChant || lastChant < todayTimestamp)) {
      tokensToSend.push(userData.fcmToken);
    }
  });

  if (tokensToSend.length === 0) {
    console.log("All users have chanted today. No reminders to send.");
    return null;
  }

  const message = {
    notification: {
      title: "A Gentle Reminder 🙏",
      body: "Just a gentle reminder to continue your chanting streak today.",
    },
    tokens: tokensToSend,
  };

  try {
    const response = await admin.messaging().sendMulticast(message);
    console.log(`Successfully sent ${response.successCount} reminder notifications.`);
    if (response.failureCount > 0) {
      console.error(`Failed to send ${response.failureCount} notifications.`);
    }
  } catch (error) {
    console.error("Error sending notifications:", error);
  }
  return null;
});

// ===================================================================
// Function 2: Reset the Weekly Leaderboard
// ===================================================================
// Runs every Monday at 12:05 AM UTC.
exports.resetWeeklyLeaderboard = onSchedule({
  schedule: "5 0 * * 1",
  timeZone: "UTC",
}, async (event) => {
  console.log("Running weekly leaderboard reset function...");
  const usersRef = db.collection("users");
  const snapshot = await usersRef.get();

  if (snapshot.empty) {
    console.log("No users found to reset.");
    return null;
  }

  const batch = db.batch();
  snapshot.forEach((doc) => {
    batch.update(doc.ref, {weekly_total_japps: 0});
  });

  await batch.commit();
  console.log(`Reset weekly japps for ${snapshot.size} users.`);
  return null;
});

// ===================================================================
// Function 3: Send the Daily Quote from Your Firestore Library
// ===================================================================
// Runs every day at 1:00 AM Indian Standard Time (IST).
exports.sendDailyQuote = onSchedule({
  schedule: "0 1 * * *", // Now set to 1:00 AM as you requested
  timeZone: "Asia/Kolkata",
}, async (event) => {
  console.log("Running daily quote function from Firestore library...");
  try {
    // 1. Get all available quotes from your personal library.
    const quotesSnapshot = await db.collection("quotes").get();
    if (quotesSnapshot.empty) {
      console.log("No quotes found in the 'quotes' collection. Exiting.");
      return null;
    }
    // 2. Select a random quote from the documents you created.
    const quotes = quotesSnapshot.docs;
    const randomQuoteDoc = quotes[Math.floor(Math.random() * quotes.length)];
    const dailyQuote = randomQuoteDoc.data();

    // 3. Save the selected quote to the public 'daily_quote' document.
    await db.collection("app_config").doc("daily_quote").set(dailyQuote);

    // 4. Create the push notification payload.
    const payload = {
      notification: {
        title: "Wisdom for Your Day 🙏",
        body: `"${dailyQuote.text_en}" — ${dailyQuote.source}`,
      },
      topic: "daily_quote",
    };

    // 5. Send the notification.
    await admin.messaging().send(payload);
    console.log(`Successfully sent daily quote: ${dailyQuote.source}`);
  } catch (error) {
    console.error("Error sending daily quote from Firestore:", error);
  }
  return null;
});

// ===================================================================
// Function 4: Add a New Quote to the Library from a Google Sheet
// ===================================================================
exports.addQuoteFromSheet = onCall(async (request) => {
  const data = request.data;
  try {
    const writeResult = await db.collection("quotes").add({
      text_en: data.text_en,
      text_hi: data.text_hi || "",
      text_sa: data.text_sa || "",
      source: data.source,
    });

    console.log(`Successfully add a new quote with ID: {$writeResult.id}`);
    return {result: `Quote added successfully: ${writeResult.id}`};
  } catch (error) {
    console.error("Error writing new quote to Firestore:", error);
    throw new HttpsError(
        "internal",
        "Failed to add quote.",
    );
  }
});

// ===================================================================
// Function 5: Add a Batch of Quotes to the Library from a Google Sheet
// ===================================================================
exports.addQuotesInBatch = onCall(async (request) => {
  // We expect the Google Sheet to send us an ARRAY of quote objects.
  const quotes = request.data.quotes;
  // Security and validation check.
  if (!quotes || !Array.isArray(quotes) || quotes.length === 0) {
    throw new HttpsError(
        "invalid-argument",
        "The function must be called with a non-empty 'quotes' array.",
    );
  }

  // Use a Firestore Batched Write for maximum efficiency.
  // This performs all the writes in a single, atomic operation.
  const batch = db.batch();
  quotes.forEach((quote) => {
    // For each quote in our "cargo shipment," add it to the batch.
    const docRef = db.collection("quotes").doc(); // Create a new document reference
    batch.set(docRef, {
      text_en: quote.text_en || "",
      text_hi: quote.text_hi || "",
      text_sa: quote.text_sa || "",
      source: quote.source || "Unknown",
    });
  });

  try {
    // Commit the entire batch to the database at once.
    await batch.commit();
    console.log(`Successfully added a batch of ${quotes.length} quotes.`);
    return {result: `Successfully added ${quotes.length} quotes.`};
  } catch (error) {
    console.error("Error writing batch of quotes to Firestore:", error);
    throw new HttpsError(
        "internal",
        "Failed to add batch of quotes.",
    );
  }
});
