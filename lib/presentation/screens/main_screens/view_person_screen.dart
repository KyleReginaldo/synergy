import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:synergy/presentation/widgets/profile/profile_container.dart';
import 'package:synergy/presentation/widgets/view_person_tabbar.dart';

import '../../../dependency.dart';
import '../../cubits/chat/chat_cubit.dart';
import 'chat/chatroom_screen.dart';

class ViewPersonScreen extends StatefulWidget {
  final String uid;
  final UserEntity user;
  const ViewPersonScreen({Key? key, required this.uid, required this.user})
      : super(key: key);

  @override
  State<ViewPersonScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ViewPersonScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getData();
    super.initState();
  }

  bool isFollowing = false;
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      setState(() {
        isFollowing = userSnap
            .data()!['followers']
            .contains(FirebaseAuth.instance.currentUser!.uid);
      });
      print(
        userSnap
            .data()!['followers']
            .contains(FirebaseAuth.instance.currentUser!.uid),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ProfileContainer(
                  uid: widget.uid,
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isFollowing
                        ? BtnFilled(
                            onTap: () async {
                              context.read<UsersCubit>().follow(
                                    myId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    uid: widget.uid,
                                  );

                              setState(() {
                                isFollowing = false;
                              });
                            },
                            text: 'unfollow',
                            radius: 4,
                            color: Colors.black,
                          )
                        : BtnFilled(
                            onTap: () async {
                              context.read<UsersCubit>().follow(
                                    myId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    uid: widget.uid,
                                  );
                              setState(() {
                                isFollowing = true;
                              });
                            },
                            text: 'follow',
                            radius: 4,
                            color: Colors.black,
                          ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BtnFilled(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<UsersCubit>(
                                    create: (context) => sl<UsersCubit>(),
                                  ),
                                  BlocProvider<ChatCubit>(
                                    create: (context) => sl<ChatCubit>(),
                                  ),
                                ],
                                child: ChatRoomScreen(
                                  friendName: widget.user.fullname,
                                  friendUid: widget.user.uid,
                                ),
                              ),
                            ),
                          );
                        },
                        text: 'message',
                        radius: 4,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          ViewPersonTabbar(
            controller: _tabController,
            uid: widget.uid,
          )
        ],
      ),
    );
  }
}
