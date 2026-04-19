import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/locale_provider.dart';

// --- 1. Language Data Class ---
class Language {
  final Locale locale;
  final String nativeName;
  final String englishName;
  final String code;
  final String greeting; // The "Radhe Radhe" greeting in specific script

  const Language({
    required this.locale,
    required this.nativeName,
    required this.englishName,
    required this.code,
    required this.greeting,
  });
}

// --- 2. List of 22+ Languages with Radhe Radhe Greetings ---
final List<Language> allLanguages = [
  // Indian Languages
  const Language(
      locale: Locale('en'),
      nativeName: 'English',
      englishName: 'English',
      code: 'US',
      greeting: 'Radhe Radhe'),
  const Language(
      locale: Locale('hi'),
      nativeName: 'हिन्दी',
      englishName: 'Hindi',
      code: 'IN',
      greeting: 'राधे राधे'),
  const Language(
      locale: Locale('mr'),
      nativeName: 'मराठी',
      englishName: 'Marathi',
      code: 'IN',
      greeting: 'राधे राधे'),
  const Language(
      locale: Locale('gu'),
      nativeName: 'ગુજરાતી',
      englishName: 'Gujarati',
      code: 'IN',
      greeting: 'રાધે રાધે'),
  const Language(
      locale: Locale('pa'),
      nativeName: 'ਪੰਜਾਬੀ',
      englishName: 'Punjabi',
      code: 'IN',
      greeting: 'ਰਾਧੇ ਰਾਧੇ'),
  const Language(
      locale: Locale('bn'),
      nativeName: 'বাংলা',
      englishName: 'Bengali',
      code: 'BD',
      greeting: 'রাধে রাধে'),
  const Language(
      locale: Locale('ta'),
      nativeName: 'தமிழ்',
      englishName: 'Tamil',
      code: 'IN',
      greeting: 'রাধে রাধে'),
  const Language(
      locale: Locale('te'),
      nativeName: 'తెలుగు',
      englishName: 'Telugu',
      code: 'IN',
      greeting: 'రాధే రాధే'),
  const Language(
      locale: Locale('kn'),
      nativeName: 'ಕನ್ನಡ',
      englishName: 'Kannada',
      code: 'IN',
      greeting: 'ರಾಧೆ ರಾಧೆ'),
  const Language(
      locale: Locale('ml'),
      nativeName: 'മലയാളം',
      englishName: 'Malayalam',
      code: 'IN',
      greeting: 'രാധേ രാധേ'),
  const Language(
      locale: Locale('or'),
      nativeName: 'ଓଡ଼ିଆ',
      englishName: 'Odia',
      code: 'IN',
      greeting: 'ରାଧେ ରାଧେ'),
  const Language(
      locale: Locale('bh'),
      nativeName: 'भोजपुरी',
      englishName: 'Bhojpuri',
      code: 'IN',
      greeting: 'राधे राधे'),

  // International Languages
  const Language(
      locale: Locale('es'),
      nativeName: 'Español',
      englishName: 'Spanish',
      code: 'ES',
      greeting: 'Radhe Radhe'),
  const Language(
      locale: Locale('fr'),
      nativeName: 'Français',
      englishName: 'French',
      code: 'FR',
      greeting: 'Radhe Radhe'),
  const Language(
      locale: Locale('de'),
      nativeName: 'Deutsch',
      englishName: 'German',
      code: 'DE',
      greeting: 'Radhe Radhe'),
  const Language(
      locale: Locale('ru'),
      nativeName: 'Русский',
      englishName: 'Russian',
      code: 'RU',
      greeting: 'Радхе Радхе'),
  const Language(
      locale: Locale('zh'),
      nativeName: '中文',
      englishName: 'Chinese',
      code: 'CN',
      greeting: '拉德拉德'),
  const Language(
      locale: Locale('ja'),
      nativeName: '日本語',
      englishName: 'Japanese',
      code: 'JP',
      greeting: 'ラデラデ'),
  const Language(
      locale: Locale('ko'),
      nativeName: '한국어',
      englishName: 'Korean',
      code: 'KR',
      greeting: '라데 라데'),
];

// --- 3. The Page Widget ---
class LanguageSelectorPage extends StatefulWidget {
  final String uid;
  final bool isFirstRun;

  const LanguageSelectorPage({
    super.key,
    required this.uid,
    this.isFirstRun = false,
  });

  @override
  State<LanguageSelectorPage> createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  late Locale _selectedLocale;
  final _searchController = TextEditingController();
  List<Language> _filteredLanguages = [];
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _selectedLocale =
          Provider.of<LocaleProvider>(context, listen: false).locale ??
              Localizations.localeOf(context);
      _filteredLanguages = allLanguages;
      _searchController.addListener(_filterLanguages);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLanguages() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLanguages = allLanguages.where((lang) {
        return lang.nativeName.toLowerCase().contains(query) ||
            lang.englishName.toLowerCase().contains(query);
      }).toList();
    });
  }

  Widget _buildLanguageTile(Language lang) {
    final bool isSelected =
        lang.locale.languageCode == _selectedLocale.languageCode;

    return GestureDetector(
      onTap: () => setState(() => _selectedLocale = lang.locale),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepOrange.withOpacity(0.05)
              : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.deepOrange.shade400 : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected
                  ? Colors.deepOrange.shade100
                  : Colors.grey.shade300,
              child: Text(lang.code,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lang.nativeName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(lang.englishName,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.deepOrange.shade400),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final selectedLanguage = allLanguages.firstWhere(
      (lang) => lang.locale.languageCode == _selectedLocale.languageCode,
      orElse: () => allLanguages.first,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Column(
                children: [
                  // Branded Header with Glow
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Image.asset('assets/images/app_logo_simple.webp',
                        width: 90, height: 90),
                  ),
                  const SizedBox(height: 24),

                  // Dynamic Greeting
                  Text(
                    selectedLanguage.greeting,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.lang_chooseLang,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: AppLocalizations.of(context)!.lang_searchLang,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: _filteredLanguages.length,
                itemBuilder: (context, index) =>
                    _buildLanguageTile(_filteredLanguages[index]),
              ),
            ),

            // Pulsing Continue Button
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                onPressed: () {
                  localeProvider.setLocale(_selectedLocale, widget.uid);
                  if (widget.isFirstRun) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(AppLocalizations.of(context)!.dialog_continue,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.03, 1.03),
                  duration: 1200.ms,
                  curve: Curves.easeInOut),
            ),
          ],
        ),
      ),
    );
  }
}
