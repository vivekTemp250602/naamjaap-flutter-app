/* eslint-disable max-len */
const admin = require("firebase-admin");
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
// Runs every day at 7:00 AM Indian Standard Time (IST).
exports.sendDailyQuote = onSchedule({
  schedule: "0 7 * * *",
  timeZone: "Asia/Kolkata",
  // NEW: Add a retry config for added resilience
  retryConfig: {
    retryCount: 3,
  },
}, async (event) => {
  console.log("Running resilient daily quote function...");
  try {
    // We will try up to 5 times to find a complete quote.
    for (let i = 0; i < 5; i++) {
      console.log(`Attempt ${i + 1} to find a complete quote...`);
      const curatedVerses = [
        {chapter: 2, verse: 47}, {chapter: 2, verse: 20}, {chapter: 4, verse: 7},
        {chapter: 9, verse: 22}, {chapter: 18, verse: 66}, {chapter: 12, verse: 14},
        {chapter: 3, verse: 27}, {chapter: 6, verse: 5},
      ];
      const randomVerseInfo = curatedVerses[Math.floor(Math.random() * curatedVerses.length)];
      const apiUrl = `https://bhagavadgita.io/slok/${randomVerseInfo.chapter}/${randomVerseInfo.verse}/`;
      const response = await fetch(apiUrl);
      if (!response.ok) {
        console.warn(`API call failed for verse ${randomVerseInfo.chapter}.${randomVerseInfo.verse}. Trying again.`);
        continue; // Skip to the next iteration of the loop
      }
      const quoteData = await response.json();

      const textEN = quoteData.siva && quoteData.siva.et ? quoteData.siva.et : null;
      const textHI = quoteData.tej && quoteData.tej.ht ? quoteData.tej.ht : null;
      const textSA = quoteData.transliteration;
      const source = `Bhagavad Gita ${quoteData.chapter}.${quoteData.verse}`;

      // If all three texts are valid, we have found our quote!
      if (textEN && textHI && textSA) {
        const dailyQuote = {
          text_en: textEN, text_hi: textHI, text_sa: textSA, source: source,
        };
        await db.collection("app_config").doc("daily_quote").set(dailyQuote);

        const payload = {
          notification: {
            title: "Wisdom for Your Day 🙏",
            body: `"${dailyQuote.text_en}" — ${dailyQuote.source}`,
          },
          topic: "daily_quote",
        };

        await admin.messaging().send(payload);
        console.log(`SUCCESS: Found and sent quote ${source} after ${i + 1} attempts.`);
        return null; // Exit the function successfully.
      }
    }

    // If the loop finishes without finding a complete quote
    console.error("Failed to find a complete quote after 5 attempts.");
  } catch (error) {
    console.error("A critical error occurred in sendDailyQuote function:", error);
  }
  return null;
});
