
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../manager/home_post_cubit.dart';


class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// or getIt<FirebaseAuthService>().currentUser!.uid;
    // Check if the current user has liked the post
    var currentUid = getIt<FirebaseAuthService>().currentUser!.uid;
    var islike= post.likes?.contains(currentUid)??false;

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
                  post.username ?? "Unknown User",
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
      onDoubleTap: (){
        context.read<PostCubit>().tabLikes(post.postID, !islike);

      }
            ,child: Image.network(
                  post.imageURL ?? "",
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),),
              Positioned(
                bottom: 10,
                left: 10,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                   islike? Icons.favorite:  Icons.favorite_border,
                        color: islike? Colors.red: Colors.black,
                      ),
                      onPressed: () {
                        context.read<PostCubit>().tabLikes(post.postID, !islike);
                      },
                    ),
                    Text(
                      "${post.totalLikes ?? 0} Likes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Text(
              post.description ?? "No description",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add a comment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Type your comment here...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Submit Comment"),
              ),
            ],
          ),
        );
      },
    );
  }
}