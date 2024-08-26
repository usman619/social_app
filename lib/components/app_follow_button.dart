import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppFollowButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isFollowing;
  const AppFollowButton(
      {super.key, required this.onPressed, required this.isFollowing});

  @override
  Widget build(BuildContext context) {
    // Outside padding
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ClipRRect(
        // Border Radius
        borderRadius: BorderRadius.circular(12.0),
        // Button
        child: MaterialButton(
          onPressed: onPressed,
          // Inside padding
          padding: const EdgeInsets.all(25.0),
          // Button color
          color:
              isFollowing ? Theme.of(context).colorScheme.primary : Colors.blue,
          child: Text(
            isFollowing ? 'Unfollow' : 'Follow',
            style: bodyTextTheme.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
