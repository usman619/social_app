import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/helper/time_ago.dart';
import 'package:social_app/models/comment.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/text_theme.dart';

class AppCommentTile extends StatelessWidget {
  final Comment comment;
  final void Function()? onUserTap;
  const AppCommentTile({
    super.key,
    required this.comment,
    required this.onUserTap,
  });

  //More Options
  void _showOptions(BuildContext context) {
    final String currentUid = AuthService().getUserId();
    final bool isOwnComment = comment.uid == currentUid;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Check if the post is the user's own post
              if (isOwnComment)
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
                    await Provider.of<DatabaseProvider>(context, listen: false)
                        .deleteComment(comment.postId, comment.id);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onUserTap,
            child: Row(
              children: [
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
                      comment.name,
                      style: bodyTextTheme.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    // Username5.0
                    Text(
                      '@${comment.username}',
                      style: bodyTextTheme.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _showOptions(context),
                  child: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            comment.message,
            style: bodyTextTheme.copyWith(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              //TimeStamp
              Text(
                timeAgo(comment.timestamp.toDate()),
                style: bodyTextTheme.copyWith(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
