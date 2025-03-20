import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String? commentId;
  final String? postId;
  final String? userId;
  final String? comment;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createdAt;

  CommentModel({
    this.commentId,
    this.postId,
    this.userId,
    this.comment,
    this.username,
    this.userProfileUrl,
    this.createdAt,
  });

  // Convert from Firestore document to CommentModel
  factory CommentModel.fromFirestore(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] as String?,
      postId: json['postId'] as String?,
      userId: json['userId'] as String?,
      comment: json['comment'] as String?,
      username: json['username'] as String?,
      userProfileUrl: json['userProfileUrl'] as String?,
      createdAt: json['createdAt'] as Timestamp?,
    );
  }

  // Convert CommentModel to Firestore document format
  Map<String, dynamic> toFirestore() {
    return {
      'commentId': commentId,
      'postId': postId,
      'userId': userId,
      'comment': comment,
      'username': username,
      'userProfileUrl': userProfileUrl,
      'createdAt': createdAt,
    };
  }
}
