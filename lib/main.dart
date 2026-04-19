import 'package:firebase_app_check/firebase_app_check.dart';
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
import 'package:naamjaap/services/local_quotes_service.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/services/local_notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await RemoteConfigService().initialize();

    await LocalQuotesService.init();

    LocaleProvider localeProvider = LocaleProvider();
    await localeProvider.loadSavedLocale();

    await LocalNotificationService().init();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ConnectivityService()),
          ChangeNotifierProvider.value(value: localeProvider),
        ],
        child: const NaamJaapApp(),
      ),
    );
  }, (error, stack) {
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

    return Consumer<LocaleProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: "Moksha Mala Jaap",
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
          // Cap text scale to 1.3x to prevent "Huge" system font from
          // breaking fixed-width containers across all screens.
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            final cappedTextScaler = mediaQuery.textScaler.clamp(
              minScaleFactor: 0.8,
              maxScaleFactor: 1.3,
            );
            return MediaQuery(
              data: mediaQuery.copyWith(textScaler: cappedTextScaler),
              child: child!,
            );
          },
        );
      },
    );
  }
}
