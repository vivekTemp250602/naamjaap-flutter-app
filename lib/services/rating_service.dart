import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  final InAppReview _inAppReview = InAppReview.instance;
  static const String _keyMalaCountForRating = 'mala_count_for_rating';

  /// Call this whenever a Mala (108 count) is completed
  Future<void> checkAndAskForReview() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt(_keyMalaCountForRating) ?? 0;
    currentCount++;

    // STRATEGY: Ask after the 1st Mala, then the 5th, then every 20th.
    // This captures early happy users and loyal long-term users.
    if (currentCount == 1 ||
        currentCount == 5 ||
        (currentCount > 5 && currentCount % 20 == 0)) {
      if (await _inAppReview.isAvailable()) {
        _inAppReview.requestReview();
      }
    }

    await prefs.setInt(_keyMalaCountForRating, currentCount);
  }
}
