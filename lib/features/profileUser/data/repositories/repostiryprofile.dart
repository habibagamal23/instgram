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

  Stream<UserModel> getUserProfileStream(String uid) {
    return firestore.collection("users").doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromFirestore(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    });
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



  Future<List<UserModel>> fetchFollowUsers(List<String> followUsersIds) async {
    QuerySnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereIn: followUsersIds)
        .get();
    List<UserModel> users = doc.docs
        .map((doc) => UserModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
    return users;
  }

}
