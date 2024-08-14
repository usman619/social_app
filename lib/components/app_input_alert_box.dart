import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_app/themes/text_theme.dart';

class AppInputAlertBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final void Function()? onPressed;
  final String onPressedText;
  const AppInputAlertBox({
    super.key,
    required this.textController,
    required this.hintText,
    required this.onPressed,
    required this.onPressedText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: TextField(
        controller: textController,
        maxLength: 140,
        maxLines: 3,
        style: bodyTextTheme,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: bodyTextTheme,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          counterStyle: bodyTextTheme.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            textController.clear();
          },
          child: Text(
            'Cancel',
            style: bodyTextTheme,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onPressed!();
            textController.clear();
          },
          child: Text(
            onPressedText,
            style: bodyTextTheme,
          ),
        ),
      ],
    );
  }
}

/*
AlertDialog(
        title: const Text('Edit Bio'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Enter your bio',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
*/