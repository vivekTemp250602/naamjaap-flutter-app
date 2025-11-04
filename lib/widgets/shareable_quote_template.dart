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

  TextStyle _getQuoteTextStyle(String langCode) {
    String fontFamily;
    switch (langCode) {
      case 'hi':
      case 'sa':
        fontFamily = 'NotoSansDevanagari';
      case 'en':
      default:
        fontFamily = 'Poppins';
    }

    return TextStyle(
      fontFamily: fontFamily,
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080,
      height: 1920,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0A1931), // Deep "Krishna" Blue
            Color(0xFF185ADB), // Bright Royal Blue
            Color(0xFFFFC947), // "Saffron" Gold
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withAlpha(150),
              width: 15,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          width: 1080 - (80 * 2),
          height: 1920 - (80 * 2),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 60.0, vertical: 100.0),
            child: Column(
              children: [
                // --- 1. CONTENT BLOCK (Quote + Source) ---
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // --- QUOTE (The Hero) ---
                      Flexible(
                        child: Text(
                          '"$quote"',
                          textAlign: TextAlign.center,
                          style: _getQuoteTextStyle(langCode),
                          overflow: TextOverflow.visible,
                          maxLines: 15,
                        ),
                      ),

                      // --- SPACER ---
                      const SizedBox(height: 45),

                      // --- SOURCE (Secondary Element) ---
                      Text(
                        "— $source",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white70,
                          fontSize: 18, // Larger for better hierarchy
                          fontWeight: FontWeight.w400, // Regular weight
                          fontStyle: FontStyle.italic, // Italicize the source
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  height: 2,
                ),

                const SizedBox(
                  height: 25,
                ),

                // --- 2. LOGO BLOCK (The Footer) ---
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0), // Adjusted padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/app_logo_simple.png',
                            height: 60,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(width: 60, height: 60);
                            },
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            "Naam Jaap",
                            // --- FIX 4: Adjusted logo text size ---
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
