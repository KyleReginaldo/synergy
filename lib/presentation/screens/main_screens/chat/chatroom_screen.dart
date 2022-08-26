// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:lottie/lottie.dart';
import 'package:synergy/presentation/cubits/chat/chat_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatRoomScreen extends StatefulWidget {
  final String friendUid;
  final String friendName;
  const ChatRoomScreen(
      {Key? key, required this.friendUid, required this.friendName})
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
        title: CustomText(widget.friendName),
        centerTitle: true,
        backgroundColor: Colors.black,
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
                            (e) => Align(
                                alignment: e.uid != currentUserId
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: e.uid != currentUserId
                                        ? const Color(0xFF40E0D0)
                                        : Colors.grey,
                                    borderRadius: e.uid != currentUserId
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          )
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: e.uid != currentUserId
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      CustomText(e.msg),
                                      CustomText(
                                        timeago.format(
                                          DateTime.parse(e.createdOn),
                                        ),
                                        size: 10,
                                      ),
                                    ],
                                  ),
                                )),
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
                  child: CustomTextField(
                    'send message',
                    controller: message,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    context.read<ChatCubit>().sendMessage(
                          message.text,
                          chatDocId,
                          widget.friendUid,
                          widget.friendName,
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
