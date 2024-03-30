import 'dart:ui';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {super.key,
      required this.fieldLabel,
      required this.fieldHintText,
      required this.fieldId,
      required this.onChanged});

  final int fieldId;
  final String fieldLabel;
  final String fieldHintText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(fieldLabel,
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(45, 45, 45, 1),
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field cannot be empty';
              }
              if (value.startsWith(" ")) {
                return 'Value cannot contain blank spaces';
              }
              return null;
            },
            onChanged: (value) {
              onChanged(value);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: fieldHintText,
            ))
      ],
    );
  }
}
