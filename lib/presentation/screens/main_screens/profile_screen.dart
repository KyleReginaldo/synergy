import 'package:flutter/material.dart';
import 'package:general/general.dart';

import '../../widgets/profile/edit_profile.dart';
import '../../widgets/tabbar.dart';
import '../../widgets/profile/profile_container.dart';

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
              const SizedBox(height: 32),
              Column(
                children: [
                  BtnFilled(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    text: 'edit profile',
                    color: Colors.black,
                    radius: 4,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ],
          ),
        ),
        ProfileTabBar(controller: _tabController)
      ],
    );
  }
}
