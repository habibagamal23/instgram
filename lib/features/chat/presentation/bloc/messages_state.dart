part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}

final class MessagesLoading extends MessagesState {}

final class MessagesLoaded extends MessagesState {
  final List<MessageModel> messages;
  MessagesLoaded(this.messages);
}

final class MessagesError extends MessagesState {
  final String message;
  MessagesError(this.message);
}

final class SendMessageLoading extends MessagesState {}

final class SendMessageSuccess extends MessagesState {}

final class SendMessageFailure extends MessagesState {
  final String message;
  SendMessageFailure(this.message);
}
