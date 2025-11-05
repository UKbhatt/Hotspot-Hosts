import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String hint;
  final int maxLength;
  final Function(String) onChanged;

  const TextInputField({
    super.key,
    required this.hint,
    required this.maxLength,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 4,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        counterText: '',
      ),
    );
  }
}
