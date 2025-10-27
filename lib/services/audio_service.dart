import 'package:audioplayers/audioplayers.dart';
import 'package:naamjaap/utils/constants.dart';

class AudioService {
  // A single audioplayer for whole app
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  // THE FIX: Renamed _audioPlayer to _mantraPlayer for consistency
  final AudioPlayer _mantraPlayer = AudioPlayer();
  final AudioPlayer _soundEffectPlayer = AudioPlayer();
  final AudioPlayer _ambientPlayer = AudioPlayer();

  Future<void> play(Mantra mantra) async {
    if (_mantraPlayer.state == PlayerState.playing) {
      await _mantraPlayer.stop();
    }

    await _mantraPlayer.setReleaseMode(ReleaseMode.loop);

    if (mantra.isCustom && mantra.customAudioPath != null) {
      await _mantraPlayer.play(DeviceFileSource(mantra.customAudioPath!));
    } else {
      // It's a global mantra (or custom with no audio). Play from assets.
      await _mantraPlayer
          .play(AssetSource(mantra.audioPath.replaceFirst('assets/', '')));
    }
  }

  Future<void> playOneShotSound(String assetPath) async {
    await _soundEffectPlayer.setReleaseMode(ReleaseMode.release);
    await _soundEffectPlayer
        .play(AssetSource(assetPath.replaceFirst('assets/', '')));
  }

  // Pause currently played audio
  Future<void> pause() async {
    await _mantraPlayer.pause();
  }

  // Completely stop the audio
  Future<void> stop() async {
    await _mantraPlayer.stop();
  }

  // Resume the audio
  Future<void> resume() async {
    await _mantraPlayer.resume();
  }

  Future<void> setMuted(bool isMuted) async {
    await _mantraPlayer.setVolume(isMuted ? 0.0 : 1.0);
  }

  // Ambient Sound Methods ---
  Future<void> startAmbientSound(String assetPath) async {
    await _ambientPlayer.setReleaseMode(ReleaseMode.loop);
    await _ambientPlayer.setVolume(0.5); // Keep it very subtle
    await _ambientPlayer
        .play(AssetSource(assetPath.replaceFirst('assets/', '')));
  }

  Future<void> stopAmbientSound() async {
    await _ambientPlayer.stop();
  }

  // Expose the player's state stream for the UI to listen to.
  Stream<PlayerState> get onPlayerStateChanged =>
      _mantraPlayer.onPlayerStateChanged;

  void dispose() {
    _mantraPlayer.dispose();
    _soundEffectPlayer.dispose();
    _ambientPlayer.dispose();
  }
}
