import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

// --- VISUAL FX: RISING PROMISES ---
class SankalpaSparkles extends CustomPainter {
  final AnimationController controller;
  final List<_Sparkle> sparkles = [];
  final math.Random random = math.Random();

  SankalpaSparkles(this.controller) : super(repaint: controller) {
    for (int i = 0; i < 20; i++) {
      sparkles.add(_Sparkle(random));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var s in sparkles) {
      s.update(size.height, size.width);
      paint.color = Colors.white.withOpacity(s.opacity * 0.3);
      canvas.drawCircle(Offset(s.x, s.y), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Sparkle {
  late double x;
  late double y;
  late double speed;
  late double size;
  late double opacity;
  final math.Random rnd;

  _Sparkle(this.rnd) {
    reset(true);
  }

  void reset(bool startRandomY) {
    x = rnd.nextDouble() * 500;
    y = startRandomY ? rnd.nextDouble() * 800 : 800;
    speed = 0.3 + rnd.nextDouble() * 0.8;
    size = 1.0 + rnd.nextDouble() * 2.0;
    opacity = 0.1 + rnd.nextDouble() * 0.5;
  }

  void update(double height, double width) {
    y -= speed;
    if (y < -50) reset(false);
  }
}

class SankalpaEditorScreen extends StatefulWidget {
  final String uid;
  final Map<String, dynamic> jappsMap;
  const SankalpaEditorScreen(
      {super.key, required this.uid, required this.jappsMap});

  @override
  State<SankalpaEditorScreen> createState() => _SankalpaEditorScreenState();
}

class _SankalpaEditorScreenState extends State<SankalpaEditorScreen>
    with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final _countController = TextEditingController();
  late final AnimationController _particleController;

  Mantra? _selectedMantra;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _particleController.dispose();
    _countController.dispose();
    super.dispose();
  }

  int _getCurrentCount() {
    if (_selectedMantra == null) return 0;
    return widget.jappsMap[_selectedMantra!.id] as int? ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final mantraProvider = Provider.of<MantraProvider>(context, listen: false);
    final allMantras = mantraProvider.allMantras;
    _selectedMantra ??= allMantras.first;

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
        title: Text(
          AppLocalizations.of(context)!.profile_sankalpaSet,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                  Color(0xFF6A0572),
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),

          // 2. Sparkles
          CustomPaint(
              painter: SankalpaSparkles(_particleController),
              size: Size.infinite),

          // 3. Form Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Center(
                          child: Column(
                            children: [
                              Icon(Icons.handshake_rounded,
                                  size: 48, color: Colors.deepOrange.shade400),
                              const SizedBox(height: 10),
                              Text(
                                "Create a Sacred Vow",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Commit to your spiritual growth",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // 1. Mantra Selector
                        _buildLabel(AppLocalizations.of(context)!
                            .dialog_sankalpaSelectMantra),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Mantra>(
                              value: _selectedMantra,
                              isExpanded: true,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: allMantras.map((mantra) {
                                return DropdownMenuItem(
                                  value: mantra,
                                  child: Text(mantra.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
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
                          ),
                        ),

                        // Current Status Helper
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 20, left: 4),
                          child: Text(
                            "Current Count: ${_getCurrentCount()}",
                            style: TextStyle(
                                color: Colors.deepOrange.shade400,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        // 2. Target Count
                        _buildLabel(AppLocalizations.of(context)!
                            .dialog_sankalpaTargetCount),
                        TextField(
                          controller: _countController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "e.g., 11000",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            prefixIcon: const Icon(Icons.flag_rounded,
                                color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 3. Target Date
                        _buildLabel(AppLocalizations.of(context)!
                            .dialog_sankalpaTargetDate),
                        GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: _selectedDate != null
                                        ? Colors.deepOrange
                                        : Colors.grey.shade300,
                                    width: _selectedDate != null ? 1.5 : 1)),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_rounded,
                                    color: _selectedDate != null
                                        ? Colors.deepOrange
                                        : Colors.grey),
                                const SizedBox(width: 12),
                                Text(
                                  _selectedDate == null
                                      ? AppLocalizations.of(context)!
                                          .dialog_sankalpaSelectDate
                                      : DateFormat('dd MMMM yyyy')
                                          .format(_selectedDate!),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _selectedDate != null
                                          ? Colors.black87
                                          : Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // 4. Save Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _saveSankalpa,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 5,
                              shadowColor: Colors.deepOrange.withOpacity(0.4),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .dialog_sankalpaSetPledge
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
            letterSpacing: 0.5),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepOrange, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
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
          content: Text(AppLocalizations.of(context)!.dialog_sankalpaError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final int startCount = _getCurrentCount();

    if (targetCount <= startCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(AppLocalizations.of(context)!.dialog_sankalpaErrorTarget),
          backgroundColor: Colors.orange,
        ),
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
