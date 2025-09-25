import 'package:audioplayers/audioplayers.dart';

class AudioService {
  // A single audioplayer for whole app
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _soundEffectPlayer = AudioPlayer();
  final AudioPlayer _ambientPlayer = AudioPlayer();

  Future<void> play(String assetPath) async {
    await stop();
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource(assetPath.replaceFirst('assets/', '')));
  }

  Future<void> playOneShotSound(String assetPath) async {
    await _soundEffectPlayer.setReleaseMode(ReleaseMode.release);
    await _soundEffectPlayer
        .play(AssetSource(assetPath.replaceFirst('assets/', '')));
  }

  // Pause currently played audio
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Completely stop the audio
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  // Resume the audio
  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  Future<void> setMuted(bool isMuted) async {
    await _audioPlayer.setVolume(isMuted ? 0.0 : 1.0);
  }

  // Ambient Sound Methods ---
  Future<void> startAmbientSound(String assetPath) async {
    await _ambientPlayer.setReleaseMode(ReleaseMode.loop);
    await _ambientPlayer.setVolume(0.15); // Keep it very subtle
    await _ambientPlayer
        .play(AssetSource(assetPath.replaceFirst('assets/', '')));
  }

  Future<void> stopAmbientSound() async {
    await _ambientPlayer.stop();
  }

  // Expose the player's state stream for the UI to listen to.
  Stream<PlayerState> get onPlayerStateChanged =>
      _audioPlayer.onPlayerStateChanged;

  void dispose() {
    _audioPlayer.dispose();
    _soundEffectPlayer.dispose();
    _ambientPlayer.dispose();
  }
}
