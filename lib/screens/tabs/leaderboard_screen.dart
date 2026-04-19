import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

enum LeaderboardType { allTime, weekly }

class LeaderboardScreen extends StatefulWidget {
  final User? user;
  const LeaderboardScreen({super.key, this.user});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with AutomaticKeepAliveClientMixin {
  LeaderboardType _selectedLeaderboard = LeaderboardType.allTime;
  final FirestoreService _firestoreService = FirestoreService();
  late final String _currentUserId;
  static const String _screenName = 'leader';
  final AdService _adService = AdService();

  // Tour keys
  final GlobalKey _keyToggle = GlobalKey();
  final GlobalKey _keyPodium = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentUserId = widget.user?.uid ?? 'guest';

    if (widget.user != null) {
      _adService.loadAdForScreen(
          screenName: _screenName,
          onAdLoaded: () {
            if (mounted) setState(() {});
          });
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _startLeaderboardTour());
  }

  @override
  void dispose() {
    _adService.disposeAdForScreen(_screenName);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _startLeaderboardTour() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenTour =
        prefs.getBool('has_seen_leaderboard_tour') ?? false;

    if (!hasSeenTour) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        ShowCaseWidget.of(context).startShowCase([_keyToggle, _keyPodium]);
        await prefs.setBool('has_seen_leaderboard_tour', true);
      }
    }
  }

  Widget _buildShowcase({
    required GlobalKey key,
    required String title,
    required String description,
    required Widget child,
    ShapeBorder? shapeBorder,
  }) {
    return Showcase(
      key: key,
      title: title,
      description: description,
      targetShapeBorder: shapeBorder ?? const CircleBorder(),
      tooltipBackgroundColor: const Color(0xFF1A1A1A),
      textColor: Colors.white,
      titleTextStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
      descTextStyle: const TextStyle(fontSize: 14, color: Colors.white70),
      tooltipPadding: const EdgeInsets.all(20),
      tooltipBorderRadius: BorderRadius.circular(20),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerAd = _adService.getAdForScreen(_screenName);
    final isAdLoaded =
        bannerAd != null && _adService.isAdLoadedForScreen(_screenName);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // 1. Wrap the entire body in ONE StreamBuilder
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestoreService.getUserStatsStream(_currentUserId),
        builder: (context, userSnapshot) {
          bool isPremium = false;
          Map<String, dynamic>? userData;

          // Safely check if user data exists
          if (userSnapshot.hasData && userSnapshot.data!.exists) {
            userData = userSnapshot.data!.data() as Map<String, dynamic>;
            isPremium = userData['isPremium'] ?? false;
          }

          // 2. Determine Ad Visibility
          final bool showAd = !isPremium && isAdLoaded && widget.user != null;

          return Column(
            children: [
              // -------------------------------------------------------------
              // 1. THE AD SECTION
              // -------------------------------------------------------------
              if (showAd)
                Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      alignment: Alignment.center,
                      width: bannerAd.size.width.toDouble(),
                      height: bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: bannerAd),
                    ),
                  ),
                ),

              // -------------------------------------------------------------
              // 2. THE LEADERBOARD CONTENT
              // -------------------------------------------------------------
              Expanded(
                child: Stack(
                  children: [
                    // A. Gradient Background
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFF8C00),
                            Color(0xFFFF5E62),
                            Color(0xFF6A0572),
                          ],
                          stops: [0.0, 0.6, 1.0],
                        ),
                      ),
                    ),

                    // B. Main Content
                    SafeArea(
                      top: !showAd, // 🪄 THE FIX: Dynamic top padding!
                      child: Column(
                        children: [
                          _buildHeader(),
                          Expanded(
                            child: (widget.user == null || userData == null)
                                ? _buildGuestOrEmptyState()
                                : Column(
                                    children: [
                                      // Leaderboard List
                                      Expanded(
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: _selectedLeaderboard ==
                                                  LeaderboardType.allTime
                                              ? _firestoreService
                                                  .getLeaderboardStream()
                                              : _firestoreService
                                                  .getWeeklyLeaderboardStream(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white));
                                            }
                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return _buildEmptyState();
                                            }

                                            final docs = snapshot.data!.docs;

                                            return Stack(
                                              children: [
                                                CustomScrollView(
                                                  physics:
                                                      const BouncingScrollPhysics(
                                                          parent:
                                                              AlwaysScrollableScrollPhysics()),
                                                  slivers: [
                                                    SliverToBoxAdapter(
                                                      child: _buildPodium(docs),
                                                    ),
                                                    if (docs.length > 3)
                                                      SliverPadding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(16,
                                                                10, 16, 100),
                                                        sliver: SliverList(
                                                          delegate:
                                                              SliverChildBuilderDelegate(
                                                            (context, index) {
                                                              final realIndex =
                                                                  index + 3;
                                                              final doc = docs[
                                                                  realIndex];
                                                              return _buildRankTile(
                                                                  doc,
                                                                  realIndex +
                                                                      1);
                                                            },
                                                            childCount:
                                                                docs.length - 3,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                // Sticky Rank
                                                Positioned(
                                                  bottom: 55,
                                                  left: 20,
                                                  right: 20,
                                                  child: _buildStickyUserRank(
                                                      docs),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            // LOC: Leaderboard
            AppLocalizations.of(context)!.nav_leaderboard,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1),
          ),
        ),
        // LOC: Showcase Toggle
        _buildShowcase(
          key: _keyToggle,
          title: AppLocalizations.of(context)!.tour_leader_toggle_title,
          description: AppLocalizations.of(context)!.tour_leader_toggle_desc,
          shapeBorder: const StadiumBorder(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.1))),
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedAlign(
                    alignment: _selectedLeaderboard == LeaderboardType.allTime
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    child: Container(
                      width: constraints.maxWidth * 0.5,
                      height: double.infinity,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2))
                          ]),
                    ),
                  ),
                  Row(
                    children: [
                      // LOC: All Time & This Week
                      _buildToggleItem(
                          AppLocalizations.of(context)!.leaderboard_allTime,
                          LeaderboardType.allTime),
                      _buildToggleItem(
                          AppLocalizations.of(context)!.leaderboard_thisWeek,
                          LeaderboardType.weekly),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildToggleItem(String text, LeaderboardType type) {
    final isSelected = _selectedLeaderboard == type;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _selectedLeaderboard = type),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Colors.deepOrange
                  : Colors.white.withOpacity(0.9),
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }

  Widget _buildPodium(List<QueryDocumentSnapshot> docs) {
    if (docs.isEmpty) return const SizedBox.shrink();

    final first = docs[0];
    final second = docs.length > 1 ? docs[1] : null;
    final third = docs.length > 2 ? docs[2] : null;

    // LOC: Showcase Podium
    return _buildShowcase(
      key: _keyPodium,
      title: AppLocalizations.of(context)!.tour_leader_podium_title,
      description: AppLocalizations.of(context)!.tour_leader_podium_desc,
      shapeBorder:
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (second != null) _buildPodiumStep(second, 2, 130),
            _buildPodiumStep(first, 1, 170),
            if (third != null) _buildPodiumStep(third, 3, 110),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumStep(QueryDocumentSnapshot doc, int rank, double height) {
    final data = doc.data() as Map<String, dynamic>;
    final name = data['name'] ?? 'Anonymous';
    final photo = data['photoURL'];
    final japps = _selectedLeaderboard == LeaderboardType.allTime
        ? (data['total_japps'] ?? 0)
        : (data['weekly_total_japps'] ?? 0);
    final malas = (japps / 108).floor();

    Color color;
    Color crownColor;
    if (rank == 1) {
      color = const Color(0xFFFFD700);
      crownColor = Colors.amber.shade300;
    } else if (rank == 2) {
      color = const Color(0xFFC0C0C0);
      crownColor = Colors.grey.shade300;
    } else {
      color = const Color(0xFFCD7F32);
      crownColor = Colors.orange.shade200;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => _showUserProfileDialog(context, data),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (rank == 1)
              Icon(Icons.workspace_premium, color: crownColor, size: 36)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(begin: 0, end: -6, duration: 1.5.seconds)
                  .shimmer(duration: 2.seconds, color: Colors.white),

            const SizedBox(height: 5),

            Hero(
              tag: 'rank_avatar_${doc.id}',
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                    boxShadow: [
                      BoxShadow(color: color.withOpacity(0.4), blurRadius: 10)
                    ]),
                child: CircleAvatar(
                  radius: rank == 1 ? 38 : 28,
                  backgroundImage: (photo != null && photo.isNotEmpty)
                      ? NetworkImage(photo)
                      : null,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: (photo == null || photo.isEmpty)
                      ? Icon(Icons.person,
                          color: Colors.white70, size: rank == 1 ? 30 : 20)
                      : null,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              name.split(' ')[0],
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
            // LOC: Malas
            Text(
              "$malas ${AppLocalizations.of(context)!.misc_malas}",
              style:
                  TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11),
            ),

            const SizedBox(height: 8),

            Container(
              height: height,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color.withOpacity(0.6), color.withOpacity(0.1)]),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                border: Border(top: BorderSide(color: color, width: 4)),
              ),
              child: Center(
                child: Text(
                  "$rank",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Serif"),
                ),
              ),
            )
                .animate(onPlay: (c) => rank == 1 ? c.repeat() : null)
                .shimmer(
                    duration: 3.seconds,
                    delay: 1.seconds,
                    color: Colors.white.withOpacity(0.4))
                .animate()
                .slideY(
                    begin: 1,
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.easeOutBack),
          ],
        ),
      ),
    );
  }

  Widget _buildRankTile(QueryDocumentSnapshot doc, int rank) {
    final data = doc.data() as Map<String, dynamic>;
    final isMe = doc.id == _currentUserId;
    final japps = _selectedLeaderboard == LeaderboardType.allTime
        ? (data['total_japps'] ?? 0)
        : (data['weekly_total_japps'] ?? 0);
    final malas = (japps / 108).floor();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isMe
            ? Colors.white.withOpacity(0.25)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isMe ? Colors.white70 : Colors.white10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.2),
              border: Border.all(color: Colors.white12)),
          child: Text("$rank",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          data['name'] ?? 'Anonymous',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white12)),
          // LOC: Malas
          child: Text(
            "$malas ${AppLocalizations.of(context)!.misc_malas}",
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () => _showUserProfileDialog(context, data),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildStickyUserRank(List<QueryDocumentSnapshot> docs) {
    final index = docs.indexWhere((d) => d.id == _currentUserId);
    if (index == -1 && widget.user != null) return const SizedBox.shrink();

    final rank = index + 1;
    String name = "You";
    int malas = 0;
    if (index != -1) {
      final data = docs[index].data() as Map<String, dynamic>;
      final japps = _selectedLeaderboard == LeaderboardType.allTime
          ? (data['total_japps'] ?? 0)
          : (data['weekly_total_japps'] ?? 0);
      malas = (japps / 108).floor();
      name = data['name'] ?? "You";
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          // Fixed height to prevent bloating
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT SECTION: Rank Number (never shrinks)
              SizedBox(
                width: 50,
                child: Text(
                  index != -1 ? "#$rank" : "-",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(width: 8),

              // MIDDLE SECTION: Avatar + User Info (flexible, takes remaining space)
              Expanded(
                child: Row(
                  children: [
                    // Avatar (never shrinks)
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage: widget.user?.photoURL != null
                          ? NetworkImage(widget.user!.photoURL!)
                          : null,
                      child: widget.user?.photoURL == null
                          ? const Icon(Icons.person,
                              color: Colors.white70, size: 20)
                          : null,
                    ),

                    const SizedBox(width: 10),

                    // User Info (flexible, can shrink with ellipsis)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // LOC: Your Rank
                          Text(
                            AppLocalizations.of(context)!.leaderboard_yourRank,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              letterSpacing: 0.5,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // RIGHT SECTION: Score Pill (never shrinks)
              Container(
                constraints: const BoxConstraints(minWidth: 70),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.amber.withOpacity(0.5), width: 1.5),
                ),
                // LOC: Malas
                child: Text(
                  "$malas ${AppLocalizations.of(context)!.misc_malas}",
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuestOrEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_clock_rounded,
              size: 80, color: Colors.white.withOpacity(0.5)),
          const SizedBox(height: 20),
          // LOC: Guest Mode Strings
          Text(
            AppLocalizations.of(context)!.guest_mode_title,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.guest_mode_desc,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      // LOC: Is Empty
      child: Text(AppLocalizations.of(context)!.leaderboard_isEmpty,
          style: TextStyle(color: Colors.white.withOpacity(0.7))),
    );
  }

  void _showUserProfileDialog(
      BuildContext context, Map<String, dynamic> userData) {
    showDialog(
        context: context,
        builder: (context) {
          String getTopMantra(Map<String, dynamic>? jappsMap) {
            if (jappsMap == null || jappsMap.isEmpty) return "No chants";
            final topMantraEntry =
                jappsMap.entries.reduce((a, b) => a.value > b.value ? a : b);
            return AppConstants.mantras.firstWhere(
                (m) =>
                    m.toLowerCase().replaceAll(' ', '_') == topMantraEntry.key,
                orElse: () => "Unknown");
          }

          // --- 🪄 THE FIX: Dynamic Japps and Label based on the active tab ---
          final int displayJapps =
              _selectedLeaderboard == LeaderboardType.allTime
                  ? (userData['total_japps'] ?? 0)
                  : (userData['weekly_total_japps'] ?? 0);

          final String displayLabel = _selectedLeaderboard ==
                  LeaderboardType.allTime
              ? AppLocalizations.of(context)!.misc_japps // e.g., "Total Japps"
              : AppLocalizations.of(context)!
                  .leaderboard_thisWeek; // e.g., "This Week"

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20)
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: userData['photoURL'] != null
                            ? NetworkImage(userData['photoURL'])
                            : null,
                        backgroundColor: Colors.grey.shade200,
                        child: userData['photoURL'] == null
                            ? const Icon(Icons.person,
                                size: 50, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(userData['name'] ?? 'Unknown',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),

                      // Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // --- Apply the dynamic values here ---
                          _buildDialogStat(Icons.stars_rounded, "$displayJapps",
                              displayLabel, Colors.purple),
                          _buildDialogStat(
                              Icons.local_fire_department,
                              "${userData['currentStreak'] ?? 0}",
                              AppLocalizations.of(context)!
                                  .profile_dailyStreak, // LOC: Streak
                              Colors.deepOrange),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.favorite,
                                size: 16, color: Colors.blue),
                            const SizedBox(width: 8),
                            Flexible(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .leaderboard_topMantra(
                                            getTopMantra(userData['japps'])),
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.grey),
                          // LOC: Close
                          child:
                              Text(AppLocalizations.of(context)!.dialog_close))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildDialogStat(
      IconData icon, String val, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        Text(val,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
