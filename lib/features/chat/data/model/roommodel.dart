import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../register/data/models/UserModel.dart';

class ChatRoomModel {
  final String? roomid;
  final String? lastMessage;
  final List<String>? members;
  Timestamp? createdAt;
  num? totalUnReadMessages;

  ChatRoomModel({
    this.roomid,
    this.lastMessage,
    this.members,
    this.createdAt,
    this.totalUnReadMessages,
  });
  UserModel? otherUserData;

  /// Convert to Firestore Map
  Map<String, dynamic> toFirestore() {
    return {
      'roomId': roomid,
      'lastMessage': lastMessage ?? '',
      'members': members ?? [],
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'totalUnReadMessages': totalUnReadMessages ?? 0,
    };
  }

  /// Create from Firestore Map
  factory ChatRoomModel.fromFirestore(Map<String, dynamic> data) {
    return ChatRoomModel(
      roomid: data['roomId'],
      lastMessage: data['lastMessage'],
      members: List<String>.from(data['members'] ?? []),
      createdAt: data['createdAt'],
      totalUnReadMessages: data['totalUnReadMessages'] ?? 0,
    );
  }
}
