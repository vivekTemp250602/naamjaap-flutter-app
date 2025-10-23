import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/quote_card.dart';

class WisdomScreen extends StatefulWidget {
  const WisdomScreen({super.key});

  @override
  State<WisdomScreen> createState() => _WisdomScreenState();
}

class _WisdomScreenState extends State<WisdomScreen>
    with AutomaticKeepAliveClientMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  static const String _screenName = 'wisdom';
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        });
  }

  @override
  void dispose() {
    _adService.disposeAdForScreen(_screenName);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bannerAd = _adService.getAdForScreen(_screenName);

    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
        stream: _firestoreService.getUserStatsStream(_uid),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
            return const Center(child: CircularProgressIndicator());
          }
          final userData = userSnapshot.data!.data() as Map<String, dynamic>;
          final bool isPremium = userData['isPremium'] ?? false;
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: _firestoreService.getDailyQuoteStream(),
                      builder: (context, quoteSnapshot) {
                        if (quoteSnapshot.hasError ||
                            !quoteSnapshot.hasData ||
                            !quoteSnapshot.data!.exists) {
                          return QuoteCard(
                            textHI: AppConstants.defaultQuote['text_hi']!,
                            textEN: AppConstants.defaultQuote['text_en']!,
                            textSA: AppConstants.defaultQuote['text_sa']!,
                            source: AppConstants.defaultQuote['source']!,
                          );
                        }
                        final quoteData =
                            quoteSnapshot.data!.data() as Map<String, dynamic>;
                        return QuoteCard(
                          textHI: quoteData['text_hi'] ?? '...',
                          textEN: quoteData['text_en'] ?? '...',
                          textSA: quoteData['text_sa'] ?? '...',
                          source: quoteData['source'] ?? '...',
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (bannerAd != null &&
                  !isPremium &&
                  _adService.isAdLoadedForScreen(_screenName))
                Container(
                  alignment: Alignment.center,
                  width: bannerAd.size.width.toDouble(),
                  height: bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd),
                ),
            ],
          );
        },
      ),
    ));
  }
}
