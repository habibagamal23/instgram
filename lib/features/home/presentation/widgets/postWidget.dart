import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/profileUser/presentation/manager/profile_cubit.dart';
import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/comments_cubit.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../manager/home_post_cubit.dart';
import 'commensList.dart';
import 'commentInput.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {


  @override
  Widget build(BuildContext context) {
    var currentUid = getIt<FirebaseAuthService>().currentUser!.uid;
    var islike = widget.post.likes?.contains(currentUid) ?? false;

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 10),
                Text(
                  widget.post.username ?? "Unknown User",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Image and like button
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              InkWell(
                onDoubleTap: () {
                  context.read<PostCubit>().tabLikes(widget.post.postID, !islike);
                },
                child: Image.network(
                  widget.post.imageURL ?? "",
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        islike ? Icons.favorite : Icons.favorite_border,
                        color: islike ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        context.read<PostCubit>().tabLikes(widget.post.postID, !islike);
                      },
                    ),
                    Text(
                      "${widget.post.totalLikes ?? 0} Likes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        _showBottomSheet(context, widget.post.postID!);
                      },
                    ),
                    Text(
                      "${widget.post.totalComments ?? 0} comments",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Text(
              widget.post.description ?? "No description",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String postid) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt<CommentsCubit>(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Comments",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Display list of comments
                Expanded(child: CommentListWidget(postId: postid)),
                // Input widget for creating new comment
                CommentInputWidget(postid: postid),
              ],
            ),
          ),
        );
      },
    );
  }

}




