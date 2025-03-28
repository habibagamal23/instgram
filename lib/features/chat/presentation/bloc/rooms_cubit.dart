import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaflutter/features/register/data/models/UserModel.dart';
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

  Future<void> createRoom(UserModel currentuser, UserModel antheruser) async {
    emit(CreateRoomLoading());
    try {
      ChatRoomModel chatRoom = ChatRoomModel(
        messageId: Uuid().v1(),
        username: currentuser.username,
        lastMessage: "",
        members: [currentuser.uid!, antheruser.uid!],
        useramanotherUser: antheruser.username,
        createdAt: Timestamp.now(),
        imageProfileAnotherUser: antheruser.profileUrl,
        imageProfileUser: currentuser.profileUrl,
        totalUnReadMessages: 0,
      );
      await chatRepo.createChatRoomIfNotExists(chatRoomModel: chatRoom);

      emit(CreateRoomSuccess());
    } catch (e) {
      emit(CreateRoomFailure(e.toString()));
    }
  }

  final crunnetid = getIt<FirebaseAuthService>().currentUser!.uid;

  getAllChatRooms() {
    emit(ChatRoomLoading());
    streamSubscription = chatRepo.getAllChatRooms(crunnetid).listen((rooms) {
      emit(ChatRoomLoaded(rooms));
    }, onError: (error) {
      emit(ChatRoomError(error.toString()));
    });
  }
}
