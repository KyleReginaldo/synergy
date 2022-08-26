import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:synergy/presentation/widgets/chat/chat_heading_container.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
              child: CustomText(
                'Message',
                weight: FontWeight.w600,
              ),
            ),
            BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                if (state is SearchLoaded) {
                  return Column(
                    children: state.users.map((e) {
                      return e.uid != FirebaseAuth.instance.currentUser!.uid
                          ? ChatHeadingContainer(e: e)
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
