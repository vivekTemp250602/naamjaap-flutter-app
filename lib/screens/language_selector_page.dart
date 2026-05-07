import 'dart:math' as math;
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

    const Color goldenCopper = Color(0xFFC8860A);
    const Color goldenLight = Color(0xFFE8A928);

    return GestureDetector(
      onTap: () => setState(() => _selectedLocale = lang.locale),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFF8E8)
              : Colors.white.withOpacity(0.70),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? goldenCopper.withOpacity(0.70)
                : Colors.brown.withOpacity(0.08),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: goldenLight.withOpacity(0.20),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Language code badge
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFFFFD060), Color(0xFFC8860A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected ? null : Colors.grey.shade100,
                border: Border.all(
                  color: isSelected
                      ? goldenCopper.withOpacity(0.4)
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  lang.code,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.nativeName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? goldenCopper : Colors.brown.shade800,
                    ),
                  ),
                  Text(
                    lang.englishName,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? goldenCopper.withOpacity(0.65)
                          : Colors.brown.shade300,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFD060), Color(0xFFC8860A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                ),
              ),
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

    // Golden copper color constants for this screen
    const Color goldenCopper = Color(0xFFC8860A);
    const Color goldenLight = Color(0xFFE8A928);
    const Color goldenPale = Color(0xFFF5D67A);

    return Scaffold(
        // Cream-to-soft-pink gradient background
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFDF4EE), // warm cream at top
            Color(0xFFFAE8F0), // blush pink at bottom
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── SCREEN TITLE ──
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 4),
              child: Text(
                'Language Selector',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.brown.shade300,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // ── BURGUNDY VELVET LOGO HEADER ──
            SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Layer 1 – Full-width aura painter (cream-pink bg + golden center bloom)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _AuraPainter(),
                    ),
                  ),

                  // Layer 2 – Wide outermost halo (very faint warm gold, feathers to transparent)
                  Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFD4780A).withOpacity(0.12),
                          const Color(0xFFFFAA30).withOpacity(0.06),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.55, 1.0],
                      ),
                    ),
                  ),

                  // Layer 3 – Bright golden halo ring (catches the rim of the dark panel)
                  Container(
                    width: 162,
                    height: 162,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFFD060).withOpacity(0.30),
                          const Color(0xFFFFB020).withOpacity(0.14),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.60, 1.0],
                      ),
                    ),
                  ),

                  // Layer 4 – Feathered edge ring (blends dark panel edge into halo)
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF3D0F1E).withOpacity(0.0),
                          const Color(0xFF3D0F1E).withOpacity(0.0),
                          const Color(0xFF5C1A2E).withOpacity(0.18),
                          const Color(0xFF5C1A2E).withOpacity(0.60),
                          const Color(0xFF3D0F1E),
                        ],
                        stops: const [0.0, 0.55, 0.68, 0.78, 1.0],
                      ),
                    ),
                  ),

                  // Layer 5 – Core burgundy-maroon velvet panel with golden rim
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Deep rich maroon
                      gradient: RadialGradient(
                        center: const Alignment(0.0, -0.3),
                        radius: 1.1,
                        colors: [
                          const Color(
                              0xFF6B1F35), // lighter maroon highlight top
                          const Color(0xFF4A1020), // mid maroon
                          const Color(0xFF2E0A14), // deep dark base
                        ],
                        stops: const [0.0, 0.55, 1.0],
                      ),
                      // Thin gold-copper rim
                      border: Border.all(
                        color: const Color(0xFFD4A040).withOpacity(0.75),
                        width: 1.5,
                      ),
                      boxShadow: [
                        // Inner warm glow on rim
                        BoxShadow(
                          color: const Color(0xFFFFAA20).withOpacity(0.35),
                          blurRadius: 20,
                          spreadRadius: 0,
                        ),
                        // Depth shadow below panel
                        BoxShadow(
                          color: const Color(0xFF3D0F1E).withOpacity(0.55),
                          blurRadius: 18,
                          spreadRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    // Logo image inside the maroon velvet panel
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/images/app_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  // Layer 6 – Specular highlight (top-left glint on panel edge)
                  Positioned(
                    top: 48,
                    child: Container(
                      width: 28,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.30),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── GREETING & SUBTITLE ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        goldenCopper,
                        goldenLight,
                        goldenPale,
                        goldenCopper
                      ],
                      stops: const [0.0, 0.35, 0.65, 1.0],
                    ).createShader(bounds),
                    child: Text(
                      selectedLanguage.greeting,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // masked by ShaderMask
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: Color(0x44C8860A),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLocalizations.of(context)!.lang_chooseLang,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown.shade300,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 16),
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

            // ── GOLDEN CONTINUE BUTTON ──
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFCC44), Color(0xFFC8860A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC8860A).withOpacity(0.40),
                      blurRadius: 16,
                      spreadRadius: 0,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    localeProvider.setLocale(_selectedLocale, widget.uid);
                    if (widget.isFirstRun) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.dialog_continue,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      shadows: [
                        Shadow(
                          color: Color(0x44000000),
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                  ),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.02, 1.02),
                  duration: 1400.ms,
                  curve: Curves.easeInOut),
            ),
          ],
        ),
      ),
    ));
  }
}

// ── CUSTOM PAINTER: Cream-Pink Aura Background with Golden Bloom ──
class _AuraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.50);

    // Fill entire header with cream base
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFFDF4EE),
    );

    // Wide blush-pink wash across the whole header area
    final pinkWash = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.2,
        colors: [
          const Color(0xFFECC2CC).withOpacity(0.30), // soft rose-pink center
          const Color(0xFFF7D5DF).withOpacity(0.18),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), pinkWash);

    // Outer warm amber bloom (dissolves into the cream-pink)
    final outerBloom = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFCC44).withOpacity(0.14),
          const Color(0xFFFFAA30).withOpacity(0.08),
          Colors.transparent,
        ],
        stops: const [0.0, 0.50, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: size.width * 0.65),
      );
    canvas.drawCircle(center, size.width * 0.65, outerBloom);

    // Mid warm golden ring
    final midBloom = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFD060).withOpacity(0.22),
          const Color(0xFFFFB820).withOpacity(0.10),
          Colors.transparent,
        ],
        stops: const [0.0, 0.50, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: size.width * 0.38),
      );
    canvas.drawCircle(center, size.width * 0.38, midBloom);

    // Innermost bright golden core (right behind the dark panel's rim)
    final coreBloom = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFE840).withOpacity(0.25),
          const Color(0xFFFFCC44).withOpacity(0.12),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: size.width * 0.22),
      );
    canvas.drawCircle(center, size.width * 0.22, coreBloom);

    // Very subtle sacred geometry spokes — just perceivable
    final spokePaint = Paint()
      ..color = const Color(0xFFD4A040).withOpacity(0.035)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (math.pi / 180);
      canvas.drawLine(
        center,
        Offset(
          center.dx + math.cos(angle) * size.width * 0.62,
          center.dy + math.sin(angle) * size.width * 0.62,
        ),
        spokePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
