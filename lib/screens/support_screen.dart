import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _amountController = TextEditingController();
  String _selectedAmount = '51'; // Default to a pre-selected amount

  Future<void> _launchUPI(String amount) async {
    // We show a snackbar here for a great UX
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.support_openUPI),
        backgroundColor: Colors.green,
      ),
    );

    final String transactionId = 'TR${DateTime.now().millisecondsSinceEpoch}';
    final Uri upiUri = Uri.parse(
        'upi://pay?pa=vivek120303@okhdfcbank&pn=Vivek%20Tiwari&tr=$transactionId&tn=Support%20Naam%20Jaap&am=$amount&cu=INR');

    try {
      if (await canLaunchUrl(upiUri)) {
        await launchUrl(upiUri, mode: LaunchMode.externalApplication);
      } else {
        throw AppLocalizations.of(context)!.support_cannotOpenUPI;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.support_upiError)),
        );
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

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
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // 1. The Header
          Column(
            children: [
              Icon(Icons.favorite_outline_rounded,
                  size: 80, color: Colors.red.shade300),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.support_title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.support_desc,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 48),

          // 2. The "Offering" Buttons
          Text(AppLocalizations.of(context)!.support_chooseOffering,
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAmountChip('21'),
              _buildAmountChip('51'),
              _buildAmountChip('101'),
            ],
          ),
          const SizedBox(height: 32),

          // 3. The "Custom Amount" Field
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.support_enterAmt,
              prefixText: '₹',
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _selectedAmount = ''; // Deselect chips if user is typing
              });
            },
          ),
          const SizedBox(height: 32),

          // 4. The "Donate" Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              final String amount = _amountController.text.isNotEmpty
                  ? _amountController.text
                  : _selectedAmount;

              if (amount.isEmpty || (double.tryParse(amount) ?? 0) <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text(AppLocalizations.of(context)!.support_validAmt)),
                );
                return;
              }

              _launchUPI(amount);
            },
            child: Text(AppLocalizations.of(context)!.support_now),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountChip(String amount) {
    final bool isSelected = _selectedAmount == amount;
    return ChoiceChip(
      label: Text('₹ $amount',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedAmount = amount;
          _amountController.clear();
          // Hide keyboard
          FocusScope.of(context).unfocus();
        });
      },
      selectedColor: Colors.orange.shade100,
      backgroundColor: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );
  }
}
