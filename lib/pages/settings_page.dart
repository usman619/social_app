import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_settings_tile.dart';
import 'package:social_app/themes/text_theme.dart';
import 'package:social_app/themes/theme_provider.dart';

/*

  Settings Page
  - Dark Mode
  - Block Users
  - Account Settings

*/

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('SETTINGS', style: titleTextTheme),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          AppSettingsTile(
            title: 'Dark Mode',
            action: CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
