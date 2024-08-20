import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/comment.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth/auth_service.dart';
/*
Database Service
  - User Profile [Done]
  - Post message [Done]
  - Likes [Done]
  - Comments
  - Delete Account
  - Report Account
  - Block Account
  - Follow/Unfollow
  - Search
*/

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Save User Info
  Future<void> saveUserInfoFirebase(
      {required String name, required String email}) async {
    String uid = _auth.currentUser!.uid;
    String username = email.split('@')[0];

    UserProfile user = UserProfile(
      uid: uid,
      name: name,
      email: email,
      username: username,
      bio: '',
    );
    final userMap = user.toMap();

    await _db.collection("Users").doc(uid).set(userMap);
  }

  // Get User Profile
  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Update User Bio
  Future<void> updateUserBioInFirebase(String bio) async {
    String uid = AuthService().getUserId();
    try {
      await _db.collection("Users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

  // Post a message
  Future<void> postMessageToFirebase(String message) async {
    try {
      String uid = _auth.currentUser!.uid;
      UserProfile? user = await getUserFromFirebase(uid);
      Post post = Post(
        id: '',
        uid: uid,
        name: user!.name,
        username: user.username,
        message: message,
        timestamp: Timestamp.now(),
        likes: 0,
        likedBy: [],
      );

      Map<String, dynamic> newPostMap = post.toMap();
      await _db.collection("Posts").add(newPostMap);
    } catch (e) {
      print(e.toString());
    }
  }

  // Get all posts
  Future<List<Post>> getAllPostsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection("Posts")
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  // Delete Post
  Future<void> deletePostFromFirebase(String postId) async {
    try {
      await _db.collection("Posts").doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // Like Post
  Future<void> toggleLikeInFirebase(String postId) async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentReference postDoc = _db.collection("Posts").doc(postId);

      await _db.runTransaction(
        (transaction) async {
          // Get the post data
          DocumentSnapshot postSnapshot = await transaction.get(postDoc);

          // Get the current like count and likedBy list
          List<String> likedBy =
              List<String>.from(postSnapshot['likedBy'] ?? []);
          int currentLikeCount = postSnapshot['likes'];

          if (!likedBy.contains(uid)) {
            // Like the post
            likedBy.add(uid);
            currentLikeCount++;
          } else {
            // Unlike the post
            likedBy.remove(uid);
            currentLikeCount--;
          }
          // Update the post data
          transaction.update(
            postDoc,
            {
              'likes': currentLikeCount,
              'likedBy': likedBy,
            },
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Comment on Post
  // Add a comment to the post
  Future<void> addCommentInFirebase(String postId, message) async {
    try {
      // Get the user info
      String uid = _auth.currentUser!.uid;
      UserProfile? user = await getUserFromFirebase(uid);

      // Create a new comment
      Comment newComment = Comment(
        id: '',
        postId: postId,
        uid: uid,
        name: user!.name,
        username: user.username,
        message: message,
        timestamp: Timestamp.now(),
      );

      // Convert to Map
      Map<String, dynamic> newCommentMap = newComment.toMap();
      await _db.collection("Comments").add(newCommentMap);
    } catch (e) {
      e.toString();
    }
  }

  // Delete a comment
  Future<void> deleteCommentFromFirebase(String commentId) async {
    try {
      await _db.collection("Comments").doc(commentId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // Fetch all comments
  Future<List<Comment>> getCommentsFromFirebase(String postId) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection("Comments")
          .where("postId", isEqualTo: postId)
          .get();

      return snapshot.docs.map((doc) => Comment.fromDocument(doc)).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
