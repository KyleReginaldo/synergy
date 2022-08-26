import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:synergy/presentation/screens/main_screens/edit_profile_screen.dart';
import 'package:synergy/presentation/widgets/profile/profile_container.dart';
import 'package:synergy/presentation/widgets/tabbar.dart';

import '../../../dependency.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const ProfileContainer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider<PostsCubit>(
                                create: (context) => sl<PostsCubit>()
                                  ..getPost(
                                      FirebaseAuth.instance.currentUser!.uid),
                                child: const EditProfileScreen(),
                              )));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4)),
                  child: const CustomText(
                    'Edit Profile',
                    weight: FontWeight.w500,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
        ),
        ProfileTabBar(controller: _tabController)
      ],
    );
  }
}
