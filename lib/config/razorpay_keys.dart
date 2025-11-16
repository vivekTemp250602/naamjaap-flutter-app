import 'package:flutter/foundation.dart';

class RazorpayKeys {
  static const String liveKey = 'rzp_live_RfxajMZ27bOS5l'; // your LIVE key
  static const String testKey = 'rzp_test_RfhwT6SQSsd65K'; // your TEST key

  static String get activeKey {
    return kDebugMode ? testKey : liveKey;
  }
}
