import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppBioBox extends StatelessWidget {
  final String text;
  const AppBioBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(25.0),
      child: Text(
        text.isEmpty ? 'Empty Bio...' : text,
        style: bodyTextTheme,
      ),
    );
  }
}
