import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _fxPlayer = AudioPlayer();

  bool _isMuted = false;

  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;

  AudioService._internal() {
    // 1. INITIALIZE AUDIO CONTEXT (The Fix)
    _configureAudioContext();
  }

  // Tells the OS to mix sounds instead of pausing them
  Future<void> _configureAudioContext() async {
    final AudioContext audioContext = AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.ambient, // Allows mixing
        options: const {AVAudioSessionOptions.mixWithOthers},
      ),
      android: AudioContextAndroid(
        isSpeakerphoneOn: true,
        stayAwake: true,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.none, // Do not request exclusive focus
      ),
    );

    // Apply to global scope so both players share this rule
    await AudioPlayer.global.setAudioContext(audioContext);
  }

  Future<void> setMuted(bool muted) async {
    _isMuted = muted;
    if (muted) {
      await _player.setVolume(0);
      await _fxPlayer.setVolume(0);
    } else {
      await _player.setVolume(1.0);
      await _fxPlayer.setVolume(1.0);
    }
  }

  Future<void> startMantraLoop(String audioPath, bool isCustom) async {
    if (_isMuted) return;

    // Prevent restarting if already playing
    if (_player.state == PlayerState.playing) return;

    // Ensure we are in loop mode
    await _player.setReleaseMode(ReleaseMode.loop);

    // Resume if paused, otherwise play from start
    if (_player.state == PlayerState.paused) {
      await _player.resume();
    } else {
      if (isCustom) {
        await _player.play(DeviceFileSource(audioPath));
      } else {
        await _player.play(AssetSource(audioPath));
      }
    }
  }

  Future<void> stopMantra() async {
    await _player.stop();
    await _player.setReleaseMode(ReleaseMode.release);
  }

  Future<void> playOneShotSound(String assetPath) async {
    if (_isMuted) return;

    // Clean the path (remove assets/ prefix if present)
    String cleanPath = assetPath;
    if (cleanPath.startsWith('assets/')) {
      cleanPath = cleanPath.replaceFirst('assets/', '');
    }

    // Stop previous FX if any (overlap protection)
    if (_fxPlayer.state == PlayerState.playing) await _fxPlayer.stop();

    // Play the Ding!
    await _fxPlayer.play(AssetSource(cleanPath));
  }

  void dispose() {
    _player.dispose();
    _fxPlayer.dispose();
  }
}
