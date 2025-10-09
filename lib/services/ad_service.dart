// ignore_for_file: avoid_print

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdService {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6393216612155655/1745012576';
    }
    return '';
  }

  static BannerAd createBannerAd() {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Ad loaded'),
        onAdFailedToLoad: (ad, error) {
          print('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }
}
