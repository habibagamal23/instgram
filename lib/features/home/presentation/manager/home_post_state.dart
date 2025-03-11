part of 'home_post_cubit.dart';

@immutable
sealed class HomePostState {}

final class HomePostInitial extends HomePostState {}

class HomePostLoading extends HomePostState {}

class HomePostLoaded extends HomePostState {
  final List<PostModel> posts;

  HomePostLoaded(this.posts);
}

class HomePostError extends HomePostState {
  final String error;

  HomePostError(this.error);
}