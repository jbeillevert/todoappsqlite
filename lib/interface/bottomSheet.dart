import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomSheetPopup extends StatefulWidget {
  const BottomSheetPopup({Key? key}) : super(key: key);

  @override
  State<BottomSheetPopup> createState() => _BottomSheetPopupState();
}

class _BottomSheetPopupState extends State<BottomSheetPopup> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Titre de la tâche'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Navigator.of(context).pop(controller.text);
                }
              },
              child: const Text('Ajouter'),
            )
          ],
        ),
      ),
    );
  }
}