import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase/firebase_storage.dart';
import '../models/postmodel.dart';


class PostRepositoryImplementation {
  final FirebaseFirestore firestore;
  final FirebaseStorageService storageService;

  PostRepositoryImplementation(this.storageService, this.firestore);

  @override
  Future<void> createPost(PostModel post) async {
    try {
      await firestore
          .collection('posts')
          .doc(post.postID)
          .set(post.toFirestore());

      DocumentReference documentReference =
      await firestore.collection("users").doc(post.userID);
      await documentReference.update({
        "totalPosts": FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception("Error to create Post ${e.toString()}");
    }
  }


  Stream<List<PostModel>> getallRandomlyPosts(String Uid) {
    try {
      return firestore.collection("Posts").snapshots().map((snapshot) =>
          snapshot.docs
              .map((post) => PostModel.fromFirestore(post.data()))
              .where((post) => post.userID != Uid)
              .toList());
    } catch (e) {
      throw Exception("Error to get Post ${e.toString()}");
    }
  }

//create new post folder in firebase

  Future<String?> uploadUrlImage(File imageFile, String Uid) async {
    try {
      return await storageService.uploadFile(
          file: imageFile, userId: Uid, pathchild: "Posts");
    } catch (e) {
      throw Exception("Failed to upload ${e.toString()}");
    }
  }

//Home Posts

  Stream<List<PostModel>> getAllHomePosts() {
    return firestore
        .collection("Posts")
        .orderBy('createdAT', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((post) => PostModel.fromFirestore(post.data()))
        .toList());
  }
}