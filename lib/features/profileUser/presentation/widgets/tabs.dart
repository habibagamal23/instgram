
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/core/di/di.dart';
import 'package:instaflutter/core/firebase/firebase_auth_service.dart';
import 'package:instaflutter/features/profileUser/presentation/widgets/profilebasic.dart';
import 'package:instaflutter/features/profileUser/presentation/widgets/tabs.dart';

import '../../../exploer/exploer/presentation/bloc/anothercubit/ontherprofile_cubit.dart';
import '../../../post/data/models/postmodel.dart';
import '../../../post/presentation/manager/post_cubit.dart';
import '../../../register/data/models/UserModel.dart';
import '../manager/follow_cubit.dart';
import '../pages/edit.dart';
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
