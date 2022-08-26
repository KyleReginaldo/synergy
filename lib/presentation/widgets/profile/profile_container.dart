import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:shimmer/shimmer.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  void initState() {
    context
        .read<UsersCubit>()
        .fetchUser(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (contex, state) {
        if (state is UsersLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundImage: NetworkImage(state.user.url),
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    state.user.fullname,
                    size: 16,
                    weight: FontWeight.w600,
                  )
                ],
              ),
              buildColumn(state.user.posts?.length.toString() ?? '0', 'Posts'),
              buildColumn(state.user.followers.length.toString(), 'Followers'),
              buildColumn(state.user.following.length.toString(), 'Following'),
            ],
          );
        } else if (state is UsersLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade300,
                    child: const CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      color: Colors.grey,
                      height: 16,
                      width: 110,
                    ),
                  ),
                ],
              ),
              buildColumn('0', 'Posts'),
              buildColumn('0', 'Followers'),
              buildColumn('0', 'Following'),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget buildColumn(String count, String label) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        CustomText(
          count,
          size: 20,
          weight: FontWeight.w600,
        ),
        CustomText(
          label,
          color: Colors.grey.shade700,
          weight: FontWeight.w400,
        ),
      ],
    ),
  );
}
