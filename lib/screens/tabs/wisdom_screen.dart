import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/widgets/shareable_quote_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/quote_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ... [Keep WisdomSparkles and _Sparkle as is] ...
class WisdomSparkles extends CustomPainter {
  final AnimationController controller;
  final List<_Sparkle> sparkles = [];
  final math.Random random = math.Random();

  WisdomSparkles(this.controller) : super(repaint: controller) {
    for (int i = 0; i < 25; i++) {
      sparkles.add(_Sparkle(random));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var s in sparkles) {
      s.update(size.height);
      paint.color = Colors.white.withOpacity(s.opacity * 0.3);
      canvas.drawCircle(Offset(s.x * size.width, s.y), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Sparkle {
  late double x;
  late double y;
  late double speed;
  late double size;
  late double opacity;
  final math.Random rnd;

  _Sparkle(this.rnd) {
    reset(true);
  }

  void reset(bool startRandomY) {
    x = rnd.nextDouble();
    y = startRandomY ? rnd.nextDouble() * 400 : 400 + rnd.nextDouble() * 50;
    speed = 0.2 + rnd.nextDouble() * 0.5;
    size = 1.0 + rnd.nextDouble() * 2.0;
    opacity = 0.1 + rnd.nextDouble() * 0.5;
  }

  void update(double height) {
    y -= speed;
    if (y < -10) reset(false);
  }
}

class WisdomScreen extends StatefulWidget {
  const WisdomScreen({super.key});

  @override
  State<WisdomScreen> createState() => _WisdomScreenState();
}

class _WisdomScreenState extends State<WisdomScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final FirestoreService _firestoreService = FirestoreService();
  late final String _uid;
  static const String _screenName = 'wisdom';
  String _shareableLangCode = 'hi';
  final AdService _adService = AdService();

  late TabController _tabController;
  late final AnimationController _particleController;
  bool _isPremium = false;

  final GlobalKey _shareKey = GlobalKey();
  String _shareableQuote = "";
  String _shareableSource = "";
  bool _isCapturing = false;
  bool _isProcessingShare = false;

  // Tour key
  final GlobalKey _keyQuote = GlobalKey();

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    _tabController = TabController(length: 2, vsync: this);

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _loadAdAndPremiumStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startWisdomTour());
  }

  void _startWisdomTour() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenTour = prefs.getBool('has_seen_wisdom_tour') ?? false;

    if (!hasSeenTour) {
      // Wait for the stream to load data
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        ShowCaseWidget.of(context).startShowCase([_keyQuote]);
        await prefs.setBool('has_seen_wisdom_tour', true);
      }
    }
  }

  // 3. ADD HELPER
  Widget _buildShowcase({
    required GlobalKey key,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Showcase(
      key: key,
      title: title,
      description: description,
      targetShapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  // ... [Keep _loadAdAndPremiumStatus, dispose, wantKeepAlive, _onShareQuote] ...
  Future<void> _loadAdAndPremiumStatus() async {
    // If guest, always load ads
    if (_uid == 'guest') {
      _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        },
      );
      return;
    }

    final userDoc = await _firestoreService.getUserDocument(_uid);
    if (!userDoc.exists) return;

    final userData = userDoc.data() as Map<String, dynamic>;
    final bool isPremium = userData['isPremium'] ?? false;

    if (mounted) {
      setState(() {
        _isPremium = isPremium;
      });
    }

    if (!isPremium && mounted) {
      _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _particleController.dispose();
    _adService.disposeAdForScreen(_screenName);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _onShareQuote(
      String quote, String source, String langCode) async {
    if (_uid == 'guest') {
      ScaffoldMessenger.of(context).showSnackBar(
          // LOC: Sign in to share
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.wisdom_signin_to_share)));
      return;
    }

    setState(() {
      _shareableQuote = quote;
      _shareableSource = source;
      _isCapturing = true;
      _shareableLangCode = langCode;
      _isProcessingShare = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        RenderRepaintBoundary boundary = _shareKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;

        ui.Image image = await boundary.toImage(pixelRatio: 2.0);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null) throw Exception('Could not convert to ByteData');
        Uint8List pngBytes = byteData.buffer.asUint8List();

        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/shareable_quote.png').create();
        await file.writeAsBytes(pngBytes);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Wisdom from the Naam Jaap App',
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.dialog_failedToUpload)),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isCapturing = false;
            _isProcessingShare = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerAd = _adService.getAdForScreen(_screenName);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Divine Background
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

          // 2. Sparkles
          CustomPaint(painter: WisdomSparkles(_particleController)),

          // 3. Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    // LOC: Divine Wisdom
                    AppLocalizations.of(context)!.nav_wisdom,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),

                // Glassmorphic Tab Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.deepOrange,
                    unselectedLabelColor: Colors.white,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    dividerColor: Colors.transparent,
                    indicatorPadding: const EdgeInsets.all(4),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/peacock_feather.png',
                                height: 20),
                            const SizedBox(width: 8),
                            const Text('Gita'),
                          ],
                        ),
                      ),
                      const Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.architecture_rounded, size: 20),
                            SizedBox(width: 8),
                            const Text('Ramayana'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Content View
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildQuoteStream(
                        _firestoreService.getDailyGitaQuoteStream(),
                        AppConstants.defaultGitaQuote,
                        showcaseKey: _keyQuote,
                      ),
                      _buildQuoteStream(
                        _firestoreService.getDailyRamayanaQuoteStream(),
                        AppConstants.defaultRamayanaQuote,
                      ),
                    ],
                  ),
                ),

                // Ad Banner
                if (bannerAd != null &&
                    !_isPremium &&
                    _adService.isAdLoadedForScreen(_screenName))
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    width: bannerAd.size.width.toDouble(),
                    height: bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  ),

                const SizedBox(height: 65),
              ],
            ),
          ),

          // Hidden Layer for Sharing
          if (_isCapturing)
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width, 0),
              child: RepaintBoundary(
                key: _shareKey,
                child: ShareableQuoteTemplate(
                  quote: _shareableQuote,
                  source: _shareableSource,
                  langCode: _shareableLangCode,
                ),
              ),
            ),

          // Loading Overlay
          if (_isProcessingShare)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 16),
                    // LOC: Creating Card
                    Text(
                      AppLocalizations.of(context)!.wisdom_creating_card,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildGuestBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lock_outline_rounded,
                color: Colors.orange.shade800, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOC: Unlock Wisdom
                Text(
                  AppLocalizations.of(context)!.guest_mode_title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                // LOC: Sign in to save
                Text(
                  AppLocalizations.of(context)!.guest_mode_desc,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 0,
            ),
            // LOC: Sign In
            child: Text(AppLocalizations.of(context)!.guest_signin_btn),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildQuoteStream(
      Stream<DocumentSnapshot> stream, Map<String, String> defaultQuote,
      {GlobalKey? showcaseKey}) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        await Future.delayed(const Duration(seconds: 1));
      },
      color: Colors.deepOrange,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        physics: const BouncingScrollPhysics(),
        children: [
          if (_uid == 'guest') _buildGuestBanner(),
          StreamBuilder<DocumentSnapshot>(
            stream: stream,
            builder: (context, quoteSnapshot) {
              if (quoteSnapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                );
              }
              Map<String, dynamic> quoteData;
              if (quoteSnapshot.hasError ||
                  !quoteSnapshot.hasData ||
                  !quoteSnapshot.data!.exists) {
                quoteData = defaultQuote;
              } else {
                quoteData = quoteSnapshot.data!.data() as Map<String, dynamic>;
              }

              // Create the card
              Widget card = QuoteCard(
                textEN: quoteData['text_en'] ?? '...',
                textHI: quoteData['text_hi'] ?? '...',
                textSA: quoteData['text_sa'] ?? '...',
                source: quoteData['source'] ?? '...',
                onShare: (quote, source, langCode) =>
                    _onShareQuote(quote, source, langCode),
              ).animate().scale(
                  delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack);

              // 6. WRAP WITH SHOWCASE IF KEY EXISTS
              if (showcaseKey != null) {
                return _buildShowcase(
                  key: showcaseKey,
                  // LOC: Tour Title
                  title: AppLocalizations.of(context)!.tour_wisdom_card_title,
                  // LOC: Tour Desc
                  description:
                      AppLocalizations.of(context)!.tour_wisdom_card_desc,
                  child: card,
                );
              }

              return card;
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
