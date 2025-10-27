import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';

class SankalpaEditorScreen extends StatefulWidget {
  final String uid;
  final Map<String, dynamic> jappsMap;
  const SankalpaEditorScreen(
      {super.key, required this.uid, required this.jappsMap});

  @override
  State<SankalpaEditorScreen> createState() => _SankalpaEditorScreenState();
}

class _SankalpaEditorScreenState extends State<SankalpaEditorScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final _countController = TextEditingController();

  Mantra? _selectedMantra;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final mantraProvider = Provider.of<MantraProvider>(context, listen: false);
    final allMantras = mantraProvider.allMantras;
    _selectedMantra ??= allMantras.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile_sankalpaSet),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // 1. Mantra Selector
          DropdownButtonFormField<Mantra>(
            initialValue: _selectedMantra,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.dialog_sankalpaSelectMantra,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.book_outlined),
            ),
            items: allMantras.map((mantra) {
              return DropdownMenuItem(
                value: mantra,
                child: Text(mantra.name, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: (mantra) {
              if (mantra != null) {
                setState(() {
                  _selectedMantra = mantra;
                });
              }
            },
          ),
          const SizedBox(height: 24),

          // 2. Target Count
          TextField(
            controller: _countController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.dialog_sankalpaTargetCount,
              hintText: "e.g., 11000",
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.flag_outlined),
            ),
          ),
          const SizedBox(height: 24),

          // 3. Target Date
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(color: Colors.grey.shade400),
            ),
            leading: const Icon(Icons.calendar_today_outlined),
            title:
                Text(AppLocalizations.of(context)!.dialog_sankalpaTargetDate),
            subtitle: Text(
              _selectedDate == null
                  ? AppLocalizations.of(context)!.dialog_sankalpaSelectDate
                  : DateFormat('dd MMMM yyyy').format(_selectedDate!),
            ),
            onTap: _pickDate,
          ),
          const SizedBox(height: 48),

          // 4. Save Button
          ElevatedButton(
            onPressed: _saveSankalpa,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: Text(AppLocalizations.of(context)!.dialog_sankalpaSetPledge),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveSankalpa() async {
    final targetCount = int.tryParse(_countController.text);

    if (_selectedMantra == null ||
        targetCount == null ||
        targetCount <= 0 ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.dialog_sankalpaError)),
      );
      return;
    }

    // THIS IS THE SNAPSHOT!
    final int startCount = widget.jappsMap[_selectedMantra!.id] as int? ?? 0;

    if (targetCount <= startCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context)!.dialog_sankalpaErrorTarget)),
      );
      return;
    }

    await _firestoreService.setSankalpa(
      uid: widget.uid,
      mantra: _selectedMantra!,
      targetCount: targetCount,
      endDate: _selectedDate!,
      startCount: startCount,
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
