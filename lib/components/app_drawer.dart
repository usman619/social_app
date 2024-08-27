import 'package:flutter/material.dart';
import 'package:social_app/components/app_drawer_tile.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/pages/search_page.dart';
import 'package:social_app/pages/settings_page.dart';
import 'package:social_app/services/auth/auth_gate.dart';
import 'package:social_app/services/auth/auth_service.dart';

/*
  This Drawer contains the following items:
  - Home [Done]
  - Profile [Done]
  - Search [Done]
  - Settings [Done]
  - Logout [Done]

*/

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final _auth = AuthService();

  void logout(BuildContext context) async {
    await _auth.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthGate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 10),
              AppDrawerTile(
                title: "HOME",
                icon: Icons.home,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              AppDrawerTile(
                title: "SEARCH",
                icon: Icons.search,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
              ),
              AppDrawerTile(
                title: "PROFILE",
                icon: Icons.person,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        uid: _auth.getUserId(),
                      ),
                    ),
                  );
                },
              ),
              AppDrawerTile(
                title: "SETTINGS",
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
              ),
              const Spacer(),
              AppDrawerTile(
                title: "LOGOUT",
                icon: Icons.logout,
                onTap: () => logout(context),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
