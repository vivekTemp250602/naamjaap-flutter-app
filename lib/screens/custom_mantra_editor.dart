import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class CustomMantraEditor extends StatefulWidget {
  const CustomMantraEditor({super.key});

  @override
  State<CustomMantraEditor> createState() => _CustomMantraEditorState();
}

class _CustomMantraEditorState extends State<CustomMantraEditor> {
  final _textController = TextEditingController();
  String _selectedBackgroundId = AppConstants.customBackgrounds.first.id;
  Widget _currentBackground = AppConstants.customBackgrounds.first.child;

  // NEW: Audio Recording State
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isAudioSaved = false;
  String? _newAudioFilePath;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  // Future<String> _getNewFilePath(String mantraId) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return '${directory.path}/$mantraId.m4a';
  // }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      // --- STOP RECORDING ---
      final path = await _recorder.stopRecorder();
      setState(() {
        _newAudioFilePath = path;
        _isRecording = false;
        _isAudioSaved = true;
      });
    } else {
      // --- START RECORDING ---
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.custom_micAccess)),
        );
        return;
      }

      // We'll generate a temporary path first
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
      await _player.startPlayer(fromURI: _newAudioFilePath);
    }
  }

  void _deleteRecording() {
    setState(() {
      _newAudioFilePath = null;
      _isAudioSaved = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.custom_create),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Live Preview
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 599),
                child: SizedBox(
                  key: ValueKey(_selectedBackgroundId),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(child: _currentBackground),
                      Container(
                        color: Colors.black.withAlpha(80),
                      ),
                      Center(
                        child: Text(
                          _textController.text.isEmpty
                              ? AppLocalizations.of(context)!.custom_yourMantra
                              : _textController.text,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 10.0, color: Colors.black54),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // --- The Controls ---
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                color: Theme.of(context).colorScheme.surface,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.custom_yourMantra,
                          hintText: AppLocalizations.of(context)!.custom_hint,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) => setState(() {}), // Update preview
                      ),
                      const SizedBox(height: 24),
                      Text(AppLocalizations.of(context)!.custom_back,
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: AppConstants.customBackgrounds.map((bg) {
                            final isSelected = bg.id == _selectedBackgroundId;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedBackgroundId = bg.id;
                                  _currentBackground = bg.child;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                                child: bg.thumbnail,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // --- NEW: THE AUDIO RECORDING UI ---
                      Text(AppLocalizations.of(context)!.custom_addVoice,
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // The main record/stop button
                            IconButton(
                              icon: Icon(
                                  _isRecording ? Icons.stop_circle : Icons.mic,
                                  size: 32),
                              color: _isRecording ? Colors.red : Colors.black,
                              onPressed: _toggleRecording,
                            ),
                            // The playback/status area
                            _isRecording
                                ? Text(AppLocalizations.of(context)!
                                    .custom_recording)
                                : _isAudioSaved
                                    ? Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.play_arrow),
                                            onPressed: _playRecording,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: _deleteRecording,
                                          ),
                                        ],
                                      )
                                    : Text(AppLocalizations.of(context)!
                                        .custom_tapToRecord),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_textController.text.isNotEmpty) {
                              // This now returns the new Mantra ID
                              await Provider.of<MantraProvider>(context,
                                      listen: false)
                                  .addCustomMantra(
                                mantraName: _textController.text,
                                backgroundId: _selectedBackgroundId,
                                tempAudioPath: _newAudioFilePath,
                              );

                              // If we have a new audio file, rename it to match the new Mantra ID
                              // if (_newAudioFilePath != null) {
                              //   final finalPath =
                              //       await _getNewFilePath(newMantraId);
                              //   await File(_newAudioFilePath!).rename(finalPath);
                              // }

                              if (mounted) Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                              AppLocalizations.of(context)!.custom_saveMantra),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
