import 'package:flutter/material.dart';
import 'package:social_app/models/comment.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth/auth_service.dart';
import 'package:social_app/services/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();
  final _auth = AuthService();

  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);

  Future<void> updateBio(String bio) => _db.updateUserBioInFirebase(bio);

  List<Post> _allPosts = [];

  List<Post> get allPosts => _allPosts;

  // Post a message
  Future<void> postMessage(String message) async {
    await _db.postMessageToFirebase(message);
    await loadAllPosts();
  }

  // Load all posts
  Future<void> loadAllPosts() async {
    final allPosts = await _db.getAllPostsFromFirebase();
    // Get all Posts
    _allPosts = allPosts;

    // Block Users id and filter Posts
    final blockedUsers = await _db.getBlockedUsersFromFirebase();
    _allPosts =
        _allPosts.where((post) => !blockedUsers.contains(post.uid)).toList();

    // Initialize like count and liked posts
    initializeLikeMap();

    notifyListeners();
  }

  // Filter posts by user
  List<Post> filterUserPosts(String uid) {
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  // Filter posts by post id
  Future<void> deletePost(String postId) async {
    await _db.deletePostFromFirebase(postId);
    // Reload all posts
    await loadAllPosts();
  }

  // Local like count for each post
  Map<String, int> _likeCount = {};
  // Local liked posts by current user
  List<String> _likedPosts = [];

  // Is current post liked by user
  bool isPostLiked(String postId) => _likedPosts.contains(postId);

  // Get like count for post
  int getLikeCount(String postId) => _likeCount[postId] ?? 0;

  // Initialize like count and liked posts
  void initializeLikeMap() {
    String uid = _auth.getUserId();
    // Reset the local memory
    _likedPosts.clear();

    // Set the like count for each post
    for (var post in _allPosts) {
      _likeCount[post.id] = post.likes;
      if (post.likedBy.contains(uid)) {
        _likedPosts.add(post.id);
      }
    }
  }

  // Like a post
  Future<void> toggleLikePost(String postId) async {
    /*
      Update the local like count and liked posts first and then update the database.
    */

    final likedPostsOriginal = _likedPosts;
    final likeCountOriginal = _likeCount;

    if (_likedPosts.contains(postId)) {
      _likedPosts.remove(postId);
      _likeCount[postId] = (_likeCount[postId] ?? 0) - 1;
    } else {
      _likedPosts.add(postId);
      _likeCount[postId] = (_likeCount[postId] ?? 0) + 1;
    }

    // Update the locally
    notifyListeners();

    // Update the database

    try {
      await _db.toggleLikeInFirebase(postId);
    } catch (e) {
      print(e.toString());

      // If there is an error, revert the changes
      _likedPosts = likedPostsOriginal;
      _likeCount = likeCountOriginal;
      notifyListeners();
    }
  }

  // Comments
  // Local Comments
  Map<String, List<Comment>> _comments = {};

  // get locally stored comments for post
  List<Comment> getComments(String postId) => _comments[postId] ?? [];

  // Get all comments from Firebase
  Future<void> loadComments(String postId) async {
    final allComments = await _db.getCommentsFromFirebase(postId);
    _comments[postId] = allComments;

    notifyListeners();
  }

  // Add a comment to the post
  Future<void> addComment(String postId, message) async {
    await _db.addCommentInFirebase(postId, message);
    // Reload comments
    await loadComments(postId);
  }

  // Delete a comment
  Future<void> deleteComment(String postId, commentId) async {
    await _db.deleteCommentFromFirebase(commentId);
    // Reload comments
    await loadComments(postId);
  }

  // Account related functions
  // Locally stored blocked users
  List<UserProfile> _blockedUsers = [];

  List<UserProfile> get blockedUsers => _blockedUsers;

  // Load all blocked users
  Future<void> loadBlockedUsers() async {
    final blockedUsersIds = await _db.getBlockedUsersFromFirebase();

    final blockedUsersData = await Future.wait(
      blockedUsersIds.map((id) => _db.getUserFromFirebase(id)),
    );
    // Update the local memory
    _blockedUsers = blockedUsersData.whereType<UserProfile>().toList();
    // Update UI
    notifyListeners();
  }

  // Block a User
  Future<void> blockUser(String userId) async {
    await _db.blockUserInFirebase(userId);
    // Reload blocked users
    await loadBlockedUsers();
    // Reload Posts
    await loadAllPosts();

    notifyListeners();
  }

  // Unblock a User
  Future<void> unblockUser(String userId) async {
    await _db.unblockUserInFirebase(userId);
    // Reload blocked users
    await loadBlockedUsers();
    // Reload Posts
    await loadAllPosts();

    notifyListeners();
  }

  // Report User and Post
  Future<void> reportUser(String postId, userId) async {
    await _db.reportUserInFirebase(postId, userId);
  }
}
