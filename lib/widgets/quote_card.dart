import 'package:flutter/material.dart';

enum QuoteLanguage { english, hindi, sanskrit }

class QuoteCard extends StatefulWidget {
  final String textEN, textHI, textSA, source;

  // NEW: A callback function to trigger the share
  final Function(String quote, String source, String langCode) onShare;

  const QuoteCard({
    super.key,
    required this.textEN,
    required this.textHI,
    required this.textSA,
    required this.source,
    required this.onShare, // NEW
  });

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  QuoteLanguage _selectedLanguage = QuoteLanguage.hindi;

  TextStyle _getQuoteTextStyle(QuoteLanguage language) {
    switch (language) {
      case QuoteLanguage.hindi:
      case QuoteLanguage.sanskrit:
        // Use Noto Sans Devanagari for clear Hindi/Sanskrit rendering
        return const TextStyle(
          fontFamily: 'NotoSansDevanagari',
          fontSize: 20,
          height: 1.7, // Slightly more height for Devanagari script
          fontStyle: FontStyle.italic,
          color: Colors.black87,
        );
      case QuoteLanguage.english:
        // Use Inter for English
        return const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          height: 1.6,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
        );
    }
  }

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

    return Card(
      elevation: 4,
      shadowColor: Colors.orange.withAlpha(80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(displayText,
                textAlign: TextAlign.center,
                style: _getQuoteTextStyle(_selectedLanguage)),
            const SizedBox(height: 16),
            Text(
              "— ${widget.source}",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
                fontSize: 15,
              ),
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  isSelected: [
                    _selectedLanguage == QuoteLanguage.hindi,
                    _selectedLanguage == QuoteLanguage.english,
                    _selectedLanguage == QuoteLanguage.sanskrit,
                  ],
                  onPressed: (index) {
                    setState(() {
                      // Corrected logic for 3 toggles
                      if (index == 0) _selectedLanguage = QuoteLanguage.hindi;
                      if (index == 1) _selectedLanguage = QuoteLanguage.english;
                      if (index == 2)
                        _selectedLanguage = QuoteLanguage.sanskrit;
                    });
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  children: const [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'हिन्दी',
                          style: TextStyle(
                              fontFamily: 'NotoSansDevanagari',
                              fontWeight: FontWeight.w600),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'English',
                          style: TextStyle(
                              fontFamily: 'Inter', fontWeight: FontWeight.w600),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Sanskrit',
                          style: TextStyle(
                              fontFamily: 'NotoSansDevanagari',
                              fontWeight: FontWeight.w600),
                        )),
                  ],
                ),

                // --- NEW: The Share Button ---
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.share,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    // We pass the *currently displayed* text to the share function
                    widget.onShare(displayText, widget.source, displayLangCode);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
