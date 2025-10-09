import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/widgets/bodhi_tree_painter.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen>
    with AutomaticKeepAliveClientMixin {
  static const String _screenName = 'garden';
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _adService.loadAdForScreen(
      screenName: _screenName,
      onAdLoaded: () {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _adService.disposeAdForScreen(_screenName);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bannerAd = _adService.getAdForScreen(_screenName);

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: firestoreService.getUserStatsStream(uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: CircularProgressIndicator());
            }
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final int totalMalas = userData['total_malas'] ?? 0;
            final bool isPremium = userData['isPremium'] ?? false;

            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1a237e), Color(0xFF0d47a1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: CustomPaint(
                      painter: BodhiTreePainter(leafCount: totalMalas),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    '$totalMalas Malas Completed',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),

                // Ad Banner
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
      ),
    );
  }
}
