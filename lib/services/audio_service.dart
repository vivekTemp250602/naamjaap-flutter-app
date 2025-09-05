import 'package:audioplayers/audioplayers.dart';

class AudioService {
  // A single audioplayer for whole app

  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(String assetPath) async {
    // stop currently playing audio
    await stop();

    // loop mode on
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);

    await _audioPlayer.play(AssetSource(assetPath.replaceFirst('assets/', '')));
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

  void dispose() {
    _audioPlayer.dispose();
  }

  // Expose the player's state stream for the UI to listen to.
  Stream<PlayerState> get onPlayerStateChanged =>
      _audioPlayer.onPlayerStateChanged;
}
