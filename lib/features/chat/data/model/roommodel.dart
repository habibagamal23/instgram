import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String? messageId;
  final String? lastMessage;
  final List<String>? members;
  final String? username;
  final String? imageProfileUser;
  final String? useramanotherUser;
  final Timestamp? createdAt;
  final String? imageProfileAnotherUser;
  final num? totalUnReadMessages;

  ChatRoomModel({
    this.messageId,
    this.lastMessage,
    this.members,
    this.username,
    this.imageProfileUser,
    this.useramanotherUser,
    this.createdAt,
    this.imageProfileAnotherUser,
    this.totalUnReadMessages,
  });

  /// Convert to Firestore Map
  Map<String, dynamic> toFirestore() {
    return {
      'messageId': messageId,
      'lastMessage': lastMessage ?? '',
      'members': members ?? [],
      'username': username ?? '',
      'imageProfileUser': imageProfileUser ?? '',
      'useramanotherUser': useramanotherUser ?? '',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'imageProfileAnotherUser': imageProfileAnotherUser ?? '',
      'totalUnReadMessages': totalUnReadMessages ?? 0,
    };
  }

  /// Create from Firestore Map
  factory ChatRoomModel.fromFirestore(Map<String, dynamic> data) {
    return ChatRoomModel(
      messageId: data['messageId'],
      lastMessage: data['lastMessage'],
      members: List<String>.from(data['members'] ?? []),
      username: data['username'],
      imageProfileUser: data['imageProfileUser'],
      useramanotherUser: data['useramanotherUser'],
      createdAt: data['createdAt'],
      imageProfileAnotherUser: data['imageProfileAnotherUser'],
      totalUnReadMessages: data['totalUnReadMessages'] ?? 0,
    );
  }
}
