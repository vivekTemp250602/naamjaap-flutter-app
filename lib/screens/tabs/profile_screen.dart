import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:naamjaap/screens/tabs/settings_screen.dart';
import 'package:naamjaap/widgets/manual_japa_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/screens/custom_mantra_editor.dart';
import 'package:naamjaap/screens/garden_screen.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/support_screen.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/storage_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/share_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ... [Keep DivineSparkles and _Sparkle classes exactly as they are] ...
class DivineSparkles extends CustomPainter {
  final AnimationController controller;
  final List<_Sparkle> sparkles = [];
  final math.Random random = math.Random();

  DivineSparkles(this.controller) : super(repaint: controller) {
    for (int i = 0; i < 30; i++) {
      sparkles.add(_Sparkle(random));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var s in sparkles) {
      s.update(size.height);
      paint.color = Colors.white.withOpacity(s.opacity * 0.4);
      canvas.drawCircle(Offset(s.x * size.width, s.y), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Sparkle {
  late double x;
  late double y;
  late double speed;
  late double size;
  late double opacity;
  final math.Random rnd;

  _Sparkle(this.rnd) {
    reset(true);
  }

  void reset(bool startRandomY) {
    x = rnd.nextDouble();
    y = startRandomY ? rnd.nextDouble() * 400 : 400 + rnd.nextDouble() * 50;
    speed = 0.3 + rnd.nextDouble() * 0.8;
    size = 1.0 + rnd.nextDouble() * 2.0;
    opacity = 0.2 + rnd.nextDouble() * 0.6;
  }

  void update(double height) {
    y -= speed;
    if (y < -10) reset(false);
  }
}

class ProfileScreen extends StatefulWidget {
  final User? user;
  const ProfileScreen({super.key, this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final AdService _adService = AdService();
  static const String _screenName = 'profile';

  late final AnimationController _particleController;
  late ConfettiController _sankalpaConfettiController;
  final GlobalKey _shareCardKey = GlobalKey();

  final _countController = TextEditingController();
  Mantra? _selectedSankalpaMantra;
  DateTime? _selectedSankalpaDate;

  String _shareableName = '';
  int _shareableJapps = 0;
  bool _isUploading = false;
  bool _isCreatingSankalpa = false;

  // Tour Keys
  final GlobalKey _keyStats = GlobalKey();
  final GlobalKey _keyOffline = GlobalKey();
  final GlobalKey _keySankalpa = GlobalKey();
  final GlobalKey _keyBodhi = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _sankalpaConfettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    if (widget.user != null) {
      _adService.loadAdForScreen(
          screenName: _screenName,
          onAdLoaded: () {
            if (mounted) setState(() {});
          });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _startProfileTour());
  }

  @override
  void dispose() {
    _particleController.dispose();
    _sankalpaConfettiController.dispose();
    _adService.disposeAdForScreen(_screenName);
    _countController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  // --- ACTIONS ---

  void _startProfileTour() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenTour = prefs.getBool('has_seen_profile_tour') ?? false;

    if (!hasSeenTour) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        // FIX: Removed _keyBodhi and _keySankalpa
        // Only showing items visible at the top to prevent scrolling bugs
        ShowCaseWidget.of(context).startShowCase([_keyStats, _keyOffline]);

        await prefs.setBool('has_seen_profile_tour', true);
      }
    }
  }

  // Helper
  Widget _buildShowcase({
    required GlobalKey key,
    required String title,
    required String description,
    required Widget child,
    ShapeBorder? shapeBorder,
  }) {
    return Showcase(
      key: key,
      title: title,
      description: description,
      targetShapeBorder: shapeBorder ?? const CircleBorder(),
      tooltipBackgroundColor: const Color(0xFF1A1A1A),
      textColor: Colors.white,
      titleTextStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
      descTextStyle: const TextStyle(fontSize: 14, color: Colors.white70),
      tooltipPadding: const EdgeInsets.all(20),
      tooltipBorderRadius: BorderRadius.circular(20),
      child: child,
    );
  }

  // ... [Keep _pickAndUploadImage, _showEditNameDialog, _signOut, _triggerShare, _captureAndShareImage as is] ...
  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (image == null) return;

    setState(() => _isUploading = true);
    try {
      final String downloadUrl =
          await _storageService.uploadProfilePicture(widget.user!.uid, image);
      await _firestoreService.updateUserProfilePicture(
          widget.user!.uid, downloadUrl);
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.dialog_profilePictureUpdate)));
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(AppLocalizations.of(context)!.dialog_failedToUpload)));
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _showEditNameDialog(String currentName) async {
    final TextEditingController nameController =
        TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.profile_changeName),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.dialog_cancel)),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                _firestoreService.updateUserName(
                    widget.user!.uid, nameController.text.trim());
              }
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.dialog_save),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await AudioService().stopMantra();
    } catch (e) {}
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint("Sign out error: $e");
    }
  }

  Future<void> _triggerShare() async {
    final uid = widget.user!.uid;
    final userDoc = await _firestoreService.getUserDocument(uid);
    if (!userDoc.exists || !mounted) return;
    final data = userDoc.data() as Map<String, dynamic>;

    setState(() {
      _shareableName = data['name'] ?? 'A Chanter';
      _shareableJapps = data['total_japps'] ?? 0;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _captureAndShareImage();
    });
  }

  Future<void> _captureAndShareImage() async {
    try {
      if (_shareCardKey.currentContext == null) return;
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
    } catch (e) {/* handle error */}
  }

  // --- UI BUILDING BLOCKS ---

  Widget _buildDivineHeader(
      BuildContext context, Map<String, dynamic> userData) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ... [Keep Gradient and Particles] ...
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF8C00), // Dark Orange
                  Color(0xFFFF5E62), // Sunset Red
                  Color(0xFF6A0572), // Deep Mystic Purple
                ],
                stops: [
                  0.0,
                  0.6,
                  1.0
                ]),
          ),
        ),
        CustomPaint(painter: DivineSparkles(_particleController)),

        // 3. User Avatar & Info
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar with Pulsing Aura
                GestureDetector(
                  onTap: _pickAndUploadImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.1, 1.1),
                          duration: 2000.ms),
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5))
                            ]),
                        child: ClipOval(
                          child: (userData['photoURL'] != null &&
                                  userData['photoURL']!.isNotEmpty)
                              ? Image.network(userData['photoURL'],
                                  fit: BoxFit.cover)
                              : Container(
                                  color: Colors.white,
                                  child: const Icon(Icons.person,
                                      color: Colors.grey, size: 50)),
                        ),
                      ),
                      if (!_isUploading)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt,
                                size: 14, color: Colors.deepOrange),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userData['name'] ?? 'Chanter',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Colors.white70, size: 18),
                      onPressed: () =>
                          _showEditNameDialog(userData['name'] ?? ''),
                    )
                  ],
                ).animate().fadeIn().slideY(begin: 0.3, end: 0),
                Text(
                  userData['email'] ?? '',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ).animate().fadeIn(delay: 200.ms),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfflineJapaCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8C00), Color(0xFFFF5E62)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF5E62).withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              final mantraProvider =
                  Provider.of<MantraProvider>(context, listen: false);
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.8),
                builder: (_) => ChangeNotifierProvider.value(
                  value: mantraProvider,
                  child: ManualJapaDialog(uid: widget.user!.uid),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit_note_rounded,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LOC: Offline Title
                      Text(
                        AppLocalizations.of(context)!
                            .profile_offline_card_title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      // LOC: Offline Subtitle
                      Text(
                        AppLocalizations.of(context)!
                            .profile_offline_card_subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white54, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- THE STATS CARD (FIXED) ---
  Widget _buildStatsArray(Map<String, dynamic> userData) {
    final Timestamp? lastChantTs = userData['lastChantDate'];
    bool isToday = false;
    if (lastChantTs != null) {
      final now = DateTime.now();
      final date = lastChantTs.toDate();
      isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    }

    final int displayDailyCount = isToday ? (userData['daily_japps'] ?? 0) : 0;

    return Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0, 20, 0),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 25,
                  offset: const Offset(0, 10)),
            ],
          ),
          child: Column(
            children: [
              // TOP ROW: Streak | Global Rank
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSingleStat(
                      AppLocalizations.of(context)!
                          .profile_dailyStreak, // "Streak"
                      "${userData['currentStreak'] ?? 0}",
                      Icons.whatshot,
                      Colors.deepOrange),
                  Container(width: 1, height: 40, color: Colors.grey.shade200),
                  FutureBuilder<QuerySnapshot>(
                    future: _firestoreService.getLeaderboard(),
                    builder: (context, snapshot) {
                      String rankText = "-";
                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        final index =
                            docs.indexWhere((d) => d.id == widget.user!.uid);
                        rankText = index != -1 ? "#${index + 1}" : "50+";
                      }
                      return _buildSingleStat(
                          AppLocalizations.of(context)!
                              .profile_globalRank, // "Rank"
                          rankText,
                          Icons.emoji_events_rounded,
                          Colors.amber.shade700);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Divider(color: Colors.grey.shade100, height: 1),
              const SizedBox(height: 15),

              // BOTTOM ROW: Total Japps | Today's Japps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSingleStat(
                      AppLocalizations.of(context)!.misc_japps, // "Total Japps"
                      "${userData['total_japps'] ?? 0}",
                      Icons.stars_rounded,
                      Colors.purple),
                  Container(width: 1, height: 40, color: Colors.grey.shade200),
                  // NEW STAT: TODAY
                  _buildSingleStat("Today", "$displayDailyCount",
                      Icons.today_rounded, Colors.teal),
                ],
              ),
            ],
          ),
        )
            .animate()
            .scale(delay: 400.ms, duration: 400.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSingleStat(
      String label, String value, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.black87)),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.grey.shade500,
            letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildBodhiTreeCard(int totalMalas) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF56AB2F), Color(0xFFA8E063)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF56AB2F).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const GardenScreen())),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.park_rounded,
                      color: Colors.white, size: 36),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LOC: Bodhi
                      Text(AppLocalizations.of(context)!.profile_myBodhi,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      // LOC: Subtitle
                      Text(
                          AppLocalizations.of(context)!.profile_myBodhiSubtitle,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13)),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // LOC: Malas
                  child: Text(
                      "$totalMalas ${AppLocalizations.of(context)!.misc_malas}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF56AB2F))),
                )
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.1, end: 0);
  }

  // --- SANKALPA SECTION ---
  Widget _buildSankalpaCard(Map<String, dynamic> userData,
      MantraProvider provider, Map<String, dynamic> jappsMap) {
    final sankalpaData = userData['sankalpa'] as Map<String, dynamic>?;

    if (_isCreatingSankalpa) {
      _selectedSankalpaMantra ??= provider.allMantras.first;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.orange.shade100, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LOC: Create New Vow
            Text(AppLocalizations.of(context)!.profile_sankalpaSet,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              value: _selectedSankalpaMantra,
              items: provider.allMantras
                  .map((m) => DropdownMenuItem(value: m, child: Text(m.name)))
                  .toList(),
              onChanged: (m) => setState(() => _selectedSankalpaMantra = m),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                // LOC: Target Count
                labelText:
                    AppLocalizations.of(context)!.dialog_sankalpaTargetCount,
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              // LOC: Select Date
              title: Text(_selectedSankalpaDate == null
                  ? AppLocalizations.of(context)!.dialog_sankalpaSelectDate
                  : DateFormat('yyyy-MM-dd').format(_selectedSankalpaDate!)),
              trailing:
                  const Icon(Icons.calendar_month, color: Colors.deepOrange),
              tileColor: Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onTap: () async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 30)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 3650)));
                if (date != null) setState(() => _selectedSankalpaDate = date);
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () =>
                            setState(() => _isCreatingSankalpa = false),
                        // LOC: Cancel
                        child:
                            Text(AppLocalizations.of(context)!.dialog_cancel))),
                const SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => _saveSankalpa(jappsMap),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white),
                  // LOC: Commit
                  child: Text(
                      AppLocalizations.of(context)!.dialog_sankalpaSetPledge),
                )),
              ],
            )
          ],
        ),
      );
    } else if (sankalpaData != null && sankalpaData['isActive'] == true) {
      final mantraId = sankalpaData['mantraId'];
      final target = sankalpaData['targetCount'] as int;
      final start = sankalpaData['startCount'] as int;
      final current = jappsMap[mantraId] as int? ?? start;
      final goal = target - start;
      final progress = (current - start).clamp(0, goal);
      final percent = (goal == 0) ? 1.0 : (progress / goal).clamp(0.0, 1.0);
      final isDone = progress >= goal;
      if (isDone) _sankalpaConfettiController.play();

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.deepOrange.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 5))
          ],
          border: Border.all(color: Colors.deepOrange.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LOC: Sankalpa Title
                    Text(
                        AppLocalizations.of(context)!
                            .profile_sankalpaTitle
                            .toUpperCase(),
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.shade400,
                            letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text(sankalpaData['mantraName'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange.shade50,
                      borderRadius: BorderRadius.circular(10)),
                  child:
                      const Icon(Icons.flag_rounded, color: Colors.deepOrange),
                )
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6))),
                LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    height: 12,
                    width: constraints.maxWidth * percent,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                          colors: [Colors.orange.shade300, Colors.deepOrange]),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LOC: Percent
                Text(
                    "${(percent * 100).toInt()}% ${AppLocalizations.of(context)!.profile_achieved}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                Text("$progress / $goal",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600)),
              ],
            ),
            if (isDone)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _firestoreService.removeSankalpa(widget.user!.uid);
                    },
                    // LOC: Complete & Start New
                    child: Text(AppLocalizations.of(context)!.dialog_continue),
                  ),
                ),
              )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => setState(() => _isCreatingSankalpa = true),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange.shade50.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: Colors.orange.shade100, style: BorderStyle.solid),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Icon(Icons.add, color: Colors.orange.shade800),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LOC: Start Sankalpa
                  Text(AppLocalizations.of(context)!.profile_sankalpaSubtitle,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                  Text(AppLocalizations.of(context)!.profile_sankalpaSet,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  // ... [Keep _saveSankalpa] ...
  Future<void> _saveSankalpa(Map<String, dynamic> jappsMap) async {
    final count = int.tryParse(_countController.text);
    if (_selectedSankalpaMantra == null ||
        count == null ||
        _selectedSankalpaDate == null) return;

    final start = jappsMap[_selectedSankalpaMantra!.id] as int? ?? 0;
    await _firestoreService.setSankalpa(
      uid: widget.user!.uid,
      mantra: _selectedSankalpaMantra!,
      targetCount: start + count,
      endDate: _selectedSankalpaDate!,
      startCount: start,
    );
    setState(() {
      _isCreatingSankalpa = false;
      _countController.clear();
      _selectedSankalpaMantra = null;
      _selectedSankalpaDate = null;
    });
  }

  Widget _buildMantraBreakdown(
      Map<String, dynamic> jappsMap, MantraProvider provider) {
    // ... [Keep implementation, minimal localized strings here] ...
    // Mantra names come from DB or local consts
    if (jappsMap.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: jappsMap.length,
        itemBuilder: (context, index) {
          final mantraKey = jappsMap.keys.elementAt(index);
          final count = jappsMap[mantraKey];

          String mantraName = mantraKey;
          try {
            final mantra =
                provider.allMantras.firstWhere((m) => m.id == mantraKey);
            mantraName = mantra.name;
          } catch (e) {
            mantraName = mantraKey
                .replaceAll('_', ' ')
                .split(' ')
                .map((str) => str[0].toUpperCase() + str.substring(1))
                .join(' ');
          }

          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.orange.shade50]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$count",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepOrange)),
                const SizedBox(height: 4),
                Text(mantraName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- GRID WITH SETTINGS ADDED ---
  // --- GRID WITH SHARE APP BUTTON ADDED ---
  Widget _buildActionGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(builder: (context, constraints) {
        final double spacing = 15.0;
        final double width = (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            // 1. Share Progress (Image) - Changed Icon to 'Export' style
            _buildActionTile(
                width,
                AppLocalizations.of(context)!.profile_shareProgress,
                Icons.ios_share_rounded, // Changed to look like "Export Image"
                Colors.blue.shade50,
                Colors.blue.shade700,
                _triggerShare),

            // 2. Share App (Link) - NEW BUTTON
            _buildActionTile(
                width,
                AppLocalizations.of(context)?.profile_shareApp ?? "Share App",
                Icons.share_rounded, // Standard Share Icon
                Colors.teal.shade50,
                Colors.teal.shade700,
                () => Share.share(
                    "Chant. Connect. Transcend.\nDownload Naam Jaap: https://play.google.com/store/apps/details?id=com.vivek.naamjaap")),

            // 3. Rate App
            _buildActionTile(
                width,
                AppLocalizations.of(context)!.profile_rateApp,
                Icons.star_rounded,
                Colors.amber.shade50,
                Colors.amber.shade800,
                () => launchUrl(
                    Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.vivek.naamjaap"),
                    mode: LaunchMode.externalApplication)),

            // 4. Support
            _buildActionTile(
                width,
                AppLocalizations.of(context)!.profile_supportTitle,
                Icons.favorite_rounded,
                Colors.pink.shade50,
                Colors.pink.shade700,
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SupportScreen()))),

            // 5. Settings
            _buildActionTile(
                width,
                AppLocalizations.of(context)!.settings_title,
                Icons.settings_rounded,
                Colors.grey.shade200,
                Colors.grey.shade800,
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()))),

            // 6. Sign Out
            _buildActionTile(
                width,
                AppLocalizations.of(context)!.settings_signOut,
                Icons.logout_rounded,
                Colors.red.shade50,
                Colors.red.shade700,
                _signOut),
          ],
        );
      }),
    );
  }

  Widget _buildActionTile(double width, String title, IconData icon, Color bg,
      Color accent, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade200)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(icon, color: accent, size: 24),
              ),
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  // --- MAIN BUILD ---

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerAd = _adService.getAdForScreen(_screenName);

    // 1. GUEST MODE
    if (widget.user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_person_rounded,
                  size: 100, color: Colors.grey.shade300),
              const SizedBox(height: 20),
              // LOC: Guest
              Text(AppLocalizations.of(context)!.guest_mode_title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              // LOC: Desc
              Text(AppLocalizations.of(context)!.guest_mode_desc,
                  style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (r) => false),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                // LOC: Sign In
                child: Text(AppLocalizations.of(context)!.guest_signin_btn),
              )
            ],
          ),
        ),
      );
    }

    // 2. SIGNED IN USER
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(-5000, 0),
            child: RepaintBoundary(
                key: _shareCardKey,
                child: ShareCard(
                    name: _shareableName, totalJapps: _shareableJapps)),
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: _firestoreService.getUserStatsStream(widget.user!.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());

              final userData = snapshot.data!.data() as Map<String, dynamic>;
              final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};
              final bool isPremium = userData['isPremium'] ?? false;

              return Consumer<MantraProvider>(
                builder: (context, provider, _) {
                  return CustomScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 400,
                        pinned: true,
                        stretch: true,
                        backgroundColor: const Color(0xFFFF5E62),
                        flexibleSpace: FlexibleSpaceBar(
                          background: _buildDivineHeader(context, userData),
                          stretchModes: const [
                            StretchMode.zoomBackground,
                            StretchMode.blurBackground
                          ],
                        ),
                      ),

                      // LOC: Showcase Stats
                      SliverToBoxAdapter(
                        // child: _buildShowcase(
                        //   key: _keyStats,
                        //   title: AppLocalizations.of(context)!
                        //       .tour_profile_stats_title,
                        //   description: AppLocalizations.of(context)!
                        //       .tour_profile_stats_desc,
                        //   shapeBorder: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20)),
                        // ),
                        child: _buildStatsArray(userData),
                      ),

                      // LOC: Showcase Offline
                      SliverToBoxAdapter(
                        // child: _buildShowcase(
                        //   key: _keyOffline,
                        //   title: AppLocalizations.of(context)!
                        //       .tour_profile_offline_title,
                        //   description: AppLocalizations.of(context)!
                        //       .tour_profile_offline_desc,
                        //   shapeBorder: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20)),
                        // ),
                        child: _buildOfflineJapaCard(),
                      ),

                      // LOC: Gamification Header
                      SliverToBoxAdapter(
                          child: _buildSectionHeader(
                              AppLocalizations.of(context)!
                                  .profile_gamification_header)),
                      SliverToBoxAdapter(
                        // child: _buildShowcase(
                        //   key: _keyBodhi,
                        //   title: AppLocalizations.of(context)!.profile_myBodhi,
                        //   description: AppLocalizations.of(context)!
                        //       .tour_profile_bodhi_desc,
                        //   shapeBorder: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20)),
                        // ),
                        child:
                            _buildBodhiTreeCard(userData['total_malas'] ?? 0),
                      ),

                      // LOC: Commitments Header
                      SliverToBoxAdapter(
                          child: _buildSectionHeader(
                              AppLocalizations.of(context)!
                                  .profile_commitments_header)),
                      SliverToBoxAdapter(
                        // child: _buildShowcase(
                        //   key: _keySankalpa,
                        //   title: AppLocalizations.of(context)!
                        //       .profile_sankalpaTitle,
                        //   description: AppLocalizations.of(context)!
                        //       .tour_profile_sankalpa_desc,
                        //   shapeBorder: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20)),
                        // ),
                        child: _buildSankalpaCard(userData, provider, jappsMap),
                      ),

                      // LOC: Insights Header
                      SliverToBoxAdapter(
                          child: _buildSectionHeader(
                              AppLocalizations.of(context)!
                                  .profile_insights_header)),
                      SliverToBoxAdapter(
                          child: _buildMantraBreakdown(jappsMap, provider)),

                      // LOC: My Mantras Header
                      SliverToBoxAdapter(
                          child: _buildSectionHeader(
                              AppLocalizations.of(context)!
                                  .profile_my_mantras_header)),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final mantras = provider.allMantras
                                .where((m) => m.isCustom)
                                .toList();
                            if (index >= mantras.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.add),
                                  // LOC: Add New
                                  label: Text(AppLocalizations.of(context)!
                                      .profile_addNewMantra),
                                  style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ChangeNotifierProvider.value(
                                                  value: provider,
                                                  child:
                                                      const CustomMantraEditor()))),
                                ),
                              );
                            }
                            final mantra = mantras[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2))
                                  ]),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                leading: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange.shade50,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.music_note_rounded,
                                      color: Colors.deepOrange),
                                ),
                                title: Text(mantra.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete_outline_rounded,
                                      color: Colors.red.shade300),
                                  onPressed: () =>
                                      provider.deleteCustomMantra(mantra.id),
                                ),
                              ),
                            );
                          },
                          childCount: provider.allMantras
                                  .where((m) => m.isCustom)
                                  .length +
                              1,
                        ),
                      ),

                      if (bannerAd != null &&
                          !isPremium &&
                          _adService.isAdLoadedForScreen(_screenName))
                        SliverToBoxAdapter(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: bannerAd.size.width.toDouble(),
                            height: bannerAd.size.height.toDouble(),
                            child: AdWidget(ad: bannerAd),
                          ),
                        ),

                      // LOC: Quick Actions Header
                      SliverToBoxAdapter(
                          child: _buildSectionHeader(
                              AppLocalizations.of(context)!
                                  .profile_quick_actions_header)),
                      SliverToBoxAdapter(child: _buildActionGrid()),

                      const SliverToBoxAdapter(child: SizedBox(height: 120)),
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
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
