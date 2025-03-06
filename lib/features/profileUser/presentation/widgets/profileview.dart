import 'package:flutter/material.dart';

import '../../../register/data/models/UserModel.dart';
import '../pages/edit.dart';

class ProfileView extends StatelessWidget {
  final UserModel user;

  const ProfileView({super.key, required this.user});

  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Profileviewbasics(user: user),
              ),
            ],
          )),
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
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: SizedBox(
                        width: 80,
                        height: 72,
                        child: Image.network(
                          user.profileUrl ?? "No Image",
                        )),
                  )),
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
                            fontWeight: FontWeight.bold,),
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
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),

                Text(
                  user.bio ?? "No Bio",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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
          Tabs()

        ],
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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
            ]));
  }
}
