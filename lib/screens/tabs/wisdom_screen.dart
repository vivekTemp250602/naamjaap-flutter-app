import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/quote_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class WisdomScreen extends StatefulWidget {
  const WisdomScreen({super.key});

  @override
  State<WisdomScreen> createState() => _WisdomScreenState();
}

class _WisdomScreenState extends State<WisdomScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  bool _isQuoteDismissedToday = false;
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _adService.loadBannerAd();
    _loadDismissalStatus();
  }

  @override
  void dispose() {
    _adService.dispose();
    super.dispose();
  }

  Future<void> _loadDismissalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDismissedDate = prefs.getString('lastQuoteDismissedDate') ?? '';
    final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (mounted) {
      setState(() {
        _isQuoteDismissedToday = lastDismissedDate == todayDate;
      });
    }
  }

  Future<void> _dismissQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setString('lastQuoteDismissedDate', todayDate);
    if (mounted) {
      setState(() {
        _isQuoteDismissedToday = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bannerAd = _adService.bannerAd;

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
                    if (!_isQuoteDismissedToday)
                      StreamBuilder<DocumentSnapshot>(
                        stream: _firestoreService.getDailyQuoteStream(),
                        builder: (context, quoteSnapshot) {
                          if (quoteSnapshot.hasError ||
                              !quoteSnapshot.hasData ||
                              !quoteSnapshot.data!.exists) {
                            return QuoteCard(
                              textEN: AppConstants.defaultQuote['text_en']!,
                              textHI: AppConstants.defaultQuote['text_hi']!,
                              textSA: AppConstants.defaultQuote['text_sa']!,
                              source: AppConstants.defaultQuote['source']!,
                            );
                          }
                          final quoteData = quoteSnapshot.data!.data()
                              as Map<String, dynamic>;
                          return Dismissible(
                            key: ValueKey(quoteData['source']),
                            onDismissed: (direction) => _dismissQuote(),
                            child: QuoteCard(
                              textEN: quoteData['text_en'] ?? '...',
                              textHI: quoteData['text_hi'] ?? '...',
                              textSA: quoteData['text_sa'] ?? '...',
                              source: quoteData['source'] ?? '...',
                            ),
                          );
                        },
                      )
                    else
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(48.0),
                          child: Text(
                            "Today's wisdom has been contemplated.\nA new insight will arrive tomorrow.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ),
                      ),

                    // This is the space for the future Bhagwat GPT!
                  ],
                ),
              ),
              if (bannerAd != null && !isPremium)
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
