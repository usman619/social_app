import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth/auth_service.dart';
/*
Database Service
  - User Profile [Done]
  - Post message [Done]
  - Likes
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
}
