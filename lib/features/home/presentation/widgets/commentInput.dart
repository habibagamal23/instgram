import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/profileUser/presentation/manager/profile_cubit.dart';
import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/comments_cubit.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../manager/home_post_cubit.dart';
import 'package:flutter/material.dart';

class CommentInputWidget extends StatelessWidget {
  final String postid;

  const CommentInputWidget({
    Key? key,
    required this.postid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: context.read<CommentsCubit>().commentController,
            decoration: InputDecoration(
              hintText: "Add a comment...",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            final currentUser = context.read<ProfileCubit>().currentUser;
            if (currentUser != null) {
              BlocProvider.of<CommentsCubit>(context)
                  .createComment(postid, currentUser);

              context.read<CommentsCubit>().commentController.clear();
            }
          },
        )
      ],
    );
  }
}

