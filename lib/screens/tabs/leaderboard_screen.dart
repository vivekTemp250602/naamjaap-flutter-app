import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:naamjaap/utils/constants.dart';

enum LeaderboardType { allTime, weekly }

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  LeaderboardType _selectedLeaderboard = LeaderboardType.allTime;
  final FirestoreService _firestoreService = FirestoreService();
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _adService.loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final bannerAd = _adService.bannerAd;

    return Scaffold(
      body: SafeArea(
        // NEW: We now wrap the main UI in a StreamBuilder to check if the user is premium.
        child: StreamBuilder<DocumentSnapshot>(
          stream: _firestoreService.getUserStatsStream(_currentUserId),
          builder: (context, userSnapshot) {
            // A simple loader while we check the user's premium status.
            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              // This is the new, beautiful empty state.
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 80,
                      color: Colors.amber.shade300,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "The Journey Begins",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Be the first to grace the leaderboard!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              );
            }
            final userData = userSnapshot.data!.data() as Map<String, dynamic>;
            final bool isPremium = userData['isPremium'] ?? false;

            // The main UI is now in a Column to hold the content and the ad.
            return Column(
              children: [
                // The existing leaderboard UI is now in an Expanded widget.
                Expanded(
                  child: Column(
                    children: [
                      // Toggle All-time and Weekly Leaderboard.
                      Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        elevation: 4,
                        shadowColor: Colors.deepOrange.withAlpha(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ToggleButtons(
                          isSelected: [
                            _selectedLeaderboard == LeaderboardType.allTime,
                            _selectedLeaderboard == LeaderboardType.weekly,
                          ],
                          onPressed: (index) {
                            setState(() {
                              _selectedLeaderboard = index == 0
                                  ? LeaderboardType.allTime
                                  : LeaderboardType.weekly;
                            });
                          },
                          borderRadius: BorderRadius.circular(12.0),
                          selectedBorderColor: Colors.deepOrange,
                          selectedColor: Colors.white,
                          fillColor: Colors.deepOrange.shade400,
                          color: Colors.deepOrange.shade400,
                          constraints: const BoxConstraints(minHeight: 48.0),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text('All-Time',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text('This Week',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _selectedLeaderboard ==
                                  LeaderboardType.allTime
                              ? _firestoreService.getLeaderboardStream()
                              : _firestoreService.getWeeklyLeaderboardStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong.'));
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('Leaderboard is empty.'));
                            }

                            final leaderboardDocs = snapshot.data!.docs;

                            return Stack(
                              children: [
                                ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 90.0),
                                  itemCount: leaderboardDocs.length,
                                  itemBuilder: (context, index) {
                                    final userDoc = leaderboardDocs[index];
                                    final userData =
                                        userDoc.data() as Map<String, dynamic>;
                                    final rank = index + 1;
                                    final isCurrentUser =
                                        userDoc.id == _currentUserId;

                                    final jappsCount = _selectedLeaderboard ==
                                            LeaderboardType.allTime
                                        ? (userData['total_japps'] ?? 0)
                                        : (userData['weekly_total_japps'] ?? 0);

                                    Widget card;
                                    if (rank <= 3) {
                                      card = _buildTopRankCard(context, rank,
                                          userData, isCurrentUser, jappsCount);
                                    } else {
                                      card = _buildStandardRankCard(
                                          context,
                                          rank,
                                          userData,
                                          isCurrentUser,
                                          jappsCount);
                                    }

                                    return GestureDetector(
                                      onTap: () => _showUserProfileDialog(
                                          context, userData),
                                      child: card
                                          .animate()
                                          .fadeIn(duration: 500.ms)
                                          .slideY(
                                              begin: 0.5,
                                              curve: Curves.easeOut),
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: _buildCurrentUserCard(
                                      _firestoreService,
                                      _currentUserId,
                                      leaderboardDocs),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // The Ad Banner (only shown for non-premium users)
                if (bannerAd != null && !isPremium)
                  Container(
                    alignment: Alignment.center,
                    width: bannerAd.size.width.toDouble(),
                    height: bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // --- HELPER WIDGETS AND METHODS ---
  void _showUserProfileDialog(
      BuildContext context, Map<String, dynamic> userData) {
    // Helper function to find the user's top mantra from the 'japps' map
    String getTopMantra(Map<String, dynamic>? jappsMap) {
      if (jappsMap == null || jappsMap.isEmpty) {
        return "No chants yet";
      }
      // Find the entry with the highest value
      final topMantraEntry =
          jappsMap.entries.reduce((a, b) => a.value > b.value ? a : b);
      // Convert the key (e.g., 'hare_krishna') back to a displayable name
      return AppConstants.mantras.firstWhere(
        (m) => m.toLowerCase().replaceAll(' ', '_') == topMantraEntry.key,
        orElse: () => "Unknown Mantra",
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.background,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(userData['photoURL'] ?? ''),
                ),
                const SizedBox(height: 16),
                Text(
                  userData['name'] ?? 'Anonymous',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // The new, beautiful stat chips
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.center,
                  children: [
                    Chip(
                      avatar: Icon(Icons.star, color: Colors.amber.shade700),
                      label:
                          Text('${userData['total_japps'] ?? 0} Total Japps'),
                    ),
                    Chip(
                      avatar: Icon(Icons.local_fire_department,
                          color: Colors.orange.shade800),
                      label:
                          Text('${userData['currentStreak'] ?? 0} Day Streak'),
                    ),
                    Chip(
                      avatar: const Icon(Icons.favorite, color: Colors.red),
                      label: Text(
                          'Top Mantra: ${getTopMantra(userData['japps'])}'),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.shield, color: Colors.blue),
                  title: const Text('Badges'),
                  subtitle: Text((userData['badges'] as List?)?.isEmpty ?? true
                      ? 'No badges yet'
                      : (userData['badges'] as List).join(', ')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Updated sticky card to show rank and progress
  Widget _buildCurrentUserCard(FirestoreService service, String uid,
      List<DocumentSnapshot> leaderboardDocs) {
    // Find current user's data and rank from the already fetched leaderboard list
    int currentUserRank = -1;
    DocumentSnapshot? currentUserDoc;
    for (int i = 0; i < leaderboardDocs.length; i++) {
      if (leaderboardDocs[i].id == uid) {
        currentUserRank = i + 1;
        currentUserDoc = leaderboardDocs[i];
        break;
      }
    }

    // Build the "Race to the Top" subtitle text
    String buildSubtitle() {
      if (currentUserRank == -1) return "Keep chanting to get on the board!";
      if (currentUserRank == 1) return "You're at the top! ✨";

      final currentUserData = currentUserDoc!.data() as Map<String, dynamic>;
      final userAboveDoc = leaderboardDocs[
          currentUserRank - 2]; // Rank is 1-based, index is 0-based
      final userAboveData = userAboveDoc.data() as Map<String, dynamic>;

      final japsNeeded = (userAboveData['total_japps'] ?? 0) -
          (currentUserData['total_japps'] ?? 0);
      return "$japsNeeded japps to pass ${userAboveData['name'] ?? '...'}!";
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.orange.shade800, width: 2)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              colors: [Colors.orange.shade100, Colors.orange.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange.shade800,
            child: Text(
              currentUserRank != -1 ? '#$currentUserRank' : '100+',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          title: const Text("Your Progress",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(buildSubtitle()),
        ),
      ),
    );
  }

  // Standard card for ranks 4+
  Widget _buildStandardRankCard(BuildContext context, int rank,
      Map<String, dynamic> userData, bool isCurrentUser, int jappsCount) {
    return Card(
      color: isCurrentUser ? Colors.orange.withOpacity(0.2) : null,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Text(
          '$rank',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        title: Text(userData['name'] ?? 'Anonymous'),
        subtitle: Text('$jappsCount japps'),
        trailing: CircleAvatar(
          backgroundImage: NetworkImage(userData['photoURL'] ?? ''),
        ),
      ),
    );
  }

  // Helper widget to build the fancy Top 3 cards
  Widget _buildTopRankCard(BuildContext context, int rank,
      Map<String, dynamic> userData, bool isCurrentUser, int jappsCount) {
    final List<Color> gradientColors;
    final IconData iconData;
    switch (rank) {
      case 1:
        gradientColors = [Colors.amber.shade600, Colors.amber.shade400];
        iconData = Icons.emoji_events;
        break;
      case 2:
        gradientColors = [Colors.grey.shade500, Colors.grey.shade300];
        iconData = Icons.emoji_events;
        break;
      case 3:
      default:
        gradientColors = [Colors.brown.shade500, Colors.brown.shade400];
        iconData = Icons.emoji_events;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border:
              isCurrentUser ? Border.all(color: Colors.white, width: 3) : null,
        ),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: Colors.white),
              Text(
                '$rank',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          title: Text(
            userData['name'] ?? 'Anonymous',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          subtitle: Text(
            '$jappsCount japps',
            style: TextStyle(color: Colors.white.withAlpha(200)),
          ),
          trailing: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(userData['photoURL'] ?? ''),
          ),
        ),
      ),
    );
  }
}
