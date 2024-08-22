import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_settings_tile.dart';
import 'package:social_app/helper/navigate_pages.dart';
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
      // backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('SETTINGS', style: titleTextTheme),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Light Mode <--> Dark Mode
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
          // Block Users
          AppSettingsTile(
            title: 'Block Users',
            action: IconButton(
              onPressed: () => goBlockUsersPage(context),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          // Account Settings
          AppSettingsTile(
            title: 'Account Settings',
            action: IconButton(
              onPressed: () => goAccountSettingsPage(context),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
