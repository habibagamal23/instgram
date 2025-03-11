import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? postID;
  final String? username;
  final String? description;
  final String? imageURL;
  final Timestamp? createdAt;
  final String? profileUrl;
  final List<String>? likes;
  final List<String>? comments;
  final List<String>? sendShare;
  final num? totalLikes;
  final num? totalComments;
  final num? totalPosts;
  final String? userID;

  PostModel({
    this.postID,
    this.username,
    this.description,
    this.profileUrl,
    this.createdAt,
    this.imageURL,
    this.likes,
    this.comments,
    this.sendShare,
    this.totalLikes,
    this.totalComments,
    this.totalPosts,
    this.userID,
  });

  factory PostModel.fromFirestore(Map<String, dynamic> json) {
    return PostModel(
      postID: json['PostID'] as String?,
      username: json['username'] as String?,
      description: json['Description'] as String?,
      profileUrl: json['profileUrl'] as String?,
      createdAt: json['createdAT'] as Timestamp?,
      imageURL: json['ImageURL'] as String?,
      likes:
      (json['Likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      comments: (json['Comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sendShare: (json['SendShare'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      totalLikes: json['totalLikes'] as num?,
      totalComments: json['totalComments'] as num?,
      totalPosts: json['totalPosts'] as num?,
      userID: json['UserID'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'PostID': postID,
      'username': username,
      'Description': description,
      'profileUrl': profileUrl,
      'createdAT': createdAt,
      'ImageURL': imageURL,
      'Likes': likes,
      'Comments': comments,
      'SendShare': sendShare,
      'totalLikes': totalLikes,
      'totalComments': totalComments,
      'totalPosts': totalPosts,
      'UserID': userID,
    };
  }
}