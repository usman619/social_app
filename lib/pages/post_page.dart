/*
  Post Page
  - show comments
  - show likes
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_comment_tile.dart';
import 'package:social_app/components/app_post_tile.dart';
import 'package:social_app/helper/navigate_pages.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/text_theme.dart';

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({super.key, required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final allComments = listeningProvider.getComments(widget.post.id);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.post.username, style: titleTextTheme),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            AppPostTile(
              post: widget.post,
              onUserTap: () => goUserProfile(context, widget.post.uid),
              onPostTap: () {},
              showFollowButton: false,
            ),
            const SizedBox(height: 10),
            Divider(
              height: 10,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            // All Comments on this post
            allComments.isEmpty
                ? Center(
                    child: Text(
                      "No Comments",
                      style: bodyTextTheme,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allComments.length,
                    itemBuilder: (context, index) {
                      final comment = allComments[index];
                      return AppCommentTile(
                        comment: comment,
                        onUserTap: () {
                          goUserProfile(context, comment.uid);
                        },
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
