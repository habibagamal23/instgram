
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/profileUser/presentation/manager/profile_cubit.dart';
import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/comments_cubit.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../manager/home_post_cubit.dart';
import 'package:flutter/material.dart';

class CommentListWidget extends StatefulWidget {
  final String postId;

  const CommentListWidget({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CommentsCubit>(context).fetchComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CommentsLoaded) {
          if (state.comments.isEmpty) {
            return Center(child: Text("No comments found"));
          }

          return ListView.builder(
            itemCount: state.comments.length,
            itemBuilder: (context, index) {
              final comment = state.comments[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage:  NetworkImage(comment.userProfileUrl!),),

                title: Text(comment.username!),
                subtitle: Text(comment.comment!),
                trailing:   Text(comment.createdAt!.toDate().toString()),
              );
            },
          );
        }

        return Center(child: Text("Something went wrong"));
      },
    );
  }


}
