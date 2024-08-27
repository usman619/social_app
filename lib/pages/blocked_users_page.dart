import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/text_theme.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({super.key});

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  // Providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    loadBlockedUsers();
  }

  // Load Blocked Users
  void loadBlockedUsers() async {
    await databaseProvider.loadBlockedUsers();
  }

  // Show unblock user dialog
  void _showUnblockBox(String uid) {
    showDialog(
        context: context,
        builder: (conext) => AlertDialog(
                title: Text("Unblock User", style: titleTextTheme),
                content: Text("Are you sure you want to unblock this user?",
                    style: bodyTextTheme),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel",
                        style: bodyTextTheme.copyWith(
                            color: Theme.of(context).colorScheme.error)),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await databaseProvider.unblockUser(uid);
                    },
                    child: Text("Unblock",
                        style: bodyTextTheme.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    final blockedUsers = listeningProvider.blockedUsers;
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Users", style: titleTextTheme),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: blockedUsers.isEmpty
          ? Center(
              child: Text("No blocked users...", style: bodyTextTheme),
            )
          : ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(blockedUsers[index].name, style: bodyTextTheme),
                  subtitle: Text('@${blockedUsers[index].username}',
                      style: bodyTextTheme.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  trailing: IconButton(
                    icon: Icon(Icons.block,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () => _showUnblockBox(blockedUsers[index].uid),
                  ),
                );
              },
            ),
    );
  }
}
