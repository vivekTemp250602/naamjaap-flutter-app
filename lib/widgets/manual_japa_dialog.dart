import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';

class ManualJapaDialog extends StatefulWidget {
  final String uid;
  const ManualJapaDialog({super.key, required this.uid});

  @override
  State<ManualJapaDialog> createState() => _ManualJapaDialogState();
}

class _ManualJapaDialogState extends State<ManualJapaDialog> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _countController = TextEditingController();

  Mantra? _selectedMantra;
  DateTime _selectedDate = DateTime.now();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Auto-select the mantra currently active in the provider
    final provider = Provider.of<MantraProvider>(context, listen: false);
    _selectedMantra = provider.selectedMantra ?? provider.allMantras.first;
  }

  @override
  Widget build(BuildContext context) {
    final allMantras =
        Provider.of<MantraProvider>(context, listen: false).allMantras;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOutBack),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2E0422), Color(0xFF000000)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: const Color(0xFFFFD700).withOpacity(0.3),
                          width: 1.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.purple.shade900.withOpacity(0.5),
                            blurRadius: 40,
                            spreadRadius: 2)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // --- HEADER ---
                        const Icon(Icons.edit_note_rounded,
                            color: Color(0xFFFFD700), size: 40),
                        const SizedBox(height: 16),
                        const Text(
                          "Log Offline Japa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Serif',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add counts from your physical mala",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // --- 1. MANTRA SELECTOR ---
                        _buildLabel("Select Mantra"),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white24)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Mantra>(
                              value: _selectedMantra,
                              dropdownColor: const Color(0xFF2E0422),
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.orange),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                              items: allMantras.map((mantra) {
                                return DropdownMenuItem(
                                  value: mantra,
                                  child: Text(mantra.name),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedMantra = val),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // --- 2. COUNT INPUT ---
                        _buildLabel("Japa Count"),
                        TextFormField(
                          controller: _countController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "e.g. 108",
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.3)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                            suffixIcon: const Icon(Icons.numbers_rounded,
                                color: Colors.white54),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // --- 3. DATE SELECTOR ---
                        _buildLabel("Date"),
                        GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white24)),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Colors.orange, size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  DateFormat('MMMM dd, yyyy')
                                      .format(_selectedDate),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // --- SUBMIT BUTTON ---
                        SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF8C00),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 10,
                              shadowColor: Colors.orange.withOpacity(0.5),
                            ),
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2))
                                : const Text(
                                    "ADD TO TOTAL",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.white54)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Color(0xFF2E0422),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submit() async {
    final count = int.tryParse(_countController.text);

    if (count == null || count <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter a valid number"),
            backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await _firestoreService.logManualJapa(
        uid: widget.uid,
        mantraId: _selectedMantra!.id,
        count: count,
        date: _selectedDate,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Japa added successfully!"),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }
}
