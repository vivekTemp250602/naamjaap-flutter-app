import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:naamjaap/widgets/shareable_quote_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/quote_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';

class WisdomScreen extends StatefulWidget {
  const WisdomScreen({super.key});

  @override
  State<WisdomScreen> createState() => _WisdomScreenState();
}

class _WisdomScreenState extends State<WisdomScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  static const String _screenName = 'wisdom';
  String _shareableLangCode = 'hi';
  final AdService _adService = AdService();

  late TabController _tabController;
  bool _isPremium = false;

  final GlobalKey _shareKey = GlobalKey();
  String _shareableQuote = "";
  String _shareableSource = "";
  bool _isCapturing = false;

  // NEW: State variable for the in-UI spinner
  bool _isProcessingShare = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAdAndPremiumStatus();
  }

  Future<void> _loadAdAndPremiumStatus() async {
    final userDoc = await _firestoreService.getUserDocument(_uid);
    if (!userDoc.exists) return;

    final userData = userDoc.data() as Map<String, dynamic>;
    final bool isPremium = userData['isPremium'] ?? false;

    if (mounted) {
      setState(() {
        _isPremium = isPremium;
      });
    }

    if (!isPremium && mounted) {
      _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _adService.disposeAdForScreen(_screenName);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  // --- THIS IS THE "CAMERA" LOGIC (FINAL ROBUST VERSION) ---
  Future<void> _onShareQuote(
      String quote, String source, String langCode) async {
    // 1. Set state to show the hidden widget AND the spinner
    setState(() {
      _shareableQuote = quote;
      _shareableSource = source;
      _isCapturing = true;
      _shareableLangCode = langCode;
      _isProcessingShare = true; // Show the spinner
    });

    // 2. Wait for the next frame to build the widgets
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // 3. Find the "Photo Studio" using its key (it is now 100% built)
        RenderRepaintBoundary boundary = _shareKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;

        // 4. Take the "photo"
        ui.Image image = await boundary.toImage(pixelRatio: 2.0); // High-res
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null) throw Exception('Could not convert to ByteData');
        Uint8List pngBytes = byteData.buffer.asUint8List();

        // 5. Save the "photo" to a temporary file
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/shareable_quote.png').create();
        await file.writeAsBytes(pngBytes);

        // 6. Share the file
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Wisdom from the Naam Jaap App',
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Could not create shareable image. Please try again.')),
          );
        }
      } finally {
        // 7. ALWAYS clean up the UI
        if (mounted) {
          setState(() {
            _isCapturing = false;
            _isProcessingShare = false; // Hide the spinner
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerAd = _adService.getAdForScreen(_screenName);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // --- 1. The Visible UI ---
            Column(
              children: [
                // --- "Tribal Chief" Tab Bar ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withAlpha(200),
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: theme.colorScheme.primary,
                      indicator: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withAlpha(140),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/peacock_feather.png',
                                  height: 20),
                              const SizedBox(width: 8),
                              const Text('Gita'),
                            ],
                          ),
                        ),
                        const Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons
                                  .architecture_rounded), // Represents Rama's bow
                              SizedBox(width: 8),
                              Text('Ramayana'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildQuoteStream(
                        _firestoreService.getDailyGitaQuoteStream(),
                        AppConstants.defaultGitaQuote,
                      ),
                      _buildQuoteStream(
                        _firestoreService.getDailyRamayanaQuoteStream(),
                        AppConstants.defaultRamayanaQuote,
                      ),
                    ],
                  ),
                ),

                if (bannerAd != null &&
                    !_isPremium &&
                    _adService.isAdLoadedForScreen(_screenName))
                  Container(
                    alignment: Alignment.center,
                    width: bannerAd.size.width.toDouble(),
                    height: bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  ),
              ],
            ),

            // --- 2. The Hidden "Photo Studio" ---
            if (_isCapturing)
              Transform.translate(
                offset: Offset(MediaQuery.of(context).size.width, 0),
                child: RepaintBoundary(
                  key: _shareKey,
                  child: ShareableQuoteTemplate(
                    quote: _shareableQuote,
                    source: _shareableSource,
                    langCode: _shareableLangCode,
                  ),
                ),
              ),

            // --- 3. THE NEW "In-UI" Spinner ---
            if (_isProcessingShare)
              Container(
                color: Colors.black.withAlpha(130),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        // We use the l10n file to make our loading text translatable!
                        "Creating your beautiful image...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration:
                                TextDecoration.none, // Fix for text rendering
                            fontWeight:
                                FontWeight.normal // Fix for text rendering
                            ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteStream(
      Stream<DocumentSnapshot> stream, Map<String, String> defaultQuote) {
    // Wrapped in RefreshIndicator to allow manual refresh
    return RefreshIndicator(
      onRefresh: () async {
        // This is a bit of a hack since it's a stream, but calling setState
        // can sometimes force a rebuild if parameters changed.
        // Ideally, we'd reload the stream, but Firestore streams are live.
        // This is mostly for UX feedback.
        setState(() {});
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: stream,
            builder: (context, quoteSnapshot) {
              if (quoteSnapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              Map<String, dynamic> quoteData;
              if (quoteSnapshot.hasError ||
                  !quoteSnapshot.hasData ||
                  !quoteSnapshot.data!.exists) {
                quoteData = defaultQuote;
              } else {
                quoteData = quoteSnapshot.data!.data() as Map<String, dynamic>;
              }

              return QuoteCard(
                textEN: quoteData['text_en'] ?? '...',
                textHI: quoteData['text_hi'] ?? '...',
                textSA: quoteData['text_sa'] ?? '...',
                source: quoteData['source'] ?? '...',
                onShare: (quote, source, langCode) =>
                    _onShareQuote(quote, source, langCode),
              );
            },
          ),
        ],
      ),
    );
  }
}
