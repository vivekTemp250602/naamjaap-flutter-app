import 'package:flutter/material.dart';

// An enum to make our language state clear and readable.
enum QuoteLanguage { english, hindi, sanskrit }

class QuoteCard extends StatefulWidget {
  final String textEN;
  final String textHI;
  final String textSA;
  final String source;

  const QuoteCard({
    super.key,
    required this.textEN,
    required this.textHI,
    required this.textSA,
    required this.source,
  });

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  // State variable to track the currently selected language.
  QuoteLanguage _selectedLanguage = QuoteLanguage.english;

  // Helper method to get the correct text based on the selected language.
  String get _displayText {
    switch (_selectedLanguage) {
      case QuoteLanguage.hindi:
        return widget.textHI;
      case QuoteLanguage.sanskrit:
        return widget.textSA;
      case QuoteLanguage.english:
      default:
        return widget.textEN;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            colors: [
              Colors.amber.shade100,
              Theme.of(context).colorScheme.background,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Text(
              '📜 Wisdom for Today 📜',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 16),
            // The main text now dynamically displays the selected language.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                '"$_displayText"',
                key: ValueKey<QuoteLanguage>(_selectedLanguage),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                  height: 1.5, // Improves readability for longer quotes
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '— ${widget.source}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const Divider(height: 24),
            // The new language toggle buttons.
            ToggleButtons(
              isSelected: [
                _selectedLanguage == QuoteLanguage.english,
                _selectedLanguage == QuoteLanguage.hindi,
                _selectedLanguage == QuoteLanguage.sanskrit,
              ],
              onPressed: (index) {
                setState(() {
                  _selectedLanguage = QuoteLanguage.values[index];
                });
              },
              borderRadius: BorderRadius.circular(8.0),
              selectedBorderColor: Colors.brown,
              selectedColor: Colors.white,
              fillColor: Colors.brown.shade400,
              color: Colors.brown.shade400,
              constraints: const BoxConstraints(minHeight: 36.0),
              children: const [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('English')),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('हिन्दी')),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Sanskrit')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
