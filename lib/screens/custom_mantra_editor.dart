import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ... [Keep CreationSparkles and _Sparkle classes exactly as they are] ...
class CreationSparkles extends CustomPainter {
  final AnimationController controller;
  final List<_Sparkle> sparkles = [];
  final math.Random random = math.Random();

  CreationSparkles(this.controller) : super(repaint: controller) {
    for (int i = 0; i < 20; i++) {
      sparkles.add(_Sparkle(random));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var s in sparkles) {
      s.update(size.height, size.width);
      paint.color = Colors.white.withOpacity(s.opacity * 0.4);
      canvas.drawCircle(Offset(s.x, s.y), s.size, paint);
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

  void reset(bool startRandom) {
    x = rnd.nextDouble() * 500;
    y = startRandom ? rnd.nextDouble() * 800 : 800;
    speed = 0.5 + rnd.nextDouble() * 1.5;
    size = 1.0 + rnd.nextDouble() * 2.5;
    opacity = 0.1 + rnd.nextDouble() * 0.5;
  }

  void update(double height, double width) {
    y -= speed;
    if (y < -50) reset(false);
  }
}

class CustomMantraEditor extends StatefulWidget {
  const CustomMantraEditor({super.key});

  @override
  State<CustomMantraEditor> createState() => _CustomMantraEditorState();
}

class _CustomMantraEditorState extends State<CustomMantraEditor>
    with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
  String _selectedBackgroundId = AppConstants.customBackgrounds.first.id;
  Widget _currentBackground = AppConstants.customBackgrounds.first.child;

  // Audio State
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isAudioSaved = false;
  bool _isPlaying = false;
  String? _newAudioFilePath;

  // Animation
  late final AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _particleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
    _player.onProgress!.listen((e) {
      // You could update a progress bar here if you wanted
    });
    // Listen for playback finish to reset icon
    _player.onProgress!.listen((event) {
      if (event.position >= event.duration) {
        if (mounted) setState(() => _isPlaying = false);
      }
    });
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      // STOP
      final path = await _recorder.stopRecorder();
      setState(() {
        _newAudioFilePath = path;
        _isRecording = false;
        _isAudioSaved = true;
      });
    } else {
      // START
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!.custom_micAccess)),
          );
        }
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final tempPath = '${directory.path}/temp_mantra.m4a';

      await _recorder.startRecorder(
        toFile: tempPath,
        codec: Codec.aacMP4,
      );
      setState(() {
        _isRecording = true;
        _isAudioSaved = false;
        _newAudioFilePath = null;
      });
    }
  }

  Future<void> _playRecording() async {
    if (_newAudioFilePath != null) {
      if (_player.isPlaying) {
        await _player.stopPlayer();
        setState(() => _isPlaying = false);
      } else {
        setState(() => _isPlaying = true);
        await _player.startPlayer(
            fromURI: _newAudioFilePath,
            whenFinished: () => setState(() => _isPlaying = false));
      }
    }
  }

  void _deleteRecording() {
    setState(() {
      _newAudioFilePath = null;
      _isAudioSaved = false;
      _isPlaying = false;
    });
  }

  // --- UI WIDGETS ---

  Widget _buildPreviewCard() {
    return Container(
      width: double.infinity,
      height: 220,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                key: ValueKey(_selectedBackgroundId),
                width: double.infinity,
                height: double.infinity,
                child: _currentBackground,
              ),
            ),

            // Dark Overlay
            Container(color: Colors.black.withOpacity(0.3)),

            // Text
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _textController.text.isEmpty
                      ? AppLocalizations.of(context)!.custom_yourMantra
                      : _textController.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 15.0, color: Colors.black)],
                  ),
                ),
              ),
            ),

            // "Preview" Badge
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24)),
                // LOC: PREVIEW
                child: Text(AppLocalizations.of(context)!.custom_preview,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, -10))
          ]),
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. INPUT
          Text(AppLocalizations.of(context)!.custom_yourMantra.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  letterSpacing: 1)),
          const SizedBox(height: 10),
          TextField(
            controller: _textController,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.custom_hint,
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon:
                  const Icon(Icons.edit_note_rounded, color: Colors.deepOrange),
            ),
            onChanged: (value) => setState(() {}),
          ),

          const SizedBox(height: 24),

          // 2. BACKGROUNDS
          Text(AppLocalizations.of(context)!.custom_back.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  letterSpacing: 1)),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.customBackgrounds.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final bg = AppConstants.customBackgrounds[index];
                final isSelected = bg.id == _selectedBackgroundId;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBackgroundId = bg.id;
                      _currentBackground = bg.child;
                    });
                  },
                  child: AnimatedContainer(
                    duration: 200.ms,
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: isSelected
                                ? Colors.deepOrange
                                : Colors.transparent,
                            width: 3),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                    color: Colors.deepOrange.withOpacity(0.3),
                                    blurRadius: 8)
                              ]
                            : null),
                    padding: const EdgeInsets.all(3),
                    child: ClipOval(child: bg.thumbnail),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // 3. AUDIO RECORDER
          Text(AppLocalizations.of(context)!.custom_addVoice.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  letterSpacing: 1)),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200)),
            child: Row(
              children: [
                // RECORD BUTTON
                GestureDetector(
                  onTap: _toggleRecording,
                  child: AnimatedContainer(
                    duration: 300.ms,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: _isRecording
                            ? Colors.red
                            : (_isAudioSaved ? Colors.green : Colors.white),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: (_isRecording ? Colors.red : Colors.grey)
                                  .withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2)
                        ]),
                    child: Icon(
                      _isRecording
                          ? Icons.stop_rounded
                          : (_isAudioSaved
                              ? Icons.check_rounded
                              : Icons.mic_rounded),
                      color: _isRecording || _isAudioSaved
                          ? Colors.white
                          : Colors.black87,
                      size: 28,
                    ),
                  ),
                )
                    .animate(
                        onPlay: (c) =>
                            _isRecording ? c.repeat(reverse: true) : null)
                    .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                        duration: 500.ms), // Pulse when recording

                const SizedBox(width: 16),

                // TEXT & CONTROLS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LOC: Recording Status
                      Text(
                        _isRecording
                            ? AppLocalizations.of(context)!.custom_recording
                            : (_isAudioSaved
                                ? AppLocalizations.of(context)!
                                    .custom_voice_saved
                                : AppLocalizations.of(context)!
                                    .custom_tap_record),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isRecording ? Colors.red : Colors.black87),
                      ),
                      if (_isAudioSaved)
                        // LOC: Ready to use
                        Text(AppLocalizations.of(context)!.custom_ready_use,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ),

                // PLAY / DELETE
                if (_isAudioSaved && !_isRecording)
                  Row(
                    children: [
                      IconButton(
                        onPressed: _playRecording,
                        icon: Icon(
                            _isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: Colors.deepOrange,
                            size: 36),
                      ),
                      IconButton(
                        onPressed: _deleteRecording,
                        icon: const Icon(Icons.delete_outline_rounded,
                            color: Colors.grey),
                      )
                    ],
                  )
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 4. SAVE BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _saveMantra,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  shadowColor: Colors.deepOrange.withOpacity(0.5)),
              child: Text(
                AppLocalizations.of(context)!.custom_saveMantra.toUpperCase(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveMantra() async {
    if (_textController.text.isNotEmpty) {
      await Provider.of<MantraProvider>(context, listen: false).addCustomMantra(
        mantraName: _textController.text,
        backgroundId: _selectedBackgroundId,
        tempAudioPath: _newAudioFilePath,
      );
      if (mounted) Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // LOC: Error
          content:
              Text(AppLocalizations.of(context)!.custom_error_empty_name)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset:
          true, // Allows screen to resize when keyboard opens
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.custom_create,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. Divine Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF8C00),
                  Color(0xFFFF5E62),
                  Color(0xFF6A0572)
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),

          // 2. Sparkles
          CustomPaint(painter: CreationSparkles(_particleController)),

          // 3. Scrollable Content (The Fix)
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody:
                      false, // Ensures Spacer() works when keyboard is hidden
                  child: Column(
                    children: [
                      // Space for AppBar + Top Padding
                      const SizedBox(height: 100),

                      _buildPreviewCard(),

                      // This pushes the control panel to the bottom,
                      // but collapses gracefully when scrolling is needed.
                      const Spacer(),

                      _buildControlPanel(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
