part of 'rooms_cubit.dart';

@immutable
sealed class RoomsState {}

final class RoomsInitial extends RoomsState {}



class CreateRoomLoading extends RoomsState {}
class CreateRoomSuccess extends RoomsState {
  CreateRoomSuccess();
}
class CreateRoomFailure extends RoomsState {
  final String error;
  CreateRoomFailure(this.error);
}

class ChatRoomLoading extends RoomsState {}
class ChatRoomLoaded extends RoomsState {
  final List<ChatRoomModel> chatRooms;
  ChatRoomLoaded(this.chatRooms);
}
class ChatRoomError extends RoomsState {
  final String message;
  ChatRoomError(this.message);
}
