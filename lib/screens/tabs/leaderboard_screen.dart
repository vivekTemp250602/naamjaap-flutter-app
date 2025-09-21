import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // The ToggleButtons UI for switching between views.
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              elevation: 4,
              shadowColor: Colors.deepOrange.withOpacity(0.2),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text('This Week',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // The StreamBuilder is wrapped in an Expanded widget to fill the remaining space.
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // The stream is now chosen dynamically based on our state variable.
                stream: _selectedLeaderboard == LeaderboardType.allTime
                    ? _firestoreService.getLeaderboardStream()
                    : _firestoreService.getWeeklyLeaderboardStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong.'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Leaderboard is empty.'));
                  }

                  final leaderboardDocs = snapshot.data!.docs;
                  final double topPadding =
                      kToolbarHeight + MediaQuery.of(context).padding.top;

                  return Stack(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.only(top: topPadding, bottom: 90.0),
                        itemCount: leaderboardDocs.length,
                        itemBuilder: (context, index) {
                          final userDoc = leaderboardDocs[index];
                          final userData =
                              userDoc.data() as Map<String, dynamic>;
                          final rank = index + 1;
                          final bool isCurrentUser =
                              userDoc.id == _currentUserId;

                          // Decide which japps count to display based on the selected tab
                          final jappsCount =
                              _selectedLeaderboard == LeaderboardType.allTime
                                  ? (userData['total_japps'] ?? 0)
                                  : (userData['weekly_total_japps'] ?? 0);

                          Widget card;
                          if (rank <= 3) {
                            card = _buildTopRankCard(context, rank, userData,
                                isCurrentUser, jappsCount);
                          } else {
                            card = _buildStandardRankCard(context, rank,
                                userData, isCurrentUser, jappsCount);
                          }

                          return GestureDetector(
                            onTap: () =>
                                _showUserProfileDialog(context, userData),
                            child: card
                                .animate()
                                .fadeIn(duration: 500.ms)
                                .slideY(begin: 0.5, curve: Curves.easeOut),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _buildCurrentUserCard(
                            _firestoreService, _currentUserId, leaderboardDocs),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
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
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.only(bottom: 24, left: 24, right: 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(userData['photoURL'] ?? ''),
              ),
              const SizedBox(height: 16),
              Text(
                userData['name'] ?? 'Anonymous',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Chip(
                avatar: Icon(Icons.star, color: Colors.amber.shade700),
                label: Text('${userData['total_japps'] ?? 0} Total Chants'),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Top Mantra'),
                subtitle: Text(getTopMantra(userData['japps'])),
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
