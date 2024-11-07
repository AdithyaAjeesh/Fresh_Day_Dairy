import 'package:flutter/material.dart';

class CustomTextfields extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomTextfields({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextFormField(
      style: TextStyle(
        color: theme.tertiary,
      ),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.secondary,
        labelText: labelText,
        labelStyle: TextStyle(
          color: theme.tertiary,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
