import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppSettingsTile extends StatelessWidget {
  final String title;
  final Widget action;
  const AppSettingsTile({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: bodyTextTheme,
          ),
          action,
        ],
      ),
    );
  }
}
