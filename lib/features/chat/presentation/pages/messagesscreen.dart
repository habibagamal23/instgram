import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/register/data/models/UserModel.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/di/di.dart';
import '../../../../core/firebase/firebase_auth_service.dart';
import '../../data/model/message.dart';
import '../bloc/messages_cubit.dart';

class MessagesScreen extends StatefulWidget {
  final String roomId;
  final String anotherUserId;
  final String Username;
  const MessagesScreen(
      {super.key,
      required this.roomId,
      required this.anotherUserId,
      required this.Username});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final currentUid = getIt<FirebaseAuthService>().currentUser!.uid;

  @override
  void initState() {
    super.initState();
    context.read<MessagesCubit>().listenToMessages(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Username ?? ''),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MessagesError) {
                  return Center(child: Text(state.message));
                } else if (state is MessagesLoaded) {
                  final messages = state.messages;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.userId == currentUid;

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                isMe ? Colors.blueAccent : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message.text ?? '',
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text("Start chatting"));
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        context.read<MessagesCubit>().textEditingController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    context.read<MessagesCubit>().sendMessage(
                        roomId: widget.roomId,
                        anotherUserId: widget.anotherUserId);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
