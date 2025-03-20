part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}
final class CommentsLoaded extends CommentsState {
  final List<CommentModel> comments;
  CommentsLoaded(this.comments);
}
final class CommentsError extends CommentsState {
  final String errorMessage;
  CommentsError(this.errorMessage);
}

final class CreateCommentLoading extends CommentsState {}
final class CreateCommentSuccess extends CommentsState {}
final class CreateCommentFailure extends CommentsState {
  final String errorMessage;
  CreateCommentFailure(this.errorMessage);
}