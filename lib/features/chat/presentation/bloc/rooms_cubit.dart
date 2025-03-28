import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../data/model/roommodel.dart';
import '../../data/repository/chatRepo.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final ChatRep chatRepo;

  RoomsCubit(this.chatRepo) : super(RoomsInitial());

  StreamSubscription<List<ChatRoomModel>>? streamSubscription;

  final crunnetid = getIt<FirebaseAuthService>().currentUser!.uid;
  Future<void> createRoom(
      anotherUserId, username, imageProfileAnotherUser) async {
    emit(CreateRoomLoading());
    try {
      ChatRoomModel chatRoom = ChatRoomModel(
        messageId: Uuid().v1(),
        lastMessage: "",
        members: [crunnetid, anotherUserId],
        useramanotherUser: username,
        createdAt: Timestamp.now(),
        imageProfileAnotherUser: imageProfileAnotherUser,
        totalUnReadMessages: 0,
      );
      await chatRepo.createChatRoomIfNotExists(chatRoomModel: chatRoom);

      emit(CreateRoomSuccess());
    } catch (e) {
      emit(CreateRoomFailure(e.toString()));
    }
  }

  getAllChatRooms() {
    emit(ChatRoomLoading());
    streamSubscription = chatRepo.getAllChatRooms(crunnetid).listen((rooms) {
      emit(ChatRoomLoaded(rooms));
    }, onError: (error) {
      emit(ChatRoomError(error.toString()));
    });
  }
}
