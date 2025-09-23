import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdService {
  BannerAd? bannerAd;

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6393216612155655/1745012576';
    }
    return '';
  }

  static String get realBannerAdUnitId {
    return 'ca-app-pub-6393216612155655/1745012576';
  }

  void loadBannerAd(
      {required Function(BannerAd) onAdLoaded, bool isTest = true}) {
    bannerAd = BannerAd(
      adUnitId: isTest ? bannerAdUnitId : realBannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('BannerAd loaded.');
          onAdLoaded(ad as BannerAd);
        },
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  void dispose() {
    bannerAd?.dispose();
  }
}
