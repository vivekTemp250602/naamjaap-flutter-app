import 'dart:math' as math;
import 'package:flutter/material.dart';

class ShareableQuoteTemplate extends StatelessWidget {
  final String quote;
  final String source;
  final String langCode;

  const ShareableQuoteTemplate({
    super.key,
    required this.quote,
    required this.source,
    required this.langCode,
  });

  // 🧠 UPDATED INTELLIGENT SIZING (Bigger & Bolder)
  TextStyle _getDynamicTextStyle(String text, String langCode) {
    String fontFamily;
    double fontSize;
    double height;

    int length = text.length;

    switch (langCode) {
      case 'hi':
      case 'sa':
        fontFamily = 'NotoSansDevanagari';
        height = 1.5;
        break;
      case 'en':
      default:
        fontFamily = 'Serif';
        height = 1.3;
    }

    // 🔥 TWEAKED SIZES: Made everything larger
    if (length < 50) {
      fontSize = 70; // Massive impact for short lines
    } else if (length < 100) {
      fontSize = 52; // Very readable poster size
    } else if (length < 200) {
      fontSize = 42; // Standard reading size
    } else {
      fontSize = 34; // Dense text support
    }

    return TextStyle(
      fontFamily: fontFamily,
      color: const Color(0xFFFFE0B2), // Cream Gold
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      height: height,
      shadows: const [
        Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(2, 2))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width: 1080,
        height: 1920,
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.3,
                  colors: [
                    Color(0xFF5D1049), // Mystic Purple
                    Color(0xFF2E0422), // Deep Void
                    Color(0xFF000000), // Pure Black
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // 2. Sacred Mandala
            CustomPaint(
              painter: _StaticMandalaPainter(),
              size: Size.infinite,
            ),

            // 3. Golden Frame
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFFFD700).withOpacity(0.3),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            // 4. MAIN CONTENT AREA
            Positioned(
              top: 180,
              // 🔥 Reduced horizontal padding to give text more room
              left: 70,
              right: 70,
              bottom: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Icon
                  const Icon(Icons.format_quote_rounded,
                      size: 100, color: Color(0xFFFF8C00)),

                  const SizedBox(height: 30),

                  // THE QUOTE
                  Expanded(
                    child: Center(
                      child: Text(
                        quote,
                        textAlign: TextAlign.center,
                        style: _getDynamicTextStyle(quote, langCode),
                        softWrap: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Divider
                  Container(
                    width: 200,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(colors: [
                          Colors.transparent,
                          Color(0xFFFFD700),
                          Colors.transparent
                        ])),
                  ),

                  const SizedBox(height: 30),

                  // SOURCE
                  Text(
                    source.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Sans',
                      color: Colors.white70,
                      fontSize: 26, // Slightly larger source text
                      letterSpacing: 4,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            // 5. Footer Branding
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/app_logo_simple.png',
                    height: 110,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "NAAM JAAP",
                    style: TextStyle(
                      fontFamily: 'Serif',
                      color: Color(0xFFFFD700),
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticMandalaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 1; i <= 6; i++) {
      canvas.drawCircle(center, i * 150.0, paint);
    }

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (math.pi / 180);
      final p1 = center;
      final p2 = Offset(
        center.dx + math.cos(angle) * 1200,
        center.dy + math.sin(angle) * 1200,
      );
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
