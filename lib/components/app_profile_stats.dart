import 'package:flutter/material.dart';
import 'package:social_app/themes/text_theme.dart';

class AppProfileStats extends StatelessWidget {
  final int postCount;
  final int followerCount;
  final int followingCount;
  final void Function()? onTap;
  const AppProfileStats({
    super.key,
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Post Count
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(postCount.toString(),
                    style: bodyTextTheme.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.inversePrimary)),
                Text(
                  'Posts',
                  style: bodyTextTheme.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),

          // Followers Count
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(followerCount.toString(),
                    style: bodyTextTheme.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.inversePrimary)),
                Text(
                  'Followers',
                  style: bodyTextTheme.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          // Following Count
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  followingCount.toString(),
                  style: bodyTextTheme.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                Text(
                  'Following',
                  style: bodyTextTheme.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
