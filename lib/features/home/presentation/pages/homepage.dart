import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/chat/presentation/pages/roomscreen.dart';
import '../../../../core/di/di.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../manager/home_post_cubit.dart';
import '../widgets/postWidget.dart';
import '../../../post/presentation/manager/comments_cubit.dart'; // Import CommentsCubit

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Roomscreen()));
              },
              icon: Icon(Icons.message))
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<HomePostCubit>()..fetchHomePosts(),
        child: BlocConsumer<HomePostCubit, HomePostState>(
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
                  return PostWidget(
                      post:
                          post); // PostWidget should now be able to access CommentsCubit
                },
              );
            } else {
              return Center(child: Text('No Posts Available'));
            }
          },
        ),
      ),
    );
  }
}
