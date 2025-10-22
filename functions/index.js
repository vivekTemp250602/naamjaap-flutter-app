/* eslint-disable max-len */
const admin = require("firebase-admin");
const {onCall, HttpsError} = require("firebase-functions/v2/https");
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
  const now = new Date();
  const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  const todayTimestamp = admin.firestore.Timestamp.fromDate(today);

  // 3. Get all users who want reminders.
  const usersSnapshot = await db.collection("users")
      .where("settings.enableReminders", "==", true).get();

  if (usersSnapshot.empty) {
    console.log("No users with reminders enabled.");
    return null;
  }

  // 4. Create our three "mailing lists".
  const tokenLists = {
    "en": [],
    "hi": [],
    "sa": [],
  };

  // 5. This is your "Smart" logic: Sort users into the correct list.
  usersSnapshot.forEach((doc) => {
    const userData = doc.data();
    const lastChant = userData.lastChantDate;

    // Only add users who have NOT chanted today.
    if (userData.fcmToken && (!lastChant || lastChant < todayTimestamp)) {
      // Get their preferred language, defaulting to 'en'.
      const lang = (userData.settings && userData.settings.notificationLanguage) || "hi";
      if (tokenLists[lang]) {
        tokenLists[lang].push(userData.fcmToken);
      } else {
        // Fallback in case the language code is invalid
        tokenLists["hi"].push(userData.fcmToken);
      }
    }
  });

  // 6. Send the notifications to each group separately.
  try {
    for (const [lang, tokens] of Object.entries(tokenLists)) {
      if (tokens.length > 0) {
        const message = {
          notification: {
            title: messages[lang].title,
            body: messages[lang].body,
          },
          tokens: tokens,
        };
        const response = await admin.messaging().sendMulticast(message);
        console.log(`Successfully sent ${response.successCount} reminders in ${lang}.`);
        if (response.failureCount > 0) {
          console.error(`Failed to send ${response.failureCount} reminders in ${lang}.`);
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
  console.log("Running multilingual daily quote function...");
  try {
    // 1. Get a random quote from our library
    const quotesSnapshot = await db.collection("quotes").get();
    if (quotesSnapshot.empty) {
      console.log("No quotes found in the 'quotes' collection.");
      return null;
    }
    const quotes = quotesSnapshot.docs;
    const randomQuoteDoc = quotes[Math.floor(Math.random() * quotes.length)];
    const quote = randomQuoteDoc.data();

    if (!quote.text_en || !quote.text_hi || !quote.text_sa) {
      console.log("Quote is missing a translation. Skipping.");
      return null;
    }

    // 2. Save the quote to the public 'daily_quote' document (for the app)
    await db.collection("app_config").doc("daily_quote").set(quote);

    // 3. Create and send 3 different notifications to 3 different topics
    await admin.messaging().send({
      notification: {
        title: "Wisdom for Your Day 🙏",
        body: `"${quote.text_en}" — ${quote.source}`,
      },
      topic: "daily_quote_en",
    });
    await admin.messaging().send({
      notification: {
        title: "आज का ज्ञान 🙏",
        body: `"${quote.text_hi}" — ${quote.source}`,
      },
      topic: "daily_quote_hi",
    });
    await admin.messaging().send({
      notification: {
        title: "अद्यतनं ज्ञानम् 🙏",
        body: `"${quote.text_sa}" — ${quote.source}`,
      },
      topic: "daily_quote_sa",
    });

    console.log(`Successfully sent multilingual daily quote: ${quote.source}`);
  } catch (error) {
    console.error("Error sending multilingual quote:", error);
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
