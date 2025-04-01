import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? messageId;
  final String? userId; // The sender
  final String? anotherUserId; // The receiver
  final String? text;
  final Timestamp? createdAt;
  final bool? isSeen;

  MessageModel({
    this.messageId,
    this.userId,
    this.anotherUserId,
    this.text,
    this.createdAt,
    this.isSeen,
  });

  /// Convert Firestore data to MessageModel
  factory MessageModel.fromFirestore(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'],
      userId: json['userId'],
      anotherUserId: json['anotherUserId'],
      text: json['text'],
      createdAt: json['createdAt'],
      isSeen: json['isSeen'] ?? false,
    );
  }

  /// Convert MessageModel to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'messageId': messageId,
      'userId': userId,
      'anotherUserId': anotherUserId,
      'text': text,
      'createdAt': createdAt ?? Timestamp.now(),
      'isSeen': isSeen ?? false,
    };
  }
}
