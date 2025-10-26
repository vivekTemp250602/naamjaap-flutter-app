import 'package:flutter/material.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomMantraEditor extends StatefulWidget {
  const CustomMantraEditor({super.key});

  @override
  State<CustomMantraEditor> createState() => _CustomMantraEditorState();
}

class _CustomMantraEditorState extends State<CustomMantraEditor> {
  final _textController = TextEditingController();
  String _selectedBackgroundId = AppConstants.customBackgrounds.first.id;
  Widget _currentBackground = AppConstants.customBackgrounds.first.child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Mantra'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Live Preview
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 599),
                child: Container(
                  key: ValueKey(_selectedBackgroundId),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(child: _currentBackground),
                      Container(
                        color: Colors.black.withAlpha(80),
                      ),
                      Center(
                        child: Text(
                          _textController.text.isEmpty
                              ? "Your Mantra"
                              : _textController.text,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 10.0, color: Colors.black54),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // The Controls
            Container(
              padding: const EdgeInsets.all(24.0),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: "Mantra Name",
                      hintText: "e.g., Om Gurave Namah",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() {}), // Update preview
                  ),
                  const SizedBox(height: 24),
                  Text("Choose a background:",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: AppConstants.customBackgrounds.map((bg) {
                        final isSelected = bg.id == _selectedBackgroundId;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedBackgroundId = bg.id;
                              _currentBackground = bg.child;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: bg.thumbnail,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          Provider.of<MantraProvider>(context, listen: false)
                              .addCustomMantra(
                            mantraName: _textController.text,
                            backgroundId: _selectedBackgroundId,
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Save Mantra"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
