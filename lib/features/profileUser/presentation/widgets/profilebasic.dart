import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/core/di/di.dart';
import 'package:instaflutter/core/firebase/firebase_auth_service.dart';

import '../../../exploer/exploer/presentation/bloc/ontherprofile_cubit.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../../../register/data/models/UserModel.dart';
import '../manager/follow_cubit.dart';
import '../pages/edit.dart';

class Profileviewbasics extends StatefulWidget {
  final UserModel user;

  const Profileviewbasics({super.key, required this.user});

  @override
  _ProfileviewbasicsState createState() => _ProfileviewbasicsState();
}

class _ProfileviewbasicsState extends State<Profileviewbasics> {




  @override
  Widget build(BuildContext context) {

    String currentUid = getIt<FirebaseAuthService>().currentUser!.uid;
    bool isFollowing= widget.user.followers?.contains(currentUid) ?? false;
    var user=widget.user;
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
                      TextButton(
                          onPressed: () {
                            context
                                .read<FollowCubit>()
                                .followUsers(user.followers!);
                          },
                          child: Text(
                            'followers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          )),
                      SizedBox(width: 19),
                      TextButton(
                          onPressed: () {
                            context
                                .read<FollowCubit>()
                                .followUsers(user.following!);
                          },
                          child: Text(
                            'following',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ))
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
          user.uid == currentUid
              ? ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              );
            },
            child: Text("Edit Profile"),
          )
              : ElevatedButton(
            onPressed: () {
              context
                  .read<OntherprofileCubit>()
                  .FollowAndUnfollow(user.uid!, !isFollowing);
            },
            child: Text(isFollowing ? "Following" : "Follow"),
          )
        ],
      ),
    );
  }
}
