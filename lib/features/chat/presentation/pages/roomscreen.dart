import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/core/di/di.dart';
import 'package:instaflutter/features/chat/presentation/bloc/rooms_cubit.dart';

import '../../../../core/firebase/firebase_auth_service.dart';

class Roomscreen extends StatefulWidget {
  const Roomscreen({super.key});

  @override
  State<Roomscreen> createState() => _RoomscreenState();
}

class _RoomscreenState extends State<Roomscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<RoomsCubit>(context).getAllChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats")),
      body: BlocBuilder<RoomsCubit, RoomsState>(builder: (context, state) {
        if (state is ChatRoomError) {
          return Center(child: Text(state.message));
        }
        if (state is ChatRoomLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ChatRoomLoaded) {
          final rooms = state.chatRooms;
          if (rooms.isEmpty) {
            return Center(child: Text("No chats yet."));
          }
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return ListTile(
                title: Text(room.useramanotherUser??''),
                subtitle: Text(room.lastMessage ?? ''),
                leading: CircleAvatar(
                  radius: 30,
                ),
                onTap: () {
                  // Navigate to chat detail screen
                },
              );
            },
          );
        }
        return Center(child: Text("Something went wrong"));
      }),
    );
  }
}
