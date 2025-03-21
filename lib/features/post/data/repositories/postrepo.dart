import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_storage.dart';
import '../models/commetmodel.dart';
import '../models/postmodel.dart';

class PostRepositoryImplementation {
  final FirebaseFirestore firestore;
  final FirebaseStorageService storageService;

  PostRepositoryImplementation(this.storageService, this.firestore);
  Future<void> createPost(PostModel post) async {
    try {
      await firestore
          .collection('posts')
          .doc(post.postID)
          .set(post.toFirestore());

      DocumentReference userRef =
          firestore.collection("users").doc(post.userID);
      await userRef.update({
        "totalPosts": FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception("Error creating post: ${e.toString()}");
    }
  }

  Stream<List<PostModel>> getExploerPosts(String userId) {
    debugPrint("getExploerPosts $userId");
    final ExploerpostCollection =
        firestore.collection("posts").orderBy("createdAT", descending: true);
    return ExploerpostCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            PostModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .where((post) => post.userID != userId)
        .toList());
  }

  // Stream for home posts
  Stream<List<PostModel>> getAllHomePosts() {
    final postCollection =
        firestore.collection("posts").orderBy("createdAT", descending: true);
    return postCollection.snapshots().map((snapshot) => snapshot.docs
        .map((post) =>
            PostModel.fromFirestore(post.data() as Map<String, dynamic>))
        .toList());
  }

  // Stream for posts of a specific user (profile posts)
  Stream<List<PostModel>> getUserPosts(String userId) {
    debugPrint("getUserPosts $userId");
    return firestore.collection('posts').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) =>
            PostModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .where((post) => post.userID == userId)
        .toList());
  }

  Future<String?> uploadUrlImage(File imageFile, String uid) async {
    try {
      return await storageService.uploadFile(
          file: imageFile, userId: uid, pathchild: "posts");
    } catch (e) {
      throw Exception("Failed to upload: ${e.toString()}");
    }
  }

  /// for likes 1
  Future likePost(String postId, String userId, bool islike) async {
    // id post
    DocumentReference postref = firestore.collection("posts").doc(postId);

    if (islike) {
      await postref.update({
        "Likes": FieldValue.arrayUnion([userId]),
        "totalLikes": FieldValue.increment(1)
      });
    } else {
      await postref.update({
        "Likes": FieldValue.arrayRemove([userId]),
        "totalLikes": FieldValue.increment(-1)
      });
    }
  }

  Future createComment(CommentModel comment) async {
    await firestore
        .collection("posts")
        .doc(comment.postId)
        .collection("comments")
        .doc(comment.commentId)
        .set(comment.toFirestore());

    DocumentReference postRef =
        firestore.collection("posts").doc(comment.postId);
    await postRef.update({
      "totalComments": FieldValue.increment(1),
      "comments": FieldValue.arrayUnion([comment.commentId])
    });
  }

  Stream<List<CommentModel>> getComments(String postId) {
    final commentCollection = firestore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .orderBy("createdAt", descending: true);

    return commentCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((comment) => CommentModel.fromFirestore(comment.data()))
        .toList());
  }

  Future deletePost(String postId) async {
    await firestore.collection("posts").doc(postId).delete();
  }
}
