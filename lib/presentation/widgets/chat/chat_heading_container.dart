import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/widgets/text.dart';
import 'package:synergy/domain/entity/user_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../dependency.dart';
import '../../cubits/chat/chat_cubit.dart';
import '../../cubits/users/users_cubit.dart';
import '../../screens/main_screens/chat/chatroom_screen.dart';

class ChatHeadingContainer extends StatelessWidget {
  final UserEntity e;
  const ChatHeadingContainer({Key? key, required this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
                friendName: e.fullname,
                friendUid: e.uid,
                friendUrl: e.url,
                myUrl: FirebaseAuth.instance.currentUser!.photoURL ?? '',
              ),
            ),
          ),
        );
      },
      title: CustomText(e.fullname),
      leading: ClipOval(
        child: Image.network(
          e.url,
          height: 32,
        ),
      ),
      subtitle: CustomText(
        timeago.format(
          DateTime.parse(e.lastLogin),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
