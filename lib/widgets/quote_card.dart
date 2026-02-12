import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum QuoteLanguage { english, hindi, sanskrit }

class QuoteCard extends StatefulWidget {
  final String textEN, textHI, textSA, source;
  final Function(String quote, String source, String langCode) onShare;

  const QuoteCard({
    super.key,
    required this.textEN,
    required this.textHI,
    required this.textSA,
    required this.source,
    required this.onShare,
  });

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  QuoteLanguage _selectedLanguage = QuoteLanguage.hindi;

  @override
  Widget build(BuildContext context) {
    String displayText;
    String displayLangCode;

    switch (_selectedLanguage) {
      case QuoteLanguage.english:
        displayText = widget.textEN;
        displayLangCode = 'en';
        break;
      case QuoteLanguage.sanskrit:
        displayText = widget.textSA;
        displayLangCode = 'sa';
        break;
      case QuoteLanguage.hindi:
        displayText = widget.textHI;
        displayLangCode = 'hi';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF5), // Warm parchment
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
            color: const Color(0xFFFFD700).withOpacity(0.4), width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- HEADER: DECORATION + SHARE ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Decorative Element
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Share Button (Prominent)
                IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    widget.onShare(displayText, widget.source, displayLangCode);
                  },
                  icon:
                      const Icon(Icons.share_rounded, color: Colors.deepOrange),
                  tooltip: "Share Quote",
                ),
              ],
            ),
          ),

          // --- CONTENT AREA ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              children: [
                // Quote Text
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Text(
                    displayText,
                    key: ValueKey(displayText),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: _selectedLanguage == QuoteLanguage.english
                          ? 'Inter'
                          : 'NotoSansDevanagari',
                      fontSize: _selectedLanguage == QuoteLanguage.english
                          ? 18
                          : 22, // Larger font
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Source
                Text(
                  "— ${widget.source} —",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- LANGUAGE TABS (FULL WIDTH, BOLD) ---
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(22)),
              border: Border(top: BorderSide(color: Colors.orange.shade100)),
            ),
            child: Row(
              children: [
                _buildTab("Hindi", QuoteLanguage.hindi),
                Container(width: 1, height: 20, color: Colors.orange.shade200),
                _buildTab("English", QuoteLanguage.english),
                Container(width: 1, height: 20, color: Colors.orange.shade200),
                _buildTab("Sanskrit", QuoteLanguage.sanskrit),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, QuoteLanguage lang) {
    final bool isSelected = _selectedLanguage == lang;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _selectedLanguage = lang);
          },
          borderRadius: lang == QuoteLanguage.hindi
              ? const BorderRadius.only(bottomLeft: Radius.circular(22))
              : lang == QuoteLanguage.sanskrit
                  ? const BorderRadius.only(bottomRight: Radius.circular(22))
                  : BorderRadius.zero,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: isSelected ? BorderRadius.circular(12) : null,
                // Add a subtle shadow if selected to make it "pop"
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4)
                      ]
                    : null),
            margin: isSelected ? const EdgeInsets.all(4) : EdgeInsets.zero,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: isSelected ? Colors.deepOrange : Colors.brown.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
