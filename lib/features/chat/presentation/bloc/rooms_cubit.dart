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

  Future<String?> createRoom(String anotherUserUid) async {
    emit(CreateRoomLoading());
    try {
      final roomId = await chatRepo.createChatRoomIfNotExists(anotherUserUid);
      emit(CreateRoomSuccess());
      return roomId;
    } catch (e) {
      emit(CreateRoomFailure(e.toString()));
      return null;
    }
  }

  final currentUid = getIt<FirebaseAuthService>().currentUser!.uid;

  getAllChatRooms() {
    emit(ChatRoomLoading());
    streamSubscription =
        chatRepo.getAllChatRooms(currentUid).listen((rooms) async {
      List<ChatRoomModel> updatedRooms = [];

      for (var room in rooms) {
        final otherUserId = room.members!.firstWhere((id) => id != currentUid);
        final otherUserData = await chatRepo.getUserProfile(otherUserId);
        room.otherUserData = otherUserData;
        updatedRooms.add(room);
      }
      emit(ChatRoomLoaded(updatedRooms));
    }, onError: (error) {
      emit(ChatRoomError(error.toString()));
    });
  }
}
