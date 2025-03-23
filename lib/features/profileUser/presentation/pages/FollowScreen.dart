import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/follow_cubit.dart'; // Path to your repository

class FollowListView extends StatelessWidget {

  const FollowListView({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<FollowCubit, FollowState>(
            builder: (context, state) {
              if (state is FollowLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is FollowLoaded) {
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profileUrl ?? ''),
                      ),
                      title: Text(user.username ?? 'Unknown User'),
                      subtitle: Text(user.email ?? ''),
                    );
                  },
                );
              }
              if (state is FollowError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return Center(child: Text("No following users found"));
            },
          ),
        ),

    );
  }
}
