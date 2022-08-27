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
    context.read<UsersCubit>().fetchUser(widget.uid);
    super.initState();
  }

  bool isFollowing = true;
  void followingFilter(uid) {
    final follow = widget.user.followers;
    if (follow.contains(uid)) {
      print(follow);
      setState(() {
        isFollowing = !isFollowing;
      });
    }
  }

  bool followFilter(String uid) => widget.user.followers.contains(uid);

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
                const ProfileContainer(),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        context.read<UsersCubit>().follow(
                              myId: FirebaseAuth.instance.currentUser!.uid,
                              uid: widget.uid,
                            );
                        followingFilter(FirebaseAuth.instance.currentUser!.uid);
                      },
                      child: Container(
                        width: 130,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: Center(
                          child: isFollowing
                              ? const CustomText('unfollow')
                              : const CustomText('follow'),
                        ),
                      ),
                    ),
                    GestureDetector(
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
                      child: Container(
                        width: 240,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: const Center(child: CustomText('Message')),
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
