import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/roommodel.dart';

class ChatRep {
  final FirebaseFirestore firestore;

  ChatRep({required this.firestore});

  Future<void> createChatRoomIfNotExists({
    required ChatRoomModel chatRoomModel,
  }) async {
    try {
      //  Sort members to ensure consistency (same room for same 2 users)
      final sortedMembers = List<String>.from(chatRoomModel.members!)
        ..sort((a, b) => a.compareTo(b));

      //  Check if room already exists
      final existingRoom = await firestore
          .collection('rooms')
          .where('members', isEqualTo: sortedMembers)
          .get();

      //  If exists: do nothing
      if (existingRoom.docs.isNotEmpty) {
        return;
      }

      //  If not exists: create new room

      await firestore
          .collection("rooms")
          .doc(chatRoomModel.messageId)
          .set(chatRoomModel.toFirestore());
    } catch (e) {
      print(' Error creating chat room: $e');
    }
  }

  Stream<List<ChatRoomModel>> getAllChatRooms(String currentUid) {
    final chatRoomCollection = firestore
        .collection("rooms")
        .where("members", arrayContains: currentUid)
        .orderBy("createdAt", descending: true);

    return chatRoomCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            ChatRoomModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
