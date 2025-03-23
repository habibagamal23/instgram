import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../post/data/models/postmodel.dart';
import '../../../register/data/models/UserModel.dart';

class ProfileRepository {
  final FirebaseFirestore firestore;

  ProfileRepository(this.firestore);

  Future<UserModel> getUserProfile(String uid) async {
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

  Future<void> updateUserProfile(UserModel user) async {
    try {
      await firestore
          .collection("users")
          .doc(user.uid)
          .update(user.toFirestore());
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }

  Future<void> updateUserPostsInfo(String userId, String newProfileUrl, String newUsername) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('posts')
          .where('UserID', isEqualTo: userId)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.update({
            'profileUrl': newProfileUrl ,
            'username': newUsername
          });
          debugPrint("Updated post ${doc.id} with: ${doc.data()}");

      }
    } catch (e) {
      debugPrint("Error updating posts for user: $e");
    }
  }


  Future<void> FollowAndUnfollow(String currentUserId, String followedUserId) async {

    try {

      DocumentSnapshot snap = await firestore
          .collection('users')
          .doc(currentUserId)
          .get();
      List following = (snap.data()! as dynamic)['following'];
      bool isAlreadyFollowing = following?.contains(followedUserId) ?? false;

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
