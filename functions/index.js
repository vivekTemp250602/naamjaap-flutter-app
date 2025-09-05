const admin = require("firebase-admin");
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {VertexAI} = require("@google-cloud/vertexai");

admin.initializeApp();
const db = admin.firestore();

// ===================================================================
// Function 1: Send Daily Reminder Notifications
// ===================================================================
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
// Function 3: Send the API-Powered Daily Quote
// ===================================================================
exports.sendDailyQuote = onSchedule({
  schedule: "0 7 * * *",
  timeZone: "Asia/Kolkata",
}, async (event) => {
  console.log("Running AI-powered daily quote function...");
  try {
    // 1. Initialize Vertex AI with your project details
    const vertexAI = new VertexAI({project: process.env.GCLOUD_PROJECT, location: "us-central1"});
    const model = "gemini-1.0-pro";

    // 2. Craft a powerful, specific prompt for the AI
    // eslint-disable-next-line max-len
    const prompt = `Act as a wise spiritual guide. Provide one profound, inspiring, and lesser-known quote from a sacred Hindu text like the Bhagavad Gita, the Upanishads, or the Puranas. The quote should be about devotion, mindfulness, or the nature of the self. Format your response as a JSON object with two keys: "text" for the quote, and "source" for its origin (e.g., "Bhagavad Gita 2.47"). Do not include markdown formatting like \`\`\`json.`;
    const generativeModel = vertexAI.getGenerativeModel({model: model});
    // 3. Send the prompt to Gemini
    const resp = await generativeModel.generateContent(prompt);
    const responseData = await resp.response;
    const content = responseData.candidates[0].content.parts[0].text;
    // 4. Parse the AI's JSON response
    const quoteJson = JSON.parse(content);

    const dailyQuote = {
      text: quoteJson.text,
      source: quoteJson.source,
    };

    // 5. Save and send the quote, just like before
    await db.collection("app_config").doc("daily_quote").set(dailyQuote);

    const payload = {
      notification: {
        title: "Wisdom for Your Day 🙏",
        body: `"${dailyQuote.text}" — ${dailyQuote.source}`,
      },
      topic: "daily_quote",
    };

    await admin.messaging().send(payload);
    console.log(`Successfully sent AI-generated daily quote: ${dailyQuote.source}`);
  } catch (error) {
    console.error("Error with Gemini AI or sending daily quote:", error);
  }
  return null;
});