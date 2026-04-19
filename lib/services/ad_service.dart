// ignore_for_file: avoid_print
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  final Map<String, BannerAd?> _bannerAds = {};
  final Map<String, bool> _isAdLoaded = {};

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6393216612155655/1745012576';
      // return 'ca-app-pub-3940256099942544/6300978111';
    }
    return '';
  }

  /// Gets the ad for a specific screen.
  BannerAd? getAdForScreen(String screenName) {
    return _bannerAds[screenName];
  }

  /// Checks if the ad for a specific screen is loaded.
  bool isAdLoadedForScreen(String screenName) {
    return _isAdLoaded[screenName] ?? false;
  }

  /// Loads an ad for a specific screen, but only if it hasn't been loaded already.
  void loadAdForScreen({
    required String screenName,
    required Function() onAdLoaded,
  }) {
    // If an ad is already loaded or is in the process of loading for this screen, do nothing.
    if (_bannerAds.containsKey(screenName) && _bannerAds[screenName] != null) {
      return;
    }

    print("Loading ad for screen: $screenName");

    final ad = BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isAdLoaded[screenName] = true;
          onAdLoaded(); // Notify the UI to rebuild
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          _bannerAds.remove(screenName);
          _isAdLoaded[screenName] = false;
        },
      ),
    )..load();

    _bannerAds[screenName] = ad;
  }

  /// Disposes of a specific ad when a screen is permanently closed.
  void disposeAdForScreen(String screenName) {
    _bannerAds[screenName]?.dispose();
    _bannerAds.remove(screenName);
    _isAdLoaded[screenName] = false;
  }
}
