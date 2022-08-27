import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';

import '../../dependency.dart';
import '../cubits/posts/posts_cubit.dart';
import '../screens/main_screens/view_person_screen.dart';

class SearchLoadedContainer extends StatelessWidget {
  final List<UserEntity> users;
  const SearchLoadedContainer({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: users.map((e) {
        return e.uid == FirebaseAuth.instance.currentUser!.uid
            ? const SizedBox.shrink()
            : ListTile(
                onTap: () async {
                  print(e.fullname);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: sl<UsersCubit>()..fetchUser(e.uid),
                          ),
                          BlocProvider.value(
                            value: sl<PostsCubit>(),
                          ),
                        ],
                        child: ViewPersonScreen(
                          uid: e.uid,
                          user: e,
                        ),
                      ),
                    ),
                  );
                },
                title: CustomText(e.fullname),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(e.url),
                ),
                subtitle: CustomText(
                  'active ${timeago.format(DateTime.parse(e.lastLogin))}',
                  color: Colors.grey,
                ),
              );
      }).toList(),
    );
  }
}
