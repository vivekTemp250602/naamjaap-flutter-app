import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/widgets/bodhi_tree_painter.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ... [Keep AuroraPainter, FireflyPainter classes exactly as they are] ...
/// --------------------
/// AURORA / NEBULA SKY
/// --------------------
class AuroraPainter extends CustomPainter {
  final AnimationController controller;

  AuroraPainter(this.controller) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final t = controller.value * 2 * math.pi;

    // Deep night base
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF040B1F),
          Color(0xFF081A2F),
          Color(0xFF020917),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bgPaint);

    // Aurora waves
    for (int i = 0; i < 3; i++) {
      final path = Path();
      final baseY = size.height * (0.25 + i * 0.12);

      path.moveTo(0, baseY);
      for (double x = 0; x <= size.width; x += 18) {
        final y = baseY + math.sin((x / 120) + t + i) * 28;
        path.lineTo(x, y);
      }

      final auroraPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 90
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60)
        ..color = Color.lerp(
          Colors.greenAccent,
          Colors.tealAccent,
          i / 3,
        )!
            .withOpacity(0.15);

      canvas.drawPath(path, auroraPaint);
    }

    // Sacred glow behind tree
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.greenAccent.withOpacity(0.12),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height * 0.55),
          radius: size.width * 0.6,
        ),
      );

    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.55),
      size.width * 0.6,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// --------------------
/// FIREFLIES
/// --------------------
class FireflyPainter extends CustomPainter {
  final AnimationController controller;
  final List<_Firefly> fireflies = [];
  final math.Random random = math.Random();

  FireflyPainter(this.controller) : super(repaint: controller) {
    for (int i = 0; i < 40; i++) {
      fireflies.add(_Firefly(random));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var f in fireflies) {
      f.update(size.height, size.width);
      paint.color = const Color(0xFFFFD700).withOpacity(f.opacity * 0.8);
      canvas.drawCircle(Offset(f.x, f.y), f.size, paint);

      paint.color = const Color(0xFFFFD700).withOpacity(f.opacity * 0.3);
      canvas.drawCircle(Offset(f.x, f.y), f.size * 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Firefly {
  late double x, y, speedX, speedY, size, opacity;
  final math.Random rnd;

  _Firefly(this.rnd) {
    reset(true);
  }

  void reset(bool startRandom) {
    x = rnd.nextDouble() * 1000;
    y = startRandom ? rnd.nextDouble() * 1000 : 1000 + rnd.nextDouble() * 100;
    speedY = 0.3 + rnd.nextDouble() * 0.7;
    speedX = (rnd.nextDouble() - 0.5) * 0.5;
    size = 1.0 + rnd.nextDouble() * 1.5;
    opacity = 0.2 + rnd.nextDouble() * 0.8;
  }

  void update(double height, double width) {
    y -= speedY;
    x += speedX;
    if (y < -20 || x < -20 || x > width + 20) reset(false);
  }
}

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  static const String _screenName = 'garden';
  final AdService _adService = AdService();
  final FirestoreService _firestoreService = FirestoreService();

  late final String _uid;
  late final AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    _particleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();

    _adService.loadAdForScreen(
      screenName: _screenName,
      onAdLoaded: () => mounted ? setState(() {}) : null,
    );
  }

  @override
  void dispose() {
    _adService.disposeAdForScreen(_screenName);
    _particleController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerAd = _adService.getAdForScreen(_screenName);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // LOC: Bodhi Garden
        title: Text(AppLocalizations.of(context)!.garden_title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// AURORA BACKGROUND
          CustomPaint(painter: AuroraPainter(_particleController)),

          /// FIREFLIES
          CustomPaint(painter: FireflyPainter(_particleController)),

          /// TREE + STATS
          StreamBuilder<DocumentSnapshot>(
            stream: _firestoreService.getUserStatsStream(_uid),
            builder: (context, snapshot) {
              int totalMalas = 0;
              bool isPremium = false;

              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                totalMalas = data['total_malas'] ?? 0;
                isPremium = data['isPremium'] ?? false;
              }

              if (_uid == 'guest') totalMalas = 0;

              return Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 60, bottom: 120, left: 20, right: 20),
                      child: CustomPaint(
                        painter: BodhiTreePainter(leafCount: totalMalas),
                      ),
                    ).animate().fadeIn(duration: 1.seconds),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.85),
                          ],
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: BackdropFilter(
                                filter:
                                    ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.15)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // LOC: Spiritual Growth
                                        Text(
                                            AppLocalizations.of(context)!
                                                .garden_growth,
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                fontSize: 13)),
                                        const SizedBox(height: 6),
                                        // LOC: Malas
                                        Text(
                                            "$totalMalas ${AppLocalizations.of(context)!.misc_malas}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colors.greenAccent
                                                .withOpacity(0.2),
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.spa,
                                            color: Colors.greenAccent,
                                            size: 32),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (bannerAd != null &&
                                !isPremium &&
                                _adService.isAdLoadedForScreen(_screenName))
                              SizedBox(
                                width: bannerAd.size.width.toDouble(),
                                height: bannerAd.size.height.toDouble(),
                                child: AdWidget(ad: bannerAd),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
