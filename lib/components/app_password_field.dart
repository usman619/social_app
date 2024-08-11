import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const AppPasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = true,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText, // Use the local state _obscureText here
      decoration: InputDecoration(
        focusColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        label: Text(widget.labelText),
        labelStyle: bodyTextTheme,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText =
                  !_obscureText; // Toggle the local state _obscureText
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
