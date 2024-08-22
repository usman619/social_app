import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_bio_box.dart';
import 'package:social_app/components/app_input_alert_box.dart';
import 'package:social_app/components/app_post_tile.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/text_theme.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  UserProfile? user;
  String currentUserId = AuthService().getUserId();
  bool _isLoading = true;

  final bioTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // User Profile
  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(widget.uid);
    setState(() {
      _isLoading = false;
    });
  }

  // User Bio
  Future<void> saveBio() async {
    setState(() {
      _isLoading = true;
    });
    await databaseProvider.updateBio(bioTextController.text);
    await loadUser();
    setState(() {
      _isLoading = false;
    });
  }

  // Edit Bio
  void _showEditBioBox() {
    showDialog(
      context: context,
      builder: (context) => AppInputAlertBox(
        textController: bioTextController,
        hintText: "Edit Bio...",
        onPressed: saveBio,
        onPressedText: "Save",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allUserPosts = databaseProvider.filterUserPosts(widget.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading ? '' : user!.name,
          style: titleTextTheme,
        ),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                _isLoading ? '' : '@${user!.username}',
                style: bodyTextTheme.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(25),
                child: Icon(
                  Icons.person,
                  size: 75,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bio',
                    style: bodyTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  if (currentUserId == widget.uid)
                    GestureDetector(
                      onTap: _showEditBioBox,
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AppBioBox(text: _isLoading ? '...' : user!.bio),
            ),
            const SizedBox(height: 5),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Posts: ${allUserPosts.length}',
                style: bodyTextTheme.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            allUserPosts.isEmpty
                ? const Center(
                    child: Text('No posts yet...'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allUserPosts.length,
                    itemBuilder: (context, index) {
                      return AppPostTile(
                        post: allUserPosts[index],
                        onUserTap: () {},
                        onPostTap: () {},
                        showFollowButton: false,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
