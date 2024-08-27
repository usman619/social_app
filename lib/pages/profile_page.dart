import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_bio_box.dart';
import 'package:social_app/components/app_follow_button.dart';
import 'package:social_app/components/app_input_alert_box.dart';
import 'package:social_app/components/app_post_tile.dart';
import 'package:social_app/components/app_profile_stats.dart';
import 'package:social_app/helper/navigate_pages.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/pages/follow_list_page.dart';
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

  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // User Profile
  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(widget.uid);
    // Load the Followers and Followings of the User
    await databaseProvider.loadUserFollowers(widget.uid);
    await databaseProvider.loadUserFollowing(widget.uid);
    // Check if the current user is following the target user
    _isFollowing = databaseProvider.isFollowing(widget.uid);
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

  // Toggle Follow
  Future<void> toggleFollow() async {
    if (_isFollowing) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Unfollow', style: titleTextTheme),
          content: Text('Are you sure you want to unfollow ${user!.username}?',
              style: bodyTextTheme),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: bodyTextTheme),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // Perform Unfollow
                await databaseProvider.unfollowUser(widget.uid);
              },
              child: Text('Unfollow', style: bodyTextTheme),
            ),
          ],
        ),
      );
    } else {
      await databaseProvider.followUser(widget.uid);
    }
    // Update the isFollowing state
    setState(
      () {
        _isFollowing = !_isFollowing;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final allUserPosts = listeningProvider.filterUserPosts(widget.uid);
    final followerCount = listeningProvider.getFollowerCount(widget.uid);
    final followingCount = listeningProvider.getFollowingCount(widget.uid);
    _isFollowing = listeningProvider.isFollowing(widget.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading ? '' : user!.name,
          style: titleTextTheme,
        ),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => goHomePage(context),
        ),
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
            AppProfileStats(
              postCount: allUserPosts.length,
              followerCount: followerCount,
              followingCount: followingCount,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FollowListPage(
                      uid: widget.uid,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            // Follow Button
            if (user != null && user!.uid != currentUserId)
              AppFollowButton(
                onPressed: toggleFollow,
                isFollowing: _isFollowing,
              ),
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
                        onPostTap: () =>
                            goPostPost(context, allUserPosts[index]),
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
