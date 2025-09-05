import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:naamjaap/services/storage_service.dart';
import 'package:naamjaap/widgets/share_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final User _currentUser = FirebaseAuth.instance.currentUser!;
  final GlobalKey _shareCardKey = GlobalKey();

  String _shareableName = '';
  bool _isUploading = false;
  int _shareableJapps = 0;

  // The sign-out logic.
  Future<void> _signOut() async {
    await AudioService().stop();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  // Upload Profile Image
  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (image == null) return; // User cancelled the picker

    setState(() {
      _isUploading = true;
    });

    try {
      // 1. Upload the image to Firebase Storage
      final String downloadUrl =
          await _storageService.uploadProfilePicture(_currentUser.uid, image);

      // 2. Update the user's document in Firestore with the new URL
      await _firestoreService.updateUserProfilePicture(
          _currentUser.uid, downloadUrl);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Profile picture updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to upload image. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
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
        throw Exception("Shareable card context is not available.");
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
          text: 'Check out my progress on the NaamJaap app!');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not share progress: ${e.toString()}')),
        );
      }
    }
  }

  // Method to handle picking an image from the gallery.
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Image selected ! Upload feature coming soon.')),
      );
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
          title: const Text('Change Your Name'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter new name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
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

  // Exact UPI Launch Code
  Future<void> _launchUPI() async {
    final String transactionId = 'TR${DateTime.now().millisecondsSinceEpoch}';
    final Uri upiUri = Uri.parse(
        'upi://pay?pa=vivek120303@okhdfcbank&pn=Vivek%20Tiwari&tr=$transactionId&tn=Support%20Naam%20Jaap&am=0&cu=INR');

    try {
      if (await canLaunchUrl(upiUri)) {
        await launchUrl(upiUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch UPI app.';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error: Could not find a UPI app to open.')),
        );
      }
    }
  }

  // Add the function to launch the Google Form URL.
  Future<void> _launchFeedbackForm() async {
    // IMPORTANT: Replace the URL below with the actual link to YOUR Google Form.
    final Uri feedbackUri = Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSemtDuaiggPyF-cvUgKQqS3NxlB6LZyHFBc_cvXN6ZIbVLr_w/viewform?usp=header');

    if (!await launchUrl(feedbackUri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open feedback form.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  return const Center(child: Text("Could not load user data."));
                }

                return buildProfileView(
                    userSnapshot.data!.data() as Map<String, dynamic>);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileView(Map<String, dynamic> userData) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
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
                        // INCREASED: Avatar radius is now larger.
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
                Text("Your Progress",
                    style: Theme.of(context).textTheme.titleLarge),

                const Divider(height: 24),

                ListTile(
                  leading: Icon(Icons.local_fire_department_rounded,
                      color: Colors.orange.shade800),
                  title: const Text('Daily Streaks'),
                  trailing: Text(
                    '${userData['currentStreak'] ?? 0} Days',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.star_border,
                      color: Theme.of(context).colorScheme.secondary),
                  title: const Text("Total Japps"),
                  trailing: Text(
                    '${userData['total_japps'] ?? 0}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),

                // FIXED: This now fetches the live leaderboard to calculate the real rank.
                StreamBuilder<QuerySnapshot>(
                  stream: _firestoreService.getLeaderboardStream(),
                  builder: (context, leaderboardSnapshot) {
                    if (!leaderboardSnapshot.hasData) {
                      return const ListTile(
                        leading: Icon(Icons.leaderboard_outlined,
                            color: Colors.grey),
                        title: Text("Global Rank"),
                        trailing: CircularProgressIndicator(strokeWidth: 2),
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
                      title: const Text("Global Rank"),
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

        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SwitchListTile(
              title: const Text("Daily Remainders"),
              subtitle: const Text(
                  "Get a notification if you haven't chanted today."),
              secondary: const Icon(Icons.notifications_outlined),
              value: userData['settings']?['enableReminders'] ?? false,
              onChanged: (bool value) {
                _firestoreService.updateReminderSetting(
                    _currentUser.uid, value);
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Share your progress
        Card(
          child: ListTile(
            onTap: _triggerShare, // This now works!
            leading:
                Icon(Icons.share, color: Theme.of(context).colorScheme.primary),
            title: const Text("Share Your Progress"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),

        const SizedBox(height: 20),

        // --- Support Card ---
        Card(
          child: ListTile(
            onTap: _launchUPI,
            leading: const Icon(Icons.favorite_outline, color: Colors.red),
            title: const Text("Support Naam Jaap"),
            subtitle: const Text("Help keep the app running"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),

        const SizedBox(height: 20),

        // Badge Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Achievements",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(
                  height: 24,
                ),
                if ((userData['badges'] as List?)?.isEmpty ?? true)
                  const Text("Chant more to earn badges")
                else
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children:
                        (userData['badges'] as List<dynamic>).map((badge) {
                      return Chip(
                        avatar: Icon(Icons.shield,
                            color: Theme.of(context).colorScheme.secondary),
                        label: Text(badge.toString()),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withAlpha(160),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: 24,
        ),

        // ---- FeedBack Form ------
        Card(
          child: ListTile(
            onTap: _launchFeedbackForm,
            leading: const Icon(
              Icons.feedback_outlined,
              color: Colors.blueGrey,
            ),
            title: const Text("Feedback & Support"),
            subtitle: const Text("Report a bug or suggest a feature"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
        ),

        const SizedBox(
          height: 24,
        ),

        // ----- Sign Out Button -------
        ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text('Sign Out'),
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
}
