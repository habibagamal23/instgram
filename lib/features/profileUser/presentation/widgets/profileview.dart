import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../../../register/data/models/UserModel.dart';
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
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                post.imageURL ?? "", // Display the image of the post
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

class Profileviewbasics extends StatelessWidget {
  final UserModel user;

  const Profileviewbasics({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        user.totalPosts.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(width: 45),
                      Text(
                        user.totalFollowers.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(width: 70),
                      Text(
                        user.totalFollowing.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Text(
                        'posts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        'followers',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      SizedBox(width: 19),
                      Text(
                        'following',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username ?? "No Name",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                Text(
                  user.bio ?? "No Bio",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              );
            },
            child: Text("Edit Profile"),
          ),
        ],
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: TabBar(
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        tabs: [
          Icon(Icons.grid_view_rounded),
          Icon(Icons.video_collection),
          Icon(Icons.person)
        ],
      ),
    );
  }
}