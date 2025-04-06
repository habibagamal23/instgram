part of 'rooms_cubit.dart';

@immutable
sealed class RoomsState {}

final class RoomsInitial extends RoomsState {}



class CreateRoomLoading extends RoomsState {}
class CreateRoomSuccess extends RoomsState {}
class CreateRoomFailure extends RoomsState {
  final String error;
  CreateRoomFailure(this.error);
}

class getRoomLoading extends RoomsState {}
class getRoomLoded extends RoomsState {
  final List<ChatRoomModel> chatRooms;
  getRoomLoded(this.chatRooms);
}
class getRoomError extends RoomsState {
  final String message;
  getRoomError(this.message);
}
