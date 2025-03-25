import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:instaflutter/features/profileUser/presentation/manager/profile_cubit.dart';

import '../../../../profileUser/presentation/widgets/profileview.dart';
import '../bloc/anothercubit/ontherprofile_cubit.dart';

class anotherprofilescreen extends StatelessWidget {
  const anotherprofilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: BlocConsumer<OntherprofileCubit, OntherprofileState>(
        listener: (context, state) {
          if (state is OntherprofileLoaded) {
            BlocProvider.of<ProfileCubit>(context).fetchUserProfile();
          }
        },
        builder: (context, state) {
          if (state is OntherprofileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OntherprofileLoaded) {
            debugPrint("builder user profile${state.user.email}");
            return ProfileView(user: state.user);
          } else if (state is OntherprofileError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No user found"));
        },
      ),
    );
  }
}
