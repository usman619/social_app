import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_drawer.dart';
import 'package:social_app/components/app_input_alert_box.dart';
import 'package:social_app/components/app_post_tile.dart';
import 'package:social_app/helper/navigate_pages.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/text_theme.dart';

/*
  Home Page
  - Show two tabs (All Posts, Following Posts)

*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAllPosts();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // Load all Posts
  void loadAllPosts() async {
    await databaseProvider.loadAllPosts();
  }

  // Write a message and Post
  void _openPostMessage() {
    showDialog(
      context: context,
      builder: (context) => AppInputAlertBox(
        textController: _messageController,
        hintText: "What's on your mind?",
        onPressed: () async {
          await postMessage(_messageController.text);
        },
        onPressedText: "Post",
      ),
    );
  }

  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text('Home Page', style: titleTextTheme),
          foregroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          bottom: TabBar(
            labelStyle: bodyTextTheme.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            labelColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedLabelColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.inversePrimary,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(
                text: 'For You',
              ),
              Tab(
                text: 'Following',
              ),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: [
            _buildPostList(listeningProvider.allPosts),
            _buildPostList(listeningProvider.followingPosts),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openPostMessage,
          child: const Icon(Icons.create),
        ),
      ),
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? Center(
            child: Text('Nothing to see here...', style: bodyTextTheme),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return AppPostTile(
                  post: post,
                  onUserTap: () => goUserProfile(context, post.uid),
                  onPostTap: () => goPostPost(context, post),
                  showFollowButton: true);
            },
          );
  }
}
