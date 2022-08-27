// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:lottie/lottie.dart';
import 'package:synergy/presentation/cubits/chat/chat_cubit.dart';
import 'package:synergy/presentation/widgets/chat/current_user.dart';

class ChatRoomScreen extends StatefulWidget {
  final String friendUid;
  final String friendName;
  final String friendUrl;
  final String myUrl;
  const ChatRoomScreen(
      {Key? key,
      required this.friendUid,
      required this.friendName,
      required this.friendUrl,
      required this.myUrl})
      : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final chats = FirebaseFirestore.instance.collection('chats');
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  String chatDocId = '';
  final message = TextEditingController();
  void checkUser() async {
    await chats
        .where('users', isEqualTo: {
          widget.friendUid: null,
          currentUserId: null,
        })
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });
            } else {
              await chats.add({
                'users': {
                  currentUserId: null,
                  widget.friendUid: null,
                },
                'names': {
                  currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                  widget.friendUid: widget.friendName,
                }
              }).then((value) {
                chatDocId = value.id;
                print(value.id);
              });
            }
          },
        )
        .then((value) => context.read<ChatCubit>().fetchChats(chatDocId))
        .catchError((error) {
          print(error);
        });
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: CustomText(
          widget.friendName,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoaded) {
                    final chats = state.chats;
                    return ListView(
                      reverse: true,
                      children: chats
                          .map(
                            (e) => CurrentUser(e: e),
                          )
                          .toList(),
                    );
                  } else if (state is ChatEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/handlottie.json', height: 64),
                          const CustomText('Say hi.'),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomTextField(
                      'send message',
                      controller: message,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    context.read<ChatCubit>().sendMessage(
                          message.text,
                          chatDocId,
                          widget.friendUid,
                          widget.friendName,
                          widget.friendUrl,
                          widget.myUrl,
                        );
                    message.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
