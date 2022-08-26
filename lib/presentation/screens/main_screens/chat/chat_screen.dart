import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/presentation/cubits/chat/chat_cubit.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:synergy/presentation/screens/main_screens/chat/chatroom_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../dependency.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final name = TextEditingController();
  @override
  void initState() {
    context.read<UsersCubit>().fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    'search name',
                    controller: name,
                    onChanged: (value) {
                      context.read<UsersCubit>().searchUsers(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<UsersCubit>().searchUsers(name.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                if (state is SearchLoaded) {
                  return Column(
                    children: state.users.map((e) {
                      return e.uid != FirebaseAuth.instance.currentUser!.uid
                          ? ListTile(
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
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                            )
                          : const SizedBox.shrink();
                    }).toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
