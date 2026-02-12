import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/l10n/app_localizations.dart';

class VersionCheckService {
  static Future<void> checkVersion(BuildContext context) async {
    try {
      // 1. Get Current App Version
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final int currentVersionCode = int.parse(packageInfo.buildNumber);

      // 2. Get Required Version from Remote Config
      final int minRequiredVersion =
          RemoteConfigService().minRequiredVersionCode;

      // 3. Compare
      if (currentVersionCode < minRequiredVersion) {
        if (context.mounted) {
          _showForceUpdateDialog(context);
        }
      }
    } catch (e) {
      debugPrint("Version check failed: $e");
    }
  }

  static void _showForceUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (context) {
        // Use WillPopScope (or PopScope) to prevent back button
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)?.dialog_update ??
                "Update Required"),
            content: Text(AppLocalizations.of(context)?.dialog_updateDesc ??
                "A new version of Naam Jaap is available with critical fixes. Please update to continue."),
            actions: [
              ElevatedButton(
                onPressed: _launchPlayStore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)?.dialog_updateNow ??
                    "Update Now"),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _launchPlayStore() {
    // Replace with your package name
    final appId = 'com.vivek.naamjaap';
    try {
      launchUrl(
        Uri.parse("market://details?id=$appId"),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      launchUrl(
        Uri.parse("https://play.google.com/store/apps/details?id=$appId"),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
