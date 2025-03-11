import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../post/data/models/postmodel.dart';
import '../manager/home_post_cubit.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocConsumer<HomePostCubit, HomePostState>(
        listener: (context, state) {
          if (state is HomePostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is HomePostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomePostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                PostModel post = state.posts[index];
                return PostWidget(post: post);
              },
            );
          } else {
            return Center(child: Text('No Posts Available'));
          }
        },
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          // Post header with user info
          ListTile(
            title: Text(post.username ?? "Unknown User"),
          ),
          // Post image
          Image.network(post.imageURL ?? ""),
          // Post description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.description ?? "No description"),
          ),

        ],
      ),
    );
  }
}
