import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const AppTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            focusColor: Theme.of(context).colorScheme.primary,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            label: Text(labelText),
            labelStyle: bodyTextTheme));
  }
}
/*
InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: color: Theme.of(context).colorScheme.primary),
                      ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Email',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )

                  ),

-------------------------------------------------------------
InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
*/