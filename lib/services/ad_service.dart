import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdService {
  // Singleton setup: This ensures we only ever have one instance of AdService.
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  // We keep a reference to the ad so we can reuse it.
  BannerAd? get bannerAd => _bannerAd;

  // We use this flag to prevent multiple load attempts.
  bool get isAdLoaded => _isAdLoaded;

  // The Ad Unit ID getter remains the same.
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // IMPORTANT: Use the REAL ID for your release build.
      return 'ca-app-pub-6393216612155655/1745012576';
    }
    return '';
  }

  // The loading logic is now inside the singleton.
  void loadBannerAd() {
    // If an ad is already loaded or is in the process of loading, do nothing.
    if (_isAdLoaded && _bannerAd != null) {
      return;
    }

    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('$ad loaded.');
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          ad.dispose();
          _isAdLoaded = false;
        },
      ),
    )..load();
  }

  void dispose() {
    _bannerAd?.dispose();
    _isAdLoaded = false;
  }
}
