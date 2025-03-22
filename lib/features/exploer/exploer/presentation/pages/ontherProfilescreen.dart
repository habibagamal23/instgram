


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../../../profileUser/presentation/widgets/profileview.dart';
import '../bloc/ontherprofile_cubit.dart';

class Ontherprofilescreen extends StatelessWidget {
  const Ontherprofilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
        body: BlocBuilder<OntherprofileCubit, OntherprofileState>(
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

