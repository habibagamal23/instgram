part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}


class CreatePostSuccess extends PostState {}
class CreatePostLoading extends PostState {}
class CreatePostFailure extends PostState {
  final String errorMessage;
  CreatePostFailure(this.errorMessage);
}

class UploadImageforPost extends PostState {
  final File imageFile;
  UploadImageforPost(this.imageFile);
}



class PostsLoading extends PostState {}
class PostLoaded extends PostState {
  List<PostModel> posts;
  PostLoaded(this.posts);
}
class PostError extends PostState {
  final String errorMessage;
  PostError(this.errorMessage);
}