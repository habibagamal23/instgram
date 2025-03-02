import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../register/data/models/UserModel.dart';
import '../../data/repositories/repostiryprofile.dart';
import '../manager/profile_cubit.dart';
import 'edit.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if(state is ProfileUpdated){
            BlocProvider.of<ProfileCubit>(context).fetchUserProfile();
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return ProfileView(user: state.user);
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No user found"));
        },
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final UserModel user;

  ProfileView({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Username
          Text(user.username ?? "No username",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

          Text(user.bio ?? "No bio",
              style: TextStyle(fontSize: 16, color: Colors.grey)),


          SizedBox(height: 20),
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


