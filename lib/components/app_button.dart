import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: bodyTextTheme,
          ),
        ),
      ),
    );
  }
}
