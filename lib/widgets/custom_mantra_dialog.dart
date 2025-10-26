import 'package:flutter/material.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/utils/constants.dart';

class CustomMantraDialog extends StatefulWidget {
  final String uid;
  const CustomMantraDialog({super.key, required this.uid});

  @override
  State<CustomMantraDialog> createState() => _CustomMantraDialogState();
}

class _CustomMantraDialogState extends State<CustomMantraDialog> {
  final FirestoreService _firestoreService = FirestoreService();
  final _textController = TextEditingController();
  String _selectedBackgroundId = AppConstants.customBackgrounds.first.id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Custom Mantra'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Mantra Name",
                hintText: "e.g., Om Gurave Namah",
              ),
            ),
            const SizedBox(height: 24),
            Text("Choose a background:",
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: AppConstants.customBackgrounds.map((bg) {
                    final isSelected = bg.id == _selectedBackgroundId;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBackgroundId = bg.id;
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
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              _firestoreService.addCustomMantra(
                  uid: widget.uid,
                  mantraName: _textController.text,
                  backgroundId: _selectedBackgroundId);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
