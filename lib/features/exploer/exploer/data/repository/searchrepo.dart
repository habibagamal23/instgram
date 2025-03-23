import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../register/data/models/UserModel.dart';

class SearchRepo {
  final FirebaseFirestore firestore;

  SearchRepo({required this.firestore});

  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final querySnapshotUsername = await firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThanOrEqualTo: query +'\uf8ff') // Adjust query range for case-insensitive search
          .get();

      final querySnapshotEmail = await firestore
          .collection('users')
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThanOrEqualTo: query + '\uf8ff') // Same adjustment for email
          .get();

      final allUsers = <UserModel>[];

      // Map the username results
      querySnapshotUsername.docs.forEach((doc) {
        allUsers.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>));
      });

      // Map the email results
      querySnapshotEmail.docs.forEach((doc) {
        allUsers.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>));
      });

      // Remove duplicates (if any user appears in both username and email results)
      final uniqueUsers = allUsers.toSet().toList();

      if (uniqueUsers.isEmpty) {
        throw Exception("No users found");
      }

      return uniqueUsers;
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }


  Future<UserModel> getOntheruserProfile(String uid) async {
    try {
      DocumentSnapshot doc = await firestore.collection("users").doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }



  Future<void> FollowAndUnfollow(String currentUserId, String followedUserId, isAlreadyFollowing) async {

    try {


      if (!isAlreadyFollowing) {
        // Follow: add followedUserId to the current user's following array
        // and add currentUserId to the followed user's followers array.
        await firestore.collection("users").doc(currentUserId).update({
          'following': FieldValue.arrayUnion([followedUserId]),
          'totalFollowing': FieldValue.increment(1),
        });
        await firestore.collection("users").doc(followedUserId).update({
          'followers': FieldValue.arrayUnion([currentUserId]),
          'totalFollowers': FieldValue.increment(1),
        });
      } else {
        // Unfollow: remove followedUserId from the current user's following array
        // and remove currentUserId from the followed user's followers array.
        await firestore.collection("users").doc(currentUserId).update({
          'following': FieldValue.arrayRemove([followedUserId]),
          'totalFollowing': FieldValue.increment(-1),
        });
        await firestore.collection("users").doc(followedUserId).update({
          'followers': FieldValue.arrayRemove([currentUserId]),
          'totalFollowers': FieldValue.increment(-1),
        });
      }
    } catch (e) {
      throw Exception("Error toggling follow: $e");
    }
  }



}
