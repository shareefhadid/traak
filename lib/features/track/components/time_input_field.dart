import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeInputField extends StatelessWidget {
  const TimeInputField({super.key, required this.controller, this.focusNode});

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: 'Completion Time (seconds)',
        hintText: 'Enter time in seconds (e.g., 10.5)',
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          // Only allow a single decimal point
          if (newValue.text.isEmpty) {
            return newValue;
          }
          if (newValue.text.contains('.')) {
            if (newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
              // More than one decimal point, revert to old value
              return oldValue;
            }
          }
          return newValue;
        }),
      ],
    );
  }
}
