import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LocalQuotesService {
  static List<dynamic> _gitaQuotes = [];
  static List<dynamic> _ramayanaQuotes = [];

  // This loads the files from your phone's storage into memory
  static Future<void> init() async {
    try {
      final gitaString =
          await rootBundle.loadString('assets/data/gita_quotes.json');
      _gitaQuotes = json.decode(gitaString);

      final ramayanaString =
          await rootBundle.loadString('assets/data/ramayana_quotes.json');
      _ramayanaQuotes = json.decode(ramayanaString);
    } catch (e) {
      // Silently handle error loading quotes
    }
  }

  static Map<String, dynamic> getTodaysGitaQuote() {
    if (_gitaQuotes.isEmpty) return _fallbackQuote();

    // Pick a quote based on the current day of the year (1-365)
    final dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
    return _gitaQuotes[dayOfYear % _gitaQuotes.length];
  }

  static Map<String, dynamic> getTodaysRamayanaQuote() {
    if (_ramayanaQuotes.isEmpty) return _fallbackQuote();

    final dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
    // Offset by 5 so it cycles differently than Gita
    return _ramayanaQuotes[(dayOfYear + 5) % _ramayanaQuotes.length];
  }

  static Map<String, dynamic> _fallbackQuote() {
    return {
      "text_en": "Meditate upon the Divine.",
      "text_hi": "भगवान का ध्यान करो।",
      "text_sa": "ईश्वरं ध्यायेत्।",
      "source": "Naam Jaap"
    };
  }
}
