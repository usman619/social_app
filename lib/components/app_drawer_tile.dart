import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const AppDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: drawerTextTheme,
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () => onTap!(),
    );
  }
}
