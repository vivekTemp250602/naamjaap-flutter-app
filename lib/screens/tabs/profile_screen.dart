import 'dart:io';
import 'dart:ui' as ui;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/screens/custom_mantra_editor.dart';
import 'package:naamjaap/screens/garden_screen.dart';
import 'package:naamjaap/screens/support_screen.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';
import 'package:naamjaap/services/storage_service.dart';
import 'package:naamjaap/widgets/share_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/services/ad_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final User _currentUser = FirebaseAuth.instance.currentUser!;
  final GlobalKey _shareCardKey = GlobalKey();
  late ConfettiController _sankalpaConfettiController;
  final _donationAmountController = TextEditingController();

  static const String _screenName = 'profile';
  final AdService _adService = AdService();

  Mantra? _selectedSankalpaMantra;
  DateTime? _selectedSankalpaDate;
  final _countController = TextEditingController();

  String _shareableName = '';
  int _shareableJapps = 0;
  bool _isUploading = false;
  bool _isCreatingSankalpa = false;

  @override
  void initState() {
    super.initState();
    _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        });

    _sankalpaConfettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _adService.disposeAdForScreen(_screenName);
    _donationAmountController.dispose();
    _countController.dispose();
    _sankalpaConfettiController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  // Grand Achievement Dialog
  void _showAchievementsDialog(List<dynamic> badges) {
    // A map to give our badges beautiful, thematic icons.
    final Map<String, IconData> badgeIcons = {
      // Japa Count Badges
      'First Mala': Icons.filter_vintage_rounded,
      'Sahasranama': Icons.whatshot_rounded,
      'Ten Thousand Steps': Icons.local_florist_rounded,
      'Lakshya Chanter': Icons.star_rounded,
      'Millionaire of Faith': Icons.diamond_rounded,
      // Streak Badges
      '7-Day Sadhana': Icons.calendar_view_week_rounded,
      '30-Day Devotion': Icons.calendar_month_rounded,
      'Sacred Centurion': Icons.looks_one_rounded,
      'Solar Cycle of Faith': Icons.wb_sunny_rounded,
      // Mala Completion Badges
      'Ekadashi Mala': Icons.spa_rounded,
      'Mala Master': Icons.school_rounded,
    };

    final Map<String, String> badgeDescriptions = {
      'First Mala': 'You completed your first 108 chants.',
      'Sahasranama': 'You have chanted one thousand names.',
      'Ten Thousand Steps': 'A significant step on your journey.',
      'Lakshya Chanter': 'You have completed one hundred thousand chants!',
      'Millionaire of Faith': 'An incredible milestone of one million chants.',
      '7-Day Sadhana': 'You have built a consistent 7-day practice.',
      '30-Day Devotion': 'A full month of dedication to your path.',
      'Sacred Centurion': 'You have completed 108 days of chanting.',
      'Solar Cycle of Faith': 'A full year of consistent devotion!',
      'Ekadashi Mala': 'You have completed 11 full malas.',
      'Mala Master': 'You have completed 108 full malas!',
    };

    showDialog(
        context: context,
        builder: (context) {
          // The Dialog is now larger and more spacious.
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.profile_yourAchievement),
            content: SizedBox(
              width: double.maxFinite,
              // The content is a ListView for a more elegant, scrollable list.
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: badges.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final badge = badges.reversed
                      .toList()[index]
                      .toString(); // Show most recent first

                  // The ListTile provides a clean, professional structure for each "plaque".
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    // The leading Icon is now dynamic based on the badge type.
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.primary.withAlpha(20),
                      child: Icon(
                        badgeIcons[badge] ?? Icons.shield_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    // The title and subtitle provide a clear hierarchy.
                    title: Text(badge,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(badgeDescriptions[badge] ??
                        AppLocalizations.of(context)!.profile_aMark),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.dialog_cancel),
              ),
            ],
          );
        });
  }

  // Upload Profile Image
  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    setState(() => _isUploading = true);
    try {
      final String downloadUrl =
          await _storageService.uploadProfilePicture(_currentUser.uid, image);
      await _firestoreService.updateUserProfilePicture(
          _currentUser.uid, downloadUrl);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.dialog_profilePictureUpdate)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(AppLocalizations.of(context)!.dialog_failedToUpload)));
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _triggerShare() async {
    // 1. FETCH the latest user data first.
    final userDoc = await _firestoreService.getUserDocument(_currentUser.uid);
    if (!userDoc.exists || !mounted) return;
    final data = userDoc.data() as Map<String, dynamic>;

    // 2. SET STATE to update the data inside the hidden widget.
    // This will cause the already-existing RepaintBoundary to repaint with new info.
    setState(() {
      _shareableName = data['name'] ?? 'A Chanter';
      _shareableJapps = data['total_japps'] ?? 0;
    });

    // 3. WAIT FOR THE NEXT FRAME (after the repaint) and then capture.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _captureAndShareImage();
    });
  }

  // NEW: Method to capture the widget as an image and share it
  Future<void> _captureAndShareImage() async {
    try {
      if (_shareCardKey.currentContext == null) {
        throw Exception(AppLocalizations.of(context)!.dialog_exceptionCard);
      }

      RenderRepaintBoundary boundary = _shareCardKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/naamjaap_progress.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)],
          text: AppLocalizations.of(context)!.dialog_checkoutMyProgress);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not share progress: ${e.toString()}')),
        );
      }
    }
  }

  // Method to show the dialog for editing the user's name.
  Future<void> _showEditNameDialog(String currentName) async {
    final TextEditingController nameController =
        TextEditingController(text: currentName);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.profile_changeName),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.profile_enterName),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.dialog_cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.dialog_save),
              onPressed: () {
                final newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  _firestoreService.updateUserName(_currentUser.uid, newName);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> _showDonationDialog() async {
  //   // Clear the controller in case it was used before
  //   _donationAmountController.clear();

  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       return AlertDialog(
  //         title: Text(AppLocalizations.of(context)!.profile_supportTitle),
  //         content: TextField(
  //           controller: _donationAmountController,
  //           keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //           decoration: const InputDecoration(
  //             labelText: 'Enter amount (INR)',
  //             prefixText: '₹',
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(AppLocalizations.of(context)!.dialog_cancel),
  //             onPressed: () => Navigator.of(dialogContext).pop(),
  //           ),
  //           ElevatedButton(
  //             child: const Text('Donate Now'),
  //             onPressed: () {
  //               final String amount = _donationAmountController.text;
  //               // Simple validation
  //               if (amount.isNotEmpty &&
  //                   double.tryParse(amount) != null &&
  //                   double.parse(amount) > 0) {
  //                 Navigator.of(dialogContext).pop(); // Close the dialog
  //                 _launchUPI(amount); // Launch UPI with the specified amount
  //               } else {
  //                 // Show a small error without closing
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                       content: Text('Please enter a valid amount.')),
  //                 );
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // // Exact UPI Launch Code
  // Future<void> _launchUPI(String amount) async {
  //   final String transactionId = 'TR${DateTime.now().millisecondsSinceEpoch}';

  //   // MODIFIED: The "am=" parameter is now dynamic
  //   final Uri upiUri = Uri.parse(
  //       'upi://pay?pa=vivek120303@okhdfcbank&pn=Vivek%20Tiwari&tr=$transactionId&tn=Support%20Naam%20Jaap&am=$amount&cu=INR');

  //   try {
  //     if (await canLaunchUrl(upiUri)) {
  //       await launchUrl(upiUri, mode: LaunchMode.externalApplication);
  //     } else {
  //       throw 'Could not launch UPI app.';
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text('Error: Could not find a UPI app to open.')),
  //       );
  //     }
  //   }
  // }

  // Share the app link.
  Future<void> _shareApp() async {
    // This is the link that you will replace after your app is live.
    const String appLink =
        "https://play.google.com/store/apps/details?id=com.vivek.naamjaap";
    const String message =
        "Come join me on a sacred journey with the Naam Jaap app! Download it here: $appLink";

    await Share.share(message);
  }

  Future<void> _signOut() async {
    await AudioService().stop();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  // Trigger the "Rate the App" prompt.
  Future<void> _requestReview() async {
    final Uri url = Uri.parse(
        "https://play.google.com/store/apps/details?id=com.vivek.naamjaap");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.dialog_couldNotOpenPS)),
        );
      }
    }
  }

  void _resetSankalpaEditor() {
    _countController.clear();
    _selectedSankalpaMantra = null;
    _selectedSankalpaDate = null;
  }

  // Delete Mantra Dialogs
  void _showDeleteMantraDialog(
      BuildContext context, MantraProvider provider, Mantra mantra) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!
            .profile_deleteMantra('{mantra.name}')),
        content: Text(AppLocalizations.of(context)!.profile_deleteMantraSure),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppLocalizations.of(context)!.dialog_cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              provider.deleteCustomMantra(mantra.id);
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              AppLocalizations.of(context)!.profile_yesDelete,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bannerAd = _adService.getAdForScreen(_screenName);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// Layer 3
            Transform.translate(
              offset: const Offset(-5000, 0),
              child: RepaintBoundary(
                key: _shareCardKey,
                child: ShareCard(
                    name: _shareableName, totalJapps: _shareableJapps),
              ),
            ),

            /// Layer 2
            StreamBuilder<DocumentSnapshot>(
              stream: _firestoreService.getUserStatsStream(_currentUser.uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting &&
                    !_isUploading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return Center(
                      child: Text(AppLocalizations.of(context)!
                          .profile_couldNotUserData));
                }

                final userData =
                    userSnapshot.data!.data() as Map<String, dynamic>;
                final bool isPremium = userData['isPremium'] ?? false;

                return Consumer<MantraProvider>(
                  builder: (context, mantraProvider, child) {
                    final customMantras = mantraProvider.allMantras
                        .where((m) => m.isCustom)
                        .toList();

                    return Column(
                      children: [
                        Expanded(
                          child: buildProfileView(userData, customMantras,
                              mantraProvider, isPremium),
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
                );
              },
            ),

            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _sankalpaConfettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.orange,
                  Colors.amber,
                  Colors.yellow,
                  Colors.white
                ],
                gravity: 0.2,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileView(
      Map<String, dynamic> userData,
      List<Mantra> customMantras,
      MantraProvider mantraProvider,
      bool isPremium) {
    final sankalpaData = userData['sankalpa'] as Map<String, dynamic>?;
    final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};
    final int totalMalas = userData['total_malas'] ?? 0;
    final List<dynamic> badges = userData['badges'] ?? [];

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Implement a Go Premium Icon Payment Gateway
        // if (!isPremium)
        //   Card(
        //     color: Colors.amber.shade100,
        //     child: ListTile(
        //       leading: const Icon(Icons.workspace_premium_rounded),
        //       title: const Text("Go Premium!"),
        //       subtitle: const Text("Remove all ads and support our mission."),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //       onTap: () {
        //         _firestoreService.grantPremiumAccess(_currentUser.uid);
        //       },
        //     ),
        //   ),

        // Garden Card
        Card(
          elevation: 4,
          shadowColor: Colors.green.withAlpha(80),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GardenScreen()));
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade50,
                    Colors.lightGreen.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.park_rounded,
                    size: 40,
                    color: Colors.green.shade800,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.profile_myBodhi,
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(AppLocalizations.of(context)!
                            .profile_myBodhiSubtitle),
                      ],
                    ),
                  ),
                  Text(
                    totalMalas.toString(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.energy_savings_leaf, color: Colors.green.shade700),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // Sankalpa Card
        if (_isCreatingSankalpa)
          _buildSankalpaEditorCard(mantraProvider.allMantras, jappsMap)
        else if (sankalpaData != null && sankalpaData['isActive'] == true)
          _buildSankalpaProgressCard(sankalpaData, jappsMap)
        else
          _buildSetSankalpaCard(),

        const SizedBox(
          height: 25,
        ),

        // User Profile Pic
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickAndUploadImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(userData['photoURL'] ?? ''),
                        backgroundColor: Colors.grey.shade300,
                      ),
                      if (_isUploading)
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      if (!_isUploading)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // USer Profile Contents
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        userData['name'] ?? 'Chanter',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit,
                          size: 20, color: Colors.grey.shade600),
                      onPressed: () =>
                          _showEditNameDialog(userData['name'] ?? ''),
                    ),
                  ],
                ),
                Text(
                  userData['email'] ?? 'No email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // --- Stats Card ---
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.profile_yourProgress,
                    style: Theme.of(context).textTheme.titleLarge),

                const Divider(height: 24),

                ListTile(
                  leading: Icon(Icons.local_fire_department_rounded,
                      color: Colors.orange.shade800),
                  title:
                      Text(AppLocalizations.of(context)!.profile_dailyStreak),
                  trailing: Text(
                    '${userData['currentStreak'] ?? 0} ${AppLocalizations.of(context)!.misc_days}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.star_border,
                      color: Theme.of(context).colorScheme.secondary),
                  title: Text(AppLocalizations.of(context)!.profile_totalJapps),
                  trailing: Text(
                    '${userData['total_japps'] ?? 0}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),

                // Live leaderboard to calculate the real rank.
                StreamBuilder<QuerySnapshot>(
                  stream: _firestoreService.getLeaderboardStream(),
                  builder: (context, leaderboardSnapshot) {
                    if (!leaderboardSnapshot.hasData) {
                      return ListTile(
                        leading: const Icon(Icons.leaderboard_outlined,
                            color: Colors.grey),
                        title: Text(
                            AppLocalizations.of(context)!.profile_globalRank),
                        trailing:
                            const CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    final docs = leaderboardSnapshot.data!.docs;
                    // Find the index (rank) of the current user in the leaderboard list.
                    final rank =
                        docs.indexWhere((doc) => doc.id == _currentUser.uid) +
                            1;

                    return ListTile(
                      leading: const Icon(Icons.leaderboard_outlined,
                          color: Colors.grey),
                      title: Text(
                          AppLocalizations.of(context)!.profile_globalRank),
                      trailing: Text(
                        rank > 0
                            ? '#$rank'
                            : '100+', // Show rank if found, else 100+
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Specific Mantra Japps
        Card(
          // A subtle gradient to give the card a soft, premium feel.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.profile_mantraTotals,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  if (userData['japps'] != null &&
                      (userData['japps'] as Map).isNotEmpty)
                    Column(
                      children: (userData['japps'] as Map<String, dynamic>)
                          .entries
                          .map((entry) {
                        final String mantraKey = entry.key;
                        final mantraCount = entry.value as int;
                        String mantraName;

                        try {
                          final mantra = mantraProvider.allMantras.firstWhere(
                            (m) => m.id == mantraKey,
                          );

                          mantraName = mantra.name;
                        } catch (error) {
                          mantraName = mantraKey;
                        }

                        // final mantraName = AppConstants.mantras.firstWhere(
                        //   (m) =>
                        //       m.toLowerCase().replaceAll(' ', '_') == entry.key,
                        //   orElse: () => entry.key,
                        // );

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // The Mantra Name - clean and simple.
                                  Text(
                                    mantraName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.grey.shade700,
                                        ),
                                  ),
                                  const Spacer(),
                                  // The Count - BIG, BOLD, and GOLDEN.
                                  Text(
                                    mantraCount.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Divider(color: Colors.grey.shade200, height: 1),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            AppLocalizations.of(context)!.profile_mantrasEmpty),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    AppLocalizations.of(context)!.profile_yourCustomMantra,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              if (customMantras.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(AppLocalizations.of(context)!.profile_noCustoms),
                ),
              ...customMantras.map((mantra) {
                return ListTile(
                  title: Text(mantra.name),
                  trailing: IconButton(
                    icon:
                        Icon(Icons.delete_outline, color: Colors.red.shade400),
                    onPressed: () => _showDeleteMantraDialog(
                        context, mantraProvider, mantra),
                  ),
                );
              }),
              const Divider(height: 1, indent: 16, endIndent: 16),
              ListTile(
                leading:
                    const Icon(Icons.add_circle_outline, color: Colors.green),
                title: Text(AppLocalizations.of(context)!.profile_addNewMantra),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (newContext) => ChangeNotifierProvider.value(
                              value: mantraProvider,
                              child: const CustomMantraEditor(),
                            )),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 24,
        ),

        // Share your progress - Share Naam Jaap - Rate Our App
        Card(
          child: Column(
            children: [
              // Share Progress
              ListTile(
                onTap: _triggerShare, // This is your existing "Share Progress"
                leading: Icon(Icons.photo_camera_front_outlined,
                    color: Theme.of(context).colorScheme.primary),
                title:
                    Text(AppLocalizations.of(context)!.profile_shareProgress),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),

              const Divider(height: 1, indent: 16, endIndent: 16),

              // Share
              ListTile(
                onTap: _shareApp, // This is the new "Share the App"
                leading: Icon(Icons.share, color: Colors.blue.shade600),
                title: Text(AppLocalizations.of(context)!.profile_shareApp),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),

              // Divider
              const Divider(height: 1, indent: 16, endIndent: 16),

              // Request Review
              ListTile(
                onTap: _requestReview, // This is the new "Rate the App"
                leading: Icon(Icons.star_outline_rounded,
                    color: Colors.amber.shade800),
                title: Text(AppLocalizations.of(context)!.profile_rateApp),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // --- Support Card ---
        Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SupportScreen()));
            },
            leading: const Icon(Icons.favorite_outline, color: Colors.red),
            title: Text(AppLocalizations.of(context)!.profile_supportTitle),
            subtitle:
                Text(AppLocalizations.of(context)!.profile_supportSubtitle),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),

        const SizedBox(height: 20),

        // Badge Card
        Card(
          child: InkWell(
            // InkWell provides the tap effect
            onTap: () {
              if (badges.isNotEmpty) {
                _showAchievementsDialog(badges);
              }
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(AppLocalizations.of(context)!.profile_achievements,
                          style: Theme.of(context).textTheme.titleLarge),
                      const Spacer(),
                      if (badges.isNotEmpty)
                        const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (badges.isEmpty)
                    Center(
                        child: Text(
                            AppLocalizations.of(context)!.profile_badgesEmpty))
                  else
                    // The "Preview Shelf" shows the 3 most recent badges.
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...badges.reversed.take(3).map((badge) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Chip(
                                  avatar: Icon(Icons.shield_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  label: Text(badge.toString()),
                                ),
                              )),
                          if (badges.length > 3)
                            Chip(
                              label: Text('+${badges.length - 3} more...'),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // ----- Sign Out Button -------
        ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: Text(AppLocalizations.of(context)!.settings_signOut),
          onPressed: _signOut,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSetSankalpaCard() {
    return Card(
      color: Colors.orange.shade50,
      child: ListTile(
        leading: Icon(Icons.flag_rounded,
            color: Theme.of(context).colorScheme.primary, size: 32),
        title: Text(AppLocalizations.of(context)!.profile_sankalpaSet),
        subtitle: Text(AppLocalizations.of(context)!.profile_sankalpaSubtitle),
        trailing: const Icon(Icons.add_circle_outline),
        onTap: () {
          setState(() {
            _isCreatingSankalpa = true;
          });
        },
      ),
    );
  }

  Widget _buildSankalpaEditorCard(
      List<Mantra> allMantras, Map<String, dynamic> jappsMap) {
    _selectedSankalpaMantra ??= allMantras.first; // Set default

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.dialog_sankalpaTitle,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            DropdownButtonFormField<Mantra>(
              initialValue: _selectedSankalpaMantra,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.dialog_sankalpaSelectMantra,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.book_outlined),
              ),
              items: allMantras.map((mantra) {
                return DropdownMenuItem(
                  value: mantra,
                  child: Text(mantra.name, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (mantra) {
                if (mantra != null) {
                  setState(() {
                    _selectedSankalpaMantra = mantra;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.dialog_sankalpaTargetCount,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.flag_outlined),
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: Colors.grey.shade400),
              ),
              leading: const Icon(Icons.calendar_today_outlined),
              title:
                  Text(AppLocalizations.of(context)!.dialog_sankalpaTargetDate),
              subtitle: Text(
                _selectedSankalpaDate == null
                    ? AppLocalizations.of(context)!.dialog_sankalpaSelectDate
                    : DateFormat('dd MMMM yyyy').format(_selectedSankalpaDate!),
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 30)),
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                );
                if (picked != null) {
                  setState(() {
                    _selectedSankalpaDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isCreatingSankalpa = false; // Cancel and swap back
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.dialog_cancel),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _saveSankalpa(jappsMap),
                  child: Text(
                      AppLocalizations.of(context)!.dialog_sankalpaSetPledge),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSankalpaProgressCard(
      Map<String, dynamic> sankalpa, Map<String, dynamic> jappsMap) {
    final mantraId = sankalpa['mantraId'] as String;
    final mantraName = sankalpa['mantraName'] as String;
    final targetCount = sankalpa['targetCount'] as int;
    final startCount = sankalpa['startCount'] as int;
    final endDate = (sankalpa['endDate'] as Timestamp).toDate();
    final daysRemaining =
        endDate.difference(DateTime.now()).inDays.clamp(0, 999);

    final int currentJapaCount = jappsMap[mantraId] as int? ?? startCount;

    // This is the logic based on your new idea
    final int goal = targetCount - startCount;
    final int progress = (currentJapaCount - startCount).clamp(0, goal);
    final double percentage =
        (goal == 0) ? 1.0 : (progress / goal).clamp(0.0, 1.0);

    // NEW: Check for completion
    final bool isComplete = progress >= goal;
    if (isComplete) {
      _sankalpaConfettiController.play();
    }

    return Card(
      elevation: 4,
      shadowColor: isComplete
          ? Colors.green.withAlpha(130)
          : Colors.orange.withAlpha(70),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.flag_rounded,
                    color: isComplete
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(AppLocalizations.of(context)!.profile_sankalpaTitle,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.delete_outline_rounded,
                      color: Colors.red.shade400, size: 24),
                  onPressed: () {
                    // THIS IS THE CRASH FIX
                    _firestoreService.removeSankalpa(_currentUser.uid);
                    setState(() {
                      _isCreatingSankalpa = false;
                      _resetSankalpaEditor();
                    });
                  },
                  tooltip: 'Abandon Vow',
                )
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: percentage,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade200,
                    color: isComplete
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary,
                  ),
                  Center(
                    child: isComplete
                        ? const Icon(Icons.check_circle,
                            color: Colors.green, size: 50)
                        : Text(
                            '${(percentage * 100).toStringAsFixed(0)}%',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.profile_sankalpaChanting} "),
                  TextSpan(
                    text: mantraName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isComplete
                  ? "Goal Complete!"
                  : AppLocalizations.of(context)!
                      .profile_sankalpaToReach(targetCount),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // THIS IS THE OVERFLOW FIX
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PROGRESS",
                          style: Theme.of(context).textTheme.labelSmall),
                      Text(
                        '$progress / $goal',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // Gutter between items
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("DEADLINE",
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(
                      isComplete ? "Achieved!" : '$daysRemaining days left',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSankalpa(Map<String, dynamic> jappsMap) async {
    // THIS IS THE NEW LOGIC (YOUR IDEA)
    final int? goalCount = int.tryParse(_countController.text);

    if (_selectedSankalpaMantra == null ||
        goalCount == null ||
        goalCount <= 0 ||
        _selectedSankalpaDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.dialog_sankalpaError)),
      );
      return;
    }

    final int startCount = jappsMap[_selectedSankalpaMantra!.id] as int? ?? 0;
    final int targetCount = startCount + goalCount; // Your new logic

    await _firestoreService.setSankalpa(
      uid: _currentUser.uid,
      mantra: _selectedSankalpaMantra!,
      targetCount: targetCount,
      endDate: _selectedSankalpaDate!,
      startCount: startCount,
    );

    if (mounted) {
      setState(() {
        _isCreatingSankalpa = false;
        _resetSankalpaEditor(); // THIS IS THE FIX
      });
    }
  }
}
