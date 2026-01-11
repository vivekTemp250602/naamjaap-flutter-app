import 'dart:ui';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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

  // ---- Animation controllers ----
  late AnimationController _headerController;
  late Animation<Offset> _headerOffset =
      const AlwaysStoppedAnimation(Offset.zero);
  late Animation<double> _headerOpacity = const AlwaysStoppedAnimation(1.0);

  late AnimationController _heartController;
  late Animation<double> _heartScale = const AlwaysStoppedAnimation(1.0);

  late AnimationController _buttonGlowController;

  final String _contactNumber = "7558357834";
  final String _contactEmail = "vivek250602@gmail.com";

  final List<int> _amounts = [21, 51, 101, 251, 501];
  int _selectedAmount = 51;

  @override
  void initState() {
    super.initState();

    // Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Header animation
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _headerOffset = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutQuad),
    );

    _headerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );

    // Heart animation
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _heartScale = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );

    _heartController.repeat(reverse: true);

    // Glow animation
    _buttonGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    // Start header animation slightly delayed
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _headerController.forward();
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    _headerController.dispose();
    _heartController.dispose();
    _buttonGlowController.dispose();
    super.dispose();
  }

  // ------ Razorpay Handlers ------
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() => _isLoading = false);

    try {
      await functions.httpsCallable('grantPremiumAccessOnPayment').call();
    } catch (_) {}

    setState(() => _showThankYou = true);
    await Future.delayed(const Duration(milliseconds: 1600));
    if (mounted) setState(() => _showThankYou = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment successful — ${response.paymentId}"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isLoading = false);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment failed: ${response.message}"),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External wallet: ${response.walletName}"),
      ),
    );
  }

  // ------ Start Payment ------
  Future<void> _startPaymentForAmount(int rupees) async {
    final User? freshUser = FirebaseAuth.instance.currentUser;

    if (freshUser == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to donate.")),
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
        'description': 'Support the app',
        'order_id': orderId,
        'prefill': {
          'contact': _contactNumber,
          'email': freshUser.email ?? _contactEmail,
        },
      };

      _razorpay.open(options);
    } on FirebaseFunctionsException catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unknown error: $e")),
      );
    }
  }

  // ----- UI -----
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.profile_supportTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildContent(context, l10n),
          if (_isLoading) _buildLoadingOverlay(),
          if (_showThankYou) _buildThankYouOverlay(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SlideTransition(
          position: _headerOffset,
          child: FadeTransition(
            opacity: _headerOpacity,
            child: _buildHeader(l10n),
          ),
        ),
        const SizedBox(height: 30),
        _buildOfferCards(context),
        const SizedBox(height: 28),
        _buildFooter(context, l10n),
      ],
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        ScaleTransition(
          scale: _heartScale,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.red.shade300, Colors.deepOrange.shade200],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange.withAlpha(92),
                  blurRadius: 18,
                  spreadRadius: 1,
                )
              ],
            ),
            child: const Icon(Icons.favorite_rounded,
                size: 68, color: Colors.white),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.support_title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.support_desc,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildOfferCards(BuildContext context) {
    return Column(
      children: _amounts.map((amt) {
        final bool selected = _selectedAmount == amt;

        return GestureDetector(
          onTap: _isLoading
              ? null
              : () {
                  setState(() => _selectedAmount = amt);
                  _startPaymentForAmount(amt);
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: selected
                      ? [Colors.amber.shade200, Colors.deepOrange.shade300]
                      : [Colors.amber.shade100, Colors.orange.shade100],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(selected ? 70 : 20),
                    blurRadius: selected ? 24 : 10,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 18),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('₹ $amt',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.brown.shade900,
                              )),
                          const SizedBox(height: 6),
                          Text(AppLocalizations.of(context)!.support_title,
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: AnimatedBuilder(
                          animation: _buttonGlowController,
                          builder: (context, child) {
                            final glow =
                                0.5 + (_buttonGlowController.value * 0.5);
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withAlpha(220),
                                    Colors.white.withAlpha(200)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(26),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange
                                        .withAlpha((50 * glow).toInt()),
                                    blurRadius: 18 * glow,
                                    spreadRadius: 1.2 * glow,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.volunteer_activism,
                                      color: Colors.deepOrange),
                                  const SizedBox(width: 8),
                                  Text(AppLocalizations.of(context)!
                                      .support_donate),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooter(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.support_afterTitile,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 22),
        Text(
          AppLocalizations.of(context)!.support_paymentSucc,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withAlpha(100),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildThankYouOverlay() {
    return Center(
      child: AnimatedScale(
        scale: _showThankYou ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.elasticOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade50, Colors.amber.shade200],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 18)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_people,
                  size: 48, color: Colors.deepOrange),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.support_thank,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
