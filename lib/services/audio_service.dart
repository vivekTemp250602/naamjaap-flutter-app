import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _fxPlayer = AudioPlayer();

  bool _isMuted = false;

  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;

  AudioService._internal() {
    // 🪄 Non-blocking initialization. Doesn't lag the app!
    _initAudioSafely();
  }

  Future<void> _initAudioSafely() async {
    await AudioPlayer.global.setAudioContext(AudioContext(
      android: const AudioContextAndroid(
        isSpeakerphoneOn: false,
        stayAwake: true,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.none, // Allows multiple sounds to play together
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {
          AVAudioSessionOptions.mixWithOthers, // Allows mixing with other audio
        },
      ),
    ));
    await _player.setReleaseMode(ReleaseMode.loop);
    await _fxPlayer.setReleaseMode(ReleaseMode.stop);
    
    // Set audio context for both players to allow simultaneous playback
    await _player.setAudioContext(AudioContext(
      android: const AudioContextAndroid(
        isSpeakerphoneOn: false,
        stayAwake: true,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.none,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {AVAudioSessionOptions.mixWithOthers},
      ),
    ));
    
    await _fxPlayer.setAudioContext(AudioContext(
      android: const AudioContextAndroid(
        isSpeakerphoneOn: false,
        stayAwake: false,
        contentType: AndroidContentType.sonification,
        usageType: AndroidUsageType.notification,
        audioFocus: AndroidAudioFocus.none,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {AVAudioSessionOptions.mixWithOthers},
      ),
    ));
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
    if (_player.state == PlayerState.playing) return;

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
  }

  Future<void> playOneShotSound(String assetPath) async {
    if (_isMuted) return;

    String cleanPath = assetPath.replaceFirst('assets/', '');

    // Play the one-shot sound on top of the existing audio
    await _fxPlayer.play(AssetSource(cleanPath));
  }

  void dispose() {
    _player.dispose();
    _fxPlayer.dispose();
  }
}
