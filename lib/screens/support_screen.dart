import 'dart:ui';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Global Firebase Functions instance
final FirebaseFunctions functions =
    FirebaseFunctions.instanceFor(region: 'us-central1');

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen>
    with TickerProviderStateMixin {
  late Razorpay _razorpay;
  bool _isLoading = false;
  bool _showThankYou = false;

  final String _contactNumber = "7558357834";
  final String _contactEmail = "vivek250602@gmail.com";

  // Donation Tiers
  // Note: We initialize this in build() or initState() if we want to localize labels
  List<Map<String, dynamic>> _offerings = [];

  int _selectedAmount = 51;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // Helper to initialize localized offerings
  void _initOfferings(BuildContext context) {
    _offerings = [
      {
        'amount': 21,
        'icon': Icons.local_florist_rounded,
        'label': AppLocalizations.of(context)!.support_tier_flower
      },
      {
        'amount': 51,
        'icon': Icons.light_mode_rounded,
        'label': AppLocalizations.of(context)!.support_tier_lamp
      },
      {
        'amount': 101,
        'icon': Icons.spa_rounded,
        'label': AppLocalizations.of(context)!.support_tier_garland
      },
      {
        'amount': 251,
        'icon': Icons.temple_buddhist_rounded,
        'label': AppLocalizations.of(context)!.support_tier_temple
      },
      {
        'amount': 501,
        'icon': Icons.volunteer_activism_rounded,
        'label': AppLocalizations.of(context)!.support_tier_grand
      },
    ];
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // ... [Keep Razorpay Handlers as is] ...
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() => _isLoading = false);
    try {
      await functions.httpsCallable('grantPremiumAccessOnPayment').call();
    } catch (_) {}

    setState(() => _showThankYou = true);
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      setState(() => _showThankYou = false);
      Navigator.pop(context);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isLoading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Payment failed: ${response.message}"),
          backgroundColor: Colors.red),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External wallet: ${response.walletName}")),
    );
  }

  // ------ Start Payment ------
  Future<void> _startPaymentForAmount(int rupees) async {
    final User? freshUser = FirebaseAuth.instance.currentUser;
    if (freshUser == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        // LOC: Sign in to contribute
        SnackBar(
            content:
                Text(AppLocalizations.of(context)!.support_signin_required)),
      );
      return;
    }

    setState(() => _isLoading = true);
    await freshUser.getIdToken(true);
    final int amountInPaisa = rupees * 100;

    try {
      final callable = functions.httpsCallable('createRazorpayOrder');
      final result = await callable.call({'amount': amountInPaisa});
      final String orderId = result.data['order_id'];

      final options = {
        'key': 'rzp_live_RfxajMZ27bOS5l',
        'amount': amountInPaisa,
        'name': 'Naam Jaap',
        'description': 'Seva Offering',
        'order_id': orderId,
        'prefill': {
          'contact': _contactNumber,
          'email': freshUser.email ?? _contactEmail,
        },
        'theme': {'color': '#FF5722'}
      };

      _razorpay.open(options);
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        // LOC: Payment Failed
        SnackBar(
            content: Text(AppLocalizations.of(context)!.support_payment_error)),
      );
    }
  }

  // ----- UI -----
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _initOfferings(context); // Initialize localized strings

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // 1. Divine Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF8C00),
                  Color(0xFFFF5E62),
                  Color(0xFF6A0572)
                ],
              ),
            ),
          ),

          // 2. Content ScrollView
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                children: [
                  // --- HEADER ---
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.4), width: 2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5)
                        ]),
                    child: const Icon(Icons.volunteer_activism_rounded,
                        size: 60, color: Colors.white),
                  ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                      duration: 2.seconds),

                  const SizedBox(height: 24),

                  Text(
                    l10n.support_title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.support_desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5),
                  ),

                  const SizedBox(height: 40),

                  // --- OFFERING CARDS ---
                  ..._offerings
                      .map((offer) {
                        final int amt = offer['amount'];
                        final bool isSelected = _selectedAmount == amt;

                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedAmount = amt);
                          },
                          child: AnimatedContainer(
                            duration: 300.ms,
                            curve: Curves.easeOutCubic,
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                    width: 2),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                            color: Colors.orange.shade900
                                                .withOpacity(0.3),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5))
                                      ]
                                    : []),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.orange.shade50
                                        : Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(offer['icon'],
                                      color: isSelected
                                          ? Colors.deepOrange
                                          : Colors.white,
                                      size: 24),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹ $amt",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors.black87
                                                : Colors.white),
                                      ),
                                      Text(
                                        offer['label'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: isSelected
                                                ? Colors.grey.shade600
                                                : Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check_circle_rounded,
                                          color: Colors.deepOrange, size: 28)
                                      .animate()
                                      .scale(
                                          duration: 200.ms,
                                          curve: Curves.elasticOut),
                              ],
                            ),
                          ),
                        );
                      })
                      .toList()
                      .animate(interval: 100.ms)
                      .slideX(begin: 0.2, end: 0)
                      .fadeIn(),

                  const SizedBox(height: 20),

                  // --- ACTION BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () => _startPaymentForAmount(_selectedAmount),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.deepOrange))
                          : Text(
                              // LOC: Offer Seva
                              "${AppLocalizations.of(context)!.support_offer_seva} ₹ $_selectedAmount",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    // LOC: Support Footer
                    AppLocalizations.of(context)!.support_afterTitile,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 12),
                  ),

                  const SizedBox(height: 80), // Bottom padding
                ],
              ),
            ),
          ),

          // 3. Thank You Overlay
          if (_showThankYou)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite_rounded,
                            color: Colors.pinkAccent, size: 80)
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.2, 1.2)),
                    const SizedBox(height: 20),
                    Text(
                      l10n.support_thank,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // LOC: Blessings
                    Text(
                      AppLocalizations.of(context)!.support_blessed,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 16),
                    ),
                  ],
                ).animate().fadeIn().moveY(begin: 50, end: 0),
              ),
            ),
        ],
      ),
    );
  }
}
