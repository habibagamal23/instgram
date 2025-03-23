part of 'follow_cubit.dart';

@immutable
sealed class FollowState {}

final class FollowInitial extends FollowState {}
final class FollowLoading extends FollowState {}
final class FollowLoaded extends FollowState {
  final List<UserModel> users;
  FollowLoaded(this.users);
}
final class FollowError extends FollowState {
  final String message;
  FollowError(this.message);
}