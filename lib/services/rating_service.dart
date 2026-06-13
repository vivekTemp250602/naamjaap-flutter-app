import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the in-app review lifecycle with a strict 3-prompt lifetime cap.
///
/// Schedule:
///   Prompt 1 — On the user's 10th completed Mala (first genuine delight moment).
///   Prompt 2 — 14 days after Prompt 1 was shown (time-based, checked on app start).
///   Prompt 3 — 60 days after the very first app open (time-based, checked on app start).
///
/// After all 3 prompts are exhausted the user is never asked again,
/// regardless of whether they rated or dismissed.
class RatingService {
  final InAppReview _inAppReview = InAppReview.instance;

  // ── SharedPreferences keys ──────────────────────────────────────────────────
  static const String _keyMalaCount    = 'rating_mala_count';
  static const String _keyPromptCount  = 'rating_prompt_count';
  static const String _keyLastPromptMs = 'rating_last_prompt_ms';
  static const String _keyFirstOpenMs  = 'rating_first_open_ms';

  // ── Config ──────────────────────────────────────────────────────────────────
  static const int _maxPrompts            = 3;
  static const int _prompt2CooldownDays   = 14;  // 2 weeks after prompt 1
  static const int _prompt3MinDaysFromOpen = 60; // ~2 months from first open

  // ── Public API ──────────────────────────────────────────────────────────────

  /// Call once during app start (e.g. in HomeScreen.initState).
  ///
  /// Records first-open date on first ever call and fires time-based prompts
  /// (2 & 3) when their conditions are met.
  Future<void> checkOnAppStart() async {
    final prefs = await SharedPreferences.getInstance();

    // Record first-open date (once, forever).
    if (prefs.getInt(_keyFirstOpenMs) == null) {
      await prefs.setInt(
          _keyFirstOpenMs, DateTime.now().millisecondsSinceEpoch);
    }

    final int promptCount = prefs.getInt(_keyPromptCount) ?? 0;

    // Already exhausted all prompts — done forever.
    if (promptCount >= _maxPrompts) return;

    // Prompt 1 hasn't fired yet — nothing to time-gate.
    final int lastPromptMs = prefs.getInt(_keyLastPromptMs) ?? 0;
    if (lastPromptMs == 0) return;

    final DateTime lastPromptDate =
        DateTime.fromMillisecondsSinceEpoch(lastPromptMs);
    final int daysSinceLastPrompt =
        DateTime.now().difference(lastPromptDate).inDays;

    final int firstOpenMs = prefs.getInt(_keyFirstOpenMs)!;
    final DateTime firstOpenDate =
        DateTime.fromMillisecondsSinceEpoch(firstOpenMs);
    final int daysSinceFirstOpen =
        DateTime.now().difference(firstOpenDate).inDays;

    bool shouldPrompt = false;

    if (promptCount == 1 && daysSinceLastPrompt >= _prompt2CooldownDays) {
      // Prompt 2: at least 2 weeks after prompt 1.
      shouldPrompt = true;
    } else if (promptCount == 2 &&
        daysSinceFirstOpen >= _prompt3MinDaysFromOpen) {
      // Prompt 3: at least 2 months since first ever open.
      shouldPrompt = true;
    }

    if (shouldPrompt) {
      await _requestReview(prefs, promptCount);
    }
  }

  /// Call this when a Mala (108 chants) is completed.
  ///
  /// Only fires Prompt 1 (on the 10th Mala). Subsequent prompts are
  /// time-based and handled by [checkOnAppStart].
  Future<void> checkOnMalaComplete() async {
    final prefs = await SharedPreferences.getInstance();

    final int promptCount = prefs.getInt(_keyPromptCount) ?? 0;

    // Already prompted at least once — wait for time-based triggers.
    if (promptCount >= 1) return;

    // Increment mala count.
    final int malaCount = (prefs.getInt(_keyMalaCount) ?? 0) + 1;
    await prefs.setInt(_keyMalaCount, malaCount);

    // Fire only on the 10th Mala.
    if (malaCount == 10) {
      await _requestReview(prefs, promptCount);
    }
  }

  // ── Private helpers ─────────────────────────────────────────────────────────

  Future<void> _requestReview(
      SharedPreferences prefs, int currentPromptCount) async {
    if (!await _inAppReview.isAvailable()) return;

    await _inAppReview.requestReview();

    // Persist state regardless of whether the user rated or dismissed
    // (the OS doesn't expose that information, and we want a gentle policy
    // either way).
    await prefs.setInt(
        _keyLastPromptMs, DateTime.now().millisecondsSinceEpoch);
    await prefs.setInt(_keyPromptCount, currentPromptCount + 1);
  }
}
