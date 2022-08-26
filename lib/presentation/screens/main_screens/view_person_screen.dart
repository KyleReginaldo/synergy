import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:synergy/presentation/widgets/profile/profile_container.dart';
import 'package:synergy/presentation/widgets/view_person_tabbar.dart';

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
    print(followFilter(FirebaseAuth.instance.currentUser!.uid));
    super.initState();
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    context.read<UsersCubit>().follow(
                          myId: FirebaseAuth.instance.currentUser!.uid,
                          uid: widget.uid,
                        );
                  },
                  child: followFilter(FirebaseAuth.instance.currentUser!.uid)
                      ? const CustomText('unfollow')
                      : const CustomText('follow'),
                )
              ],
            ),
          ),
          ViewPersonTabbar(
            controller: _tabController,
            uid: widget.uid,
          )
        ],
      ),
    );
  }
}
