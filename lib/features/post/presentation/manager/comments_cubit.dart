import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../register/data/models/UserModel.dart';
import '../../data/models/commetmodel.dart';
import '../../data/repositories/postrepo.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final PostRepositoryImplementation commentRepository;

  CommentsCubit(this.commentRepository) : super(CommentsInitial());
  TextEditingController commentController = TextEditingController();

  StreamSubscription<List<CommentModel>>? commentSubscription;

  Future<void> createComment(String postId, UserModel currentUser) async {
    emit(CreateCommentLoading());
    try {
      if (commentController.text.isEmpty) {
        emit(
            CreateCommentFailure("Please fill all required fields correctly."));
        return;
      }

      CommentModel comment = CommentModel(
        commentId: Uuid().v4(),
        postId: postId,
        userId: currentUser.uid,
        comment: commentController.text,
        username: currentUser.username,
        userProfileUrl: currentUser.profileUrl,
        createdAt: Timestamp.now(),
      );
      await commentRepository.createComment(comment);
      fetchComments(postId);
      emit(CreateCommentSuccess());
    } catch (e) {
      emit(CreateCommentFailure("Error creating comment: ${e.toString()}"));
    }
  }

  void fetchComments(String postId) {
    emit(CommentsLoading());

    commentSubscription = commentRepository.getComments(postId).listen((listComments){
      emit(CommentsLoaded(listComments));
    }, onError: (error) {
      emit(CommentsError(error.toString()));

    });
  }
  }

