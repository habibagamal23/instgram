import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:instaflutter/features/register/data/models/UserModel.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../profileUser/presentation/manager/profile_cubit.dart';
import '../../data/models/postmodel.dart';
import '../../data/repositories/postrepo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {


  final PostRepositoryImplementation postRepository;

  PostCubit(this.postRepository) : super(PostInitial());

  TextEditingController descriptionController = TextEditingController();
  File? postImage;
  final formKey = GlobalKey<FormState>();

  Future<void> createPost(UserModel currentUser) async {
    try {

      if (!formKey.currentState!.validate()) {
        emit(CreatePostFailure("Please fill all required fields correctly."));
        return;
      }


// storage
      String? imageURL;
      if (postImage != null) {
        imageURL = await postRepository.uploadUrlImage(postImage!, currentUser.uid!);
      }

      //firestroe
      PostModel postModel = PostModel(
        username: currentUser.username,
        userID: currentUser.uid,
        postID: Uuid().v1(),
        description: descriptionController.text,
        profileUrl: currentUser.profileUrl,
        createdAt: DateTime.now().toString(),
        imageURL: imageURL,
        likes: [],
        comments: [],
        sendShare: [],
        totalLikes: 0,
        totalComments: 0,
        totalPosts: currentUser.totalPosts ?? 0,
      );

      await postRepository.createPost(postModel);

      emit(CreatePostSuccess());
    } catch (e) {
      emit(CreatePostFailure(e.toString()));
    }
  }

  void setImage(File imageFile) {
    postImage = imageFile;
    emit(UploadImageforPost(imageFile));
  }

}



