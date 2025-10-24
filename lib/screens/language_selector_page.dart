import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

// --- 1. Language Data Class ---
class Language {
  final Locale locale;
  final String nativeName;
  final String englishName;
  final String code;

  const Language({
    required this.locale,
    required this.nativeName,
    required this.englishName,
    required this.code,
  });
}

// --- 2. Your List of All 24 Languages ---
final List<Language> allLanguages = [
  // Indian
  const Language(
      locale: Locale('en'),
      nativeName: 'English',
      englishName: 'English',
      code: 'US'),
  const Language(
      locale: Locale('hi'),
      nativeName: 'हिन्दी',
      englishName: 'Hindi',
      code: 'IN'),
  const Language(
      locale: Locale('ta'),
      nativeName: 'தமிழ்',
      englishName: 'Tamil',
      code: 'IN'),
  const Language(
      locale: Locale('bn'),
      nativeName: 'বাংলা',
      englishName: 'Bengali',
      code: 'BD'),
  const Language(
      locale: Locale('te'),
      nativeName: 'తెలుగు',
      englishName: 'Telugu',
      code: 'IN'),
  const Language(
      locale: Locale('mr'),
      nativeName: 'मराठी',
      englishName: 'Marathi',
      code: 'IN'),
  const Language(
      locale: Locale('gu'),
      nativeName: 'ગુજરાતી',
      englishName: 'Gujarati',
      code: 'IN'),
  const Language(
      locale: Locale('kn'),
      nativeName: 'ಕನ್ನಡ',
      englishName: 'Kannada',
      code: 'IN'),
  const Language(
      locale: Locale('ml'),
      nativeName: 'മലയാളം',
      englishName: 'Malayalam',
      code: 'IN'),
  const Language(
      locale: Locale('pa'),
      nativeName: 'ਪੰਜਾਬੀ',
      englishName: 'Punjabi',
      code: 'IN'),
  const Language(
      locale: Locale('or'),
      nativeName: 'ଓଡ଼ିଆ',
      englishName: 'Odia',
      code: 'IN'),
  const Language(
      locale: Locale('bho'),
      nativeName: 'भोजपुरी',
      englishName: 'Bhojpuri',
      code: 'IN'),

  // International
  const Language(
      locale: Locale('es'),
      nativeName: 'Español',
      englishName: 'Spanish',
      code: 'ES'),
  const Language(
      locale: Locale('fr'),
      nativeName: 'Français',
      englishName: 'French',
      code: 'FR'),
  const Language(
      locale: Locale('de'),
      nativeName: 'Deutsch',
      englishName: 'German',
      code: 'DE'),
  const Language(
      locale: Locale('zh'),
      nativeName: '中文',
      englishName: 'Chinese',
      code: 'CN'),
  const Language(
      locale: Locale('ja'),
      nativeName: '日本語',
      englishName: 'Japanese',
      code: 'JP'),
  const Language(
      locale: Locale('ko'),
      nativeName: '한국어',
      englishName: 'Korean',
      code: 'KR'),
  const Language(
      locale: Locale('ru'),
      nativeName: 'Русский',
      englishName: 'Russian',
      code: 'RU'),
];

// --- 3. The Page Widget ---
class LanguageSelectorPage extends StatefulWidget {
  final String uid;

  const LanguageSelectorPage({super.key, required this.uid});

  @override
  State<LanguageSelectorPage> createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  late Locale _selectedLocale;
  final _searchController = TextEditingController();
  List<Language> _filteredLanguages = [];
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

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

  // --- This is the custom list tile from your picture ---
  Widget _buildLanguageTile(Language lang) {
    final bool isSelected = lang.locale == _selectedLocale;

    return GestureDetector(
      onTap: () {
        // Update the *local* state to show the new selection
        setState(() {
          _selectedLocale = lang.locale;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.pink.withAlpha(5) : Colors.grey.withAlpha(10),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.pink, width: 1.5)
              : Border.all(color: Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            Text(
              lang.code,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.nativeName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Text(
                  lang.englishName,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.pink),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        // Use your localized string for the title
        title: Text(AppLocalizations.of(context)!.settings_language),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // The top icon and subtitle
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.language, size: 64, color: Colors.pink.shade300),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!
                        .settings_language, // Re-using title
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.lang_chooseLang,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: AppLocalizations.of(context)!.lang_searchLang,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withAlpha(10),
                ),
              ),
            ),

            // The scrollable list of languages
            Expanded(
              child: ListView.builder(
                itemCount: _filteredLanguages.length,
                itemBuilder: (context, index) {
                  return _buildLanguageTile(_filteredLanguages[index]);
                },
              ),
            ),

            // The "Continue" button
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.dialog_continue,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  final selectedLang = allLanguages.firstWhere(
                    (lang) => lang.locale == _selectedLocale,
                    orElse: () => allLanguages.first,
                  );

                  localeProvider.setLocale(_selectedLocale, widget.uid);

                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Language changed to ${selectedLang.nativeName}'),
                      backgroundColor: Colors.green.shade700,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
