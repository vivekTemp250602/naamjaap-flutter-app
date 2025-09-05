import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:naamjaap/utils/constants.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  List<String> get mantras => _remoteConfig.getString('mantras').split(',');

  Future<void> initialize() async {
    try {
      await _remoteConfig.setDefaults({
        'mantras': AppConstants.mantras.join(','),
      });

      await _remoteConfig.fetchAndActivate();
    } catch (error) {
      print('Remote Config catch failed: $error');
    }
  }
}
