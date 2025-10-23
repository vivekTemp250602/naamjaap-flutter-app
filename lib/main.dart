import 'package:naamjaap/l10n/app_localizations.dart';
import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naamjaap/providers/locale_provider.dart';
import 'package:naamjaap/screens/animated_splash_screen.dart';
import 'package:naamjaap/services/connectivity_service.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // This is the main "async" function where we initialize everything.

  // --- STEP 1: INITIALIZE FLUTTER (Must be first) ---
  WidgetsFlutterBinding.ensureInitialized();

  // --- STEP 2: INITIALIZE FIREBASE (Must be second) ---
  // This is the "ignition key." We do this *outside* the error zone.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // --- STEP 3: SET UP THE ERROR HANDLERS (Now it's safe) ---
  // Now that Firebase is running, we can tell Crashlytics what to do.
  runZonedGuarded<Future<void>>(() async {
    // Set up the main Flutter error handler
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // Set up the platform error handler (for native crashes)
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // --- STEP 4: INITIALIZE OTHER CORE SERVICES ---
    await RemoteConfigService().initialize();

    // --- STEP 5: PREPARE PROVIDERS & SYSTEM UI ---
    LocaleProvider localeProvider = LocaleProvider();
    await localeProvider.loadSavedLocale();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // --- STEP 6: RUN THE APP ---
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ConnectivityService()),
          ChangeNotifierProvider.value(value: localeProvider),
        ],
        child: const NaamJaapApp(),
      ),
    );
  },
      // This is the "catch" block for any errors that happen *during* initialization.
      (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

class NaamJaapApp extends StatelessWidget {
  const NaamJaapApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.interTextTheme(
        Theme.of(context).textTheme,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        brightness: Brightness.light,
        primary: Colors.deepOrange.shade400,
        secondary: Colors.amber.shade600,
        surface: const Color(0xFFFFF8F0),
      ),
    );

    final localeProvider = Provider.of<LocaleProvider>(context);

    return OverlaySupport.global(
      child: Consumer<LocaleProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: "Naam Jaap",
            theme: theme,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeProvider.locale,
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) {
                return supportedLocales.first;
              }
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              if (locale.languageCode == 'bho') {
                return const Locale('hi');
              }
              return const Locale('en');
            },
            home: const AnimatedSplashScreen(),
          );
        },
      ),
    );
  }
}
