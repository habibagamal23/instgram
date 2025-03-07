import 'package:cloud_firestore/cloud_firestore.dart';

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


  //Profile Posts
  Stream<List<PostModel>> getOnlyMyPosts(String Uid) {
    try {
      return firestore
          .collection('Posts')
          .where("userID", isEqualTo: Uid)
          .orderBy('createdAT', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((post) => PostModel.fromFirestore(post.data()))
          .toList());
    } catch (e) {
      throw Exception("Error to get Post ${e.toString()}");
    }
  }
}
