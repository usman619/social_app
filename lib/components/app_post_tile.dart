// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_provider.dart';
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
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
  final String currentUid = AuthService().getUserId();
  // More options for posts
  void _showOptions() {
    final bool isOwnPost = widget.post.uid == currentUid;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Check if the post is the user's own post
              if (isOwnPost)
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Delete',
                    style: bodyTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await databaseProvider.deletePost(widget.post.id);
                  },
                )
              else ...[
                // Report and Block
                ListTile(
                  leading: Icon(
                    Icons.report,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Report',
                    style: bodyTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.block,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Block',
                    style: bodyTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],

              ListTile(
                leading: Icon(
                  Icons.cancel,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Cancel',
                  style: bodyTextTheme.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // Like/unlike a post
  void _toggleLikePost() async {
    try {
      await databaseProvider.toggleLikePost(widget.post.id);
    } catch (e) {
      print(e);
    }
  }

  // Show follow button if the post is not the user's own post
  // TODO: Implement follow functionality for other users if not followed yet
  Widget _showFollowButthon() {
    if (currentUid == widget.post.uid) {
      return const SizedBox.shrink();
    } else {
      return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool likedByCurrentUser = listeningProvider.isPostLiked(widget.post.id);
    int likeCount = listeningProvider.getLikeCount(widget.post.id);
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

                _showFollowButthon(),
                const SizedBox(width: 5),
                // More Options
                GestureDetector(
                  onTap: _showOptions,
                  child: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
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
            Row(
              children: [
                // Likes
                GestureDetector(
                  onTap: _toggleLikePost,
                  child: Row(
                    children: [
                      likedByCurrentUser
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Text('$likeCount',
                    style: bodyTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                const SizedBox(width: 5),
                // Comments
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Text('count',
                    style: bodyTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                const Spacer(),
                //TimeStamp
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
