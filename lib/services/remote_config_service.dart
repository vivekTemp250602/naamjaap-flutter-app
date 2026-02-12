import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:naamjaap/utils/constants.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  List<String> get mantras => _remoteConfig.getString('mantras').split(',');

  // 1. GETTER FOR VERSION CODE
  int get minRequiredVersionCode =>
      _remoteConfig.getInt('min_required_version_code');

  Future<void> initialize() async {
    try {
      // 2. SET DEFAULTS
      await _remoteConfig.setDefaults({
        'mantras': AppConstants.mantras.join(','),
        'min_required_version_code': 1, // Default allows all versions
      });

      // 3. FETCH (Set a low interval for dev, higher for prod)
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval:
            const Duration(hours: 1), // Change to 12 hours for prod
      ));

      await _remoteConfig.fetchAndActivate();
    } catch (error) {
      print('Remote Config fetch failed: $error');
    }
  }
}
