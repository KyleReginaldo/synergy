// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/prime.dart';
import 'package:synergy/presentation/cubits/chat/chat_cubit.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:synergy/presentation/screens/main_screens/addpost_screen.dart';

import '../../dependency.dart';
import '../../presentation/screens/main_screens/chat/chat_screen.dart';
import '../../presentation/screens/main_screens/notification_screen.dart';
import '../../presentation/widgets/profile/profile_bottom_sheet.dart';

PreferredSizeWidget? buildAppbar(int index, BuildContext context) {
  switch (index) {
    case 0:
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/syncolor.png',
          height: 60,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                bool onRefresh = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<UsersCubit>(
                      create: (context) => sl<UsersCubit>(),
                      child: const AddPostScreen(),
                    ),
                  ),
                );
                if (onRefresh) {
                  context.read<PostsCubit>().fetchPosts();
                }
              },
              icon: const Iconify(Ic.outline_add_box)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              icon: const Icon(Icons.favorite_border)),
          IconButton(
            onPressed: () {
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
                            child: const ChatScreen(),
                          )));
            },
            icon: const Iconify(Prime.send),
          ),
        ],
      );
    case 2:
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/syncolor.png',
          height: 60,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Iconify(Ic.outline_add_box)),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const ProfileBottomSheet();
                },
              );
            },
            icon: const Iconify(Ic.baseline_menu),
          ),
        ],
      );
  }
  return null;
}
