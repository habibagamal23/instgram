
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/profileUser/presentation/manager/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: profileCubit.username,
                decoration: InputDecoration(labelText: "username"),
              ),
              TextFormField(
                controller: profileCubit.bioController,
                decoration: InputDecoration(labelText: "Bio"),
              ),
              TextFormField(
                controller: profileCubit.websiteController,
                decoration: InputDecoration(labelText: "Website"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  profileCubit.updateUserProfile();
                  Navigator.pop(context); // Go back to profile screen after saving
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}