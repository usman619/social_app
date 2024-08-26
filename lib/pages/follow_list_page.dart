import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_user_tile.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/text_theme.dart';

/*
  Follow List Page 
  - Show two tabs: Followers and Following
*/

class FollowListPage extends StatefulWidget {
  final String uid;
  const FollowListPage({super.key, required this.uid});

  @override
  State<FollowListPage> createState() => _FollowListPageState();
}

class _FollowListPageState extends State<FollowListPage> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    loadFollowerList();
    loadFollowingList();
  }

  Future<void> loadFollowerList() async {
    await databaseProvider.loadUserFollowerProfiles(widget.uid);
  }

  Future<void> loadFollowingList() async {
    await databaseProvider.loadUserFollowingProfiles(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    final followers = listeningProvider.getListOfFollowerProfiles(widget.uid);
    final following = listeningProvider.getListOfFollowingProfiles(widget.uid);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
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
                text: 'Followers',
              ),
              Tab(
                text: 'Following',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Followers
            _buildUserList(followers, 'No followers...'),
            // Following
            _buildUserList(following, 'Not following...'),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(List<UserProfile> userList, String emptyMessage) {
    return userList.isEmpty
        ? Center(
            child: Text(emptyMessage, style: bodyTextTheme),
          )
        : ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              return AppUserTile(user: user);
            },
          );
  }
}
