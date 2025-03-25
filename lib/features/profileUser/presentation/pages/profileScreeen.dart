import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instaflutter/core/di/di.dart';
import 'package:instaflutter/core/firebase/firebase_auth_service.dart';
import 'package:instaflutter/features/register/presentation/pages/loginscreen.dart';

import '../../../post/presentation/manager/post_cubit.dart';
import '../../../register/data/models/UserModel.dart';
import '../../data/repositories/repostiryprofile.dart';
import '../manager/profile_cubit.dart';
import '../widgets/profileview.dart';
import 'edit.dart';
import '../../../../core/routes/constants_routes.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                await getIt<FirebaseAuthService>().signOut();
                context.go(ConstantsRoutes.registerScreen);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            debugPrint(
                "upateding user profileby user name ${state.user.username}");
            BlocProvider.of<ProfileCubit>(context).fetchUserProfile();
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            debugPrint("builder user profile");
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
