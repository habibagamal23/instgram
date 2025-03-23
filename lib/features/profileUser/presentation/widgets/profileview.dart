import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/core/di/di.dart';
import 'package:instaflutter/core/firebase/firebase_auth_service.dart';
import 'package:instaflutter/features/profileUser/presentation/widgets/profilebasic.dart';
import 'package:instaflutter/features/profileUser/presentation/widgets/tabs.dart';

import '../../../exploer/exploer/presentation/bloc/ontherprofile_cubit.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../../../register/data/models/UserModel.dart';
import '../manager/follow_cubit.dart';
import '../pages/edit.dart';

class ProfileView extends StatefulWidget {
  final UserModel user;

  const ProfileView({super.key, required this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().startListeningToPosts(widget.user.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Profileviewbasics(user: widget.user),
            ),
            SliverToBoxAdapter(
              child: Tabs(),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  // Tab for Posts
                  BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      if (state is PostsLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PostLoaded) {
                        return GridView.builder(
                          itemCount: state.posts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemBuilder: (context, index) {
                            PostModel post = state.posts[index];
                            return GestureDetector(
                              onTap: () {
                                // Handle post tap (e.g., navigate to post details)
                              },
                              child: Image.network(
                                post.imageURL ??
                                    "", // Display the image of the post
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text("No posts found"));
                      }
                    },
                  ),

                  // Tab for following/followers or other details (can be customized)
                  Center(child: Text('Other Info')),
                  Center(child: Text('Other Info')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


