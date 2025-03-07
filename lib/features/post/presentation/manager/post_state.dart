part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}


class CreatePostSuccess extends PostState {}

class CreatePostFailure extends PostState {
  final String errorMessage;
  CreatePostFailure(this.errorMessage);
}

class UploadImageforPost extends PostState {
  final File imageFile;
  UploadImageforPost(this.imageFile);
}



class PostsLoading extends PostState {}