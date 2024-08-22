import 'package:flutter/material.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/pages/account_settings_page.dart';
import 'package:social_app/pages/blocked_users_page.dart';
import 'package:social_app/pages/post_page.dart';
import 'package:social_app/pages/profile_page.dart';

// Goto user profile
void goUserProfile(BuildContext context, String uid) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(uid: uid),
    ),
  );
}

// Goto Post
void goPostPost(BuildContext context, Post post) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PostPage(post: post),
    ),
  );
}

// Goto Blocked Users Page
void goBlockUsersPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const BlockedUsersPage(),
    ),
  );
}

// Goto Account Settings Page
void goAccountSettingsPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AccountSettingsPage(),
    ),
  );
}
