import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/utils/constants.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  late final AnimationController _titleController;
  late final AnimationController _bodyController;
  late final Animation<Offset> _titleOffset;
  late final Animation<Offset> _bodyOffset;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _bodyOpacity;

  final List<_TourPage> pages = [
    _TourPage(
      title: "Digital Japa Mala",
      body:
          "Tap to chant. We count your beads, track malas, and maintain your streak automatically.",
      asset: "assets/tour/tour_home.png",
    ),
    _TourPage(
      title: "Global Leaderboard",
      body:
          "Chant with thousands. Rise through spiritual progress and consistency.",
      asset: "assets/tour/tour_leaderboard.png",
    ),
    _TourPage(
      title: "Daily Wisdom",
      body:
          "Receive curated verses from ancient texts — available in multiple languages.",
      asset: "assets/tour/tour_wisdom.png",
    ),
    _TourPage(
      title: "Your Spiritual Journey",
      body:
          "Track milestones, set Sankalpas, and reflect on your growth and achievements.",
      asset: "assets/tour/tour_profile.png",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _bodyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );

    _titleOffset = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _titleController, curve: Curves.easeOut));
    _bodyOffset = Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _bodyController, curve: Curves.easeOut));

    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _titleController, curve: Curves.easeOut));
    _bodyOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _bodyController, curve: Curves.easeOut));

    // Kick off first page animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playEntranceAnimations();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _playEntranceAnimations() async {
    try {
      await _titleController.forward().orCancel;
      await Future.delayed(const Duration(milliseconds: 90));
      await _bodyController.forward().orCancel;
    } catch (_) {}
  }

  Future<void> _resetAndPlayAnimations() async {
    _titleController.reset();
    _bodyController.reset();
    await Future.delayed(const Duration(milliseconds: 80));
    await _playEntranceAnimations();
  }

  Future<void> _onDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsKeyHasSeenTour, true);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  void _onNext() {
    if (_pageIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOut,
      );
    } else {
      _onDone();
    }
  }

  void _onSkip() {
    _onDone();
  }

  Widget _buildGlowCard(String assetPath) {
    // A circular glow behind the rectangular image to create the halo effect
    return Stack(
      alignment: Alignment.center,
      children: [
        // Halo glow
        Container(
          width: 580,
          height: 580,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.deepOrange.shade200.withAlpha(43),
                Colors.deepOrange.shade200.withAlpha(8),
                Colors.transparent,
              ],
              stops: const [0.0, 0.35, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange.withAlpha(30),
                blurRadius: 80,
                spreadRadius: 12,
              )
            ],
          ),
        ),

        // The image card with rounded corners
        Container(
          width: 400,
          height: 480,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(23),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade50,
                Colors.orange.shade100.withAlpha(150),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              assetPath,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pages.length, (i) {
        final bool active = i == _pageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: active ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: active ? Colors.deepOrange : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(25),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.deepOrange.withAlpha(10),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF8F0),
              Color(0xFFFEF0E4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              // Top spacing so image sits comfortably
              const SizedBox(height: 12),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() => _pageIndex = index);
                    _resetAndPlayAnimations();
                  },
                  itemBuilder: (context, index) {
                    final p = pages[index];

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),

                          // Glow + Image
                          _buildGlowCard(p.asset),

                          const SizedBox(height: 22),

                          // Animated title
                          SlideTransition(
                            position: _titleOffset,
                            child: FadeTransition(
                              opacity: _titleOpacity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                child: Text(
                                  p.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.deepOrange.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Animated body
                          SlideTransition(
                            position: _bodyOffset,
                            child: FadeTransition(
                              opacity: _bodyOpacity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 6),
                                child: Text(
                                  p.body,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    height: 1.55,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Dots and controls
              Container(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDots(),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip
                        TextButton(
                          onPressed: _onSkip,
                          child: Text(
                            AppLocalizations.of(context)!.dialog_skip,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        // Next / Done
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _onNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _pageIndex == pages.length - 1
                                      ? AppLocalizations.of(context)!
                                          .dialog_getStarted
                                      : AppLocalizations.of(context)!
                                          .dialog_next,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                const SizedBox(width: 8),
                                if (_pageIndex < pages.length - 1)
                                  const Icon(Icons.arrow_forward_rounded,
                                      color: Colors.white, size: 20),
                                if (_pageIndex == pages.length - 1)
                                  const Icon(Icons.check, color: Colors.white)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TourPage {
  final String title;
  final String body;
  final String asset;

  _TourPage({
    required this.title,
    required this.body,
    required this.asset,
  });
}
