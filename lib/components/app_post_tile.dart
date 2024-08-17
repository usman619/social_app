// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/themes/text_theme.dart';

class AppPostTile extends StatefulWidget {
  final Post post;
  final void Function()? onUserTap;
  final void Function()? onPostTap;
  final bool showFollowButton;
  const AppPostTile({
    super.key,
    required this.post,
    required this.onUserTap,
    required this.onPostTap,
    required this.showFollowButton,
  });

  @override
  State<AppPostTile> createState() => _AppPostTileState();
}

class _AppPostTileState extends State<AppPostTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPostTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Profile Picture, Name, Username
                GestureDetector(
                  onTap: widget.onUserTap,
                  child: Row(
                    children: [
                      // Profile picture
                      Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      // Name and Username
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            widget.post.name,
                            style: bodyTextTheme.copyWith(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                          ),
                          // Username5.0
                          Text(
                            '@${widget.post.username}',
                            style: bodyTextTheme.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                widget.showFollowButton
                    ? TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Follow',
                          style: bodyTextTheme.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(height: 10),
            // Message
            Text(
              widget.post.message,
              style: bodyTextTheme.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 5),
            // Likes and Comments
            //TODO: Add Likes and Comments
            //TimeStamp
            Row(
              children: [
                const Spacer(),
                Text(
                  timeAgo(widget.post.timestamp.toDate()),
                  style: bodyTextTheme.copyWith(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String timeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}m';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }

  // Widget followButton(bool ){

  // }
}
