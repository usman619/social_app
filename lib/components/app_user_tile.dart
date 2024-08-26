import 'package:flutter/material.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/themes/text_theme.dart';

class AppUserTile extends StatelessWidget {
  final UserProfile user;

  const AppUserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        // User's Name
        title: Text(
          user.name,
          style: bodyTextTheme.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        // Username
        subtitle: Text(
          '@${user.username}',
          style: bodyTextTheme.copyWith(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        //Profile Picture
        leading: Icon(
          Icons.person,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.primary),
        // Navigate to Profile Page
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(uid: user.uid),
            ),
          );
        },
      ),
    );
  }
}
