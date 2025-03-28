import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String? messageId;
  final String? lastMessage;
  List<String>? members;
  final String? useramanotherUser;
  final Timestamp? createdAt;
  final String? imageProfileAnotherUser;
  final num? totalUnReadMessages;

  ChatRoomModel({
    this.messageId,
    this.lastMessage,
    this.members,
    this.useramanotherUser,
    this.createdAt,
    this.imageProfileAnotherUser,
    this.totalUnReadMessages,
  });

  /// Convert from Firestore Map to ChatRoomModel
  factory ChatRoomModel.fromFirestore(Map<String, dynamic> json) {
    return ChatRoomModel(
      messageId: json['messageId'] as String?,
      lastMessage: json['lastMessage'] as String?,
      members: List<String>.from(json['members'] ?? []),
      useramanotherUser: json['useramanotherUser'] as String?,
      createdAt: json['createdAt'] as Timestamp?,
      imageProfileAnotherUser: json['imageProfileAnotherUser'] as String?,
      totalUnReadMessages: json['totalUnReadMessages'] ?? 0,
    );
  }

  /// Convert ChatRoomModel to Firestore Map
  Map<String, dynamic> toFirestore() {
    return {
      'messageId': messageId,
      'lastMessage': lastMessage,
      'members': members ?? [],
      'useramanotherUser': useramanotherUser,
      'createdAt': createdAt ?? Timestamp.now(),
      'imageProfileAnotherUser': imageProfileAnotherUser,
      'totalUnReadMessages': totalUnReadMessages ?? 0,
    };
  }
}
