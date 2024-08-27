import 'package:flutter/material.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_service.dart';
import 'package:social_app/themes/text_theme.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  void confirmDeletion(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Account Deletion",
                  style: titleTextTheme.copyWith(fontSize: 18)),
              content: Text(
                "Are you sure you want to delete your account?",
                style: bodyTextTheme,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: bodyTextTheme,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Delete Account
                    String uid = AuthService().getUserId();

                    await DatabaseService().deleteUserInfoFromFirebase(uid);

                    await AuthService().deleteAccount();

                    // Navigate to AuthGate
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Delete',
                    style: bodyTextTheme.copyWith(color: Colors.red),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: titleTextTheme,
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => confirmDeletion(context),
            child: Container(
              padding: const EdgeInsets.all(25.0),
              margin: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Text(
                  'Delete Account',
                  style: bodyTextTheme.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
