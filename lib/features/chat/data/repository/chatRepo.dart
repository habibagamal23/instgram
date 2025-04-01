import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaflutter/core/firebase/firebase_auth_service.dart';
import 'package:instaflutter/features/chat/data/model/message.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/di/di.dart';
import '../../../register/data/models/UserModel.dart';
import '../model/roommodel.dart';

class ChatRep {
  final FirebaseFirestore firestore;

  ChatRep({required this.firestore});

  Future<String> createChatRoomIfNotExists(String antheruseruid) async {
    try {
      //  Sort members to ensure consistency (same room for same 2 users)
      final currentuserId = getIt<FirebaseAuthService>().currentUser!.uid;
      final sortedMembers = [currentuserId, antheruseruid]
        ..sort((a, b) => a.compareTo(b));

      //  Check if room already exists
      final existingRoom = await firestore
          .collection('rooms')
          .where('members', isEqualTo: sortedMembers)
          .get();

      //  If exists: do nothing
      if (existingRoom.docs.isNotEmpty) {
        return existingRoom.docs.first.id;
      }

      //  If not exists: create new room

      ChatRoomModel chatRoom = ChatRoomModel(
        roomid: Uuid().v1(),
        lastMessage: "",
        members: sortedMembers,
        createdAt: Timestamp.now(),
        totalUnReadMessages: 0,
      );

      await firestore
          .collection("rooms")
          .doc(chatRoom.roomid)
          .set(chatRoom.toFirestore());
      return chatRoom.roomid!;
    } catch (e) {
      throw Exception("Error creating chat room: $e");
    }
  }

  Stream<List<ChatRoomModel>> getAllChatRooms(String currentUid) {
    final chatRoomCollection =
        firestore.collection("rooms").orderBy("createdAt", descending: true);

    return chatRoomCollection.snapshots().map((snapshot) {
      final allRooms = snapshot.docs
          .map((doc) =>
              ChatRoomModel.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();

      return allRooms
          .where((room) => room.members!.contains(currentUid))
          .toList();
    });
  }

  Future<void> sendMessage({
    required String roomId,
    required MessageModel message,
  }) async {
    try {
      final messageDoc = firestore
          .collection("rooms")
          .doc(roomId)
          .collection("messages")
          .doc(message.messageId)
          .set(message.toFirestore());

      // Update last message + time in the room doc
      await firestore.collection("rooms").doc(roomId).update({
        'lastMessage': message.text,
        'createdAt': Timestamp.now(),
        'totalUnReadMessages': FieldValue.increment(1),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Stream<List<MessageModel>> getMessagesForRoom(String roomId) {
    final messageCollection = firestore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .orderBy("createdAt", descending: true);

    return messageCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            MessageModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList());
  }

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
}
