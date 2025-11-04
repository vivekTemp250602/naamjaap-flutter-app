/* eslint-disable max-len */
const admin = require("firebase-admin");
const functions = require("firebase-functions");
const cors = require("cors")({origin: true});
const {onSchedule} = require("firebase-functions/v2/scheduler");

admin.initializeApp();
const db = admin.firestore();

// ===================================================================
// Function 1: Send Daily Reminder Notifications
// ===================================================================
exports.sendDailyReminders = onSchedule({
  schedule: "0 20 * * *", // 8:00 PM IST
  timeZone: "Asia/Kolkata",
}, async (event) => {
  console.log("Running intelligent, multilingual daily reminder function...");

  // 1. Define the 3 reminder messages
  const messages = {
    "en": {title: "A Gentle Reminder 🙏", body: "A gentle reminder to continue your spiritual journey today."},
    "hi": {title: "एक सौम्य अनुस्मारक 🙏", body: "आज अपनी आध्यात्मिक यात्रा जारी रखने के लिए एक सौम्य अनुस्मारक।"},
    "sa": {title: "एकः सौम्यः अनुस्मारकः 🙏", body: "अद्य भवतः आध्यात्मिकयात्रां निरन्तरं कर्तुं एकः सौम्यः अनुस्मारकः।"},
  };

  // 2. Get today's date for comparison.
  // This gets the start of the day in the IST timezone.
  const now = new Date(new Date().toLocaleString("en-US", {timeZone: "Asia/Kolkata"}));
  const today = new Date(now.getFullYear(), now.getMonth(), now.day);
  const todayTimestamp = admin.firestore.Timestamp.fromDate(today);

  // 3. Get all users who want reminders.
  const usersSnapshot = await db.collection("users")
      .where("settings.enableReminders", "==", true).get();

  if (usersSnapshot.empty) {
    console.log("No users with reminders enabled.");
    return null;
  }

  // 4. Create our three "mailing lists"
  const tokenLists = {"en": [], "hi": [], "sa": []};

  // 5. This is your "Smart" logic: Sort users into the correct list.
  usersSnapshot.forEach((doc) => {
    const userData = doc.data();
    const lastChant = userData.lastChantDate; // This is a Timestamp

    // ONLY add users who have NOT chanted today.
    if (userData.fcmToken && (!lastChant || lastChant.toMillis() < todayTimestamp.toMillis())) {
      // Get their preferred language, defaulting to 'en'.
      const lang = (userData.settings && userData.settings.notificationLanguage) || "en";
      if (tokenLists[lang]) {
        tokenLists[lang].push(userData.fcmToken);
      } else {
        tokenLists["en"].push(userData.fcmToken); // Fallback
      }
    }
  });

  // 6. Send the notifications to each group separately.
  try {
    for (const [lang, tokens] of Object.entries(tokenLists)) {
      if (tokens.length > 0) {
        // We must batch sends in groups of 500
        const tokenBatches = [];
        for (let i = 0; i < tokens.length; i += 500) {
          tokenBatches.push(tokens.slice(i, i + 500));
        }

        for (const batch of tokenBatches) {
          const message = {
            notification: {
              title: messages[lang].title,
              body: messages[lang].body,
            },
            tokens: batch,
          };
          const response = await admin.messaging().sendMulticast(message);
          console.log(`Successfully sent ${response.successCount} reminders in ${lang}.`);
        }
      } else {
        console.log(`No users to remind in ${lang}.`);
      }
    }
  } catch (error) {
    console.error("Error sending multilingual notifications:", error);
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
// Function 3: Send the Daily Quote (Multilingual)
// ===================================================================
exports.sendDailyQuote = onSchedule({
  schedule: "0 1 * * *", // 1:00 AM IST
  timeZone: "Asia/Kolkata",
}, async (event) => {
  console.log("Running 'Grand Library' daily quote function...");
  try {
    // --- 1. Get the Bhagavad Gita Quote ---
    const gitaQuotesSnapshot = await db.collection("quotes").get();
    if (gitaQuotesSnapshot.empty) {
      console.log("No quotes found in the 'quotes' (Gita) collection.");
    } else {
      const gitaQuotes = gitaQuotesSnapshot.docs;
      const randomGitaQuoteDoc = gitaQuotes[Math.floor(Math.random() * gitaQuotes.length)];
      const gitaQuote = randomGitaQuoteDoc.data();
      // Save it to its own document
      await db.collection("app_config").doc("daily_gita_quote").set(gitaQuote);
      console.log(`Successfully set daily Gita quote: ${gitaQuote.source}`);
    }

    // --- 2. Get the Ramayana Quote ---
    const ramayanaQuotesSnapshot = await db.collection("ramayana_quotes").get();
    if (ramayanaQuotesSnapshot.empty) {
      console.log("No quotes found in the 'ramayana_quotes' collection.");
    } else {
      const ramayanaQuotes = ramayanaQuotesSnapshot.docs;
      const randomRamayanaQuoteDoc = ramayanaQuotes[Math.floor(Math.random() * ramayanaQuotes.length)];
      const ramayanaQuote = randomRamayanaQuoteDoc.data();
      // Save it to its own, separate document
      await db.collection("app_config").doc("daily_ramayana_quote").set(ramayanaQuote);
      console.log(`Successfully set daily Ramayana quote: ${ramayanaQuote.source}`);
    }
    // --- 3. IMPORTANT: This function no longer sends a notification ---
    // This is now handled by your "Intelligent Reminder" function,
    // which is a much better user experience.

    console.log("Daily wisdom documents have been successfully updated.");
  } catch (error) {
    console.error("Error setting daily quotes:", error);
  }
  return null;
});


// ===================================================================
// Function 4: Add a New Quote to the Library from a Google Sheet
// ===================================================================
exports.addQuoteFromSheet = functions.https.onRequest(async (req, res) => {
  // Use CORS to allow requests from Google Sheets
  cors(req, res, async () => {
    // We only accept POST requests
    if (req.method !== "POST") {
      return res.status(405).send({error: "Method Not Allowed"});
    }

    try {
      // Get the data from the request body
      const data = req.body.data;
      // Get the collection name, default to 'quotes' if not provided
      const collectionName = req.body.collection || "quotes";

      const writeResult = await db.collection(collectionName).add({
        text_en: data.text_en,
        text_hi: data.text_hi || "",
        text_sa: data.text_sa || "",
        source: data.source,
      });

      console.log(`Successfully added quote with ID: ${writeResult.id}`);
      return res.status(200).send({result: `Quote added successfully: ${writeResult.id}`});
    } catch (error) {
      console.error("Error writing new quote:", error);
      return res.status(500).send({error: "Failed to add quote."});
    }
  });
});

// ===================================================================
// Function 5 (NEW HTTP VERSION)
// ===================================================================
exports.addQuotesInBatch = functions.https.onRequest(async (req, res) => {
  // Use CORS to allow requests from Google Sheets
  cors(req, res, async () => {
    // We only accept POST requests
    if (req.method !== "POST") {
      return res.status(405).send({error: "Method Not Allowed"});
    }

    try {
      // Get the data from the request body
      const quotes = req.body.data.quotes;
      // Get the collection name, default to 'quotes' if not provided
      const collectionName = req.body.collection || "quotes";

      if (!quotes || !Array.isArray(quotes) || quotes.length === 0) {
        return res.status(400).send({error: "Invalid argument: 'quotes' array is missing or empty."});
      }

      const batch = db.batch();
      quotes.forEach((quote) => {
        const docRef = db.collection(collectionName).doc();
        batch.set(docRef, {
          text_en: quote.text_en || "",
          text_hi: quote.text_hi || "",
          text_sa: quote.text_sa || "",
          source: quote.source || "Unknown",
        });
      });

      await batch.commit();
      console.log(`Successfully added batch of ${quotes.length} quotes.`);
      return res.status(200).send({result: `Successfully added ${quotes.length} quotes.`});
    } catch (error) {
      console.error("Error writing batch:", error);
      return res.status(500).send({error: "Failed to add batch of quotes."});
    }
  });
});
