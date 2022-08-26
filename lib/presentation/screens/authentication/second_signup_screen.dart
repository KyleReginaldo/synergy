import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/presentation/cubits/authentication/authentication_cubit.dart';

class SecondSignupScreen extends StatefulWidget {
  final String email;
  const SecondSignupScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<SecondSignupScreen> createState() => _SecondSignupScreenState();
}

class _SecondSignupScreenState extends State<SecondSignupScreen> {
  final fullname = TextEditingController();
  final password = TextEditingController();

  //
  bool rememberPass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            const CustomBtnText(
              'name and password',
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              'Full name',
              controller: fullname,
              radius: 4,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              'Password',
              controller: password,
              radius: 4,
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: rememberPass,
              onChanged: (value) {
                setState(() {
                  rememberPass = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              title: const CustomText(
                'Remember password',
                color: Colors.grey,
                size: 12,
              ),
            ),
            const SizedBox(height: 16),
            BtnFilled(
              onTap: () async {
                final user = UserEntity(
                  email: widget.email,
                  password: password.text,
                  createdAt: DateTime.now().toString(),
                  fullname: fullname.text,
                  posts: [],
                  followers: [],
                  following: [],
                  lastLogin: DateTime.now().toString(),
                );
                context.read<AuthenticationCubit>().signup(user);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              text: 'continue and sync contacts',
              width: MediaQuery.of(context).size.width,
              radius: 4,
              color: fullname.text.isEmpty || fullname.text.isEmpty
                  ? Colors.blue.shade200
                  : Colors.blue,
              text_color: fullname.text.isEmpty || fullname.text.isEmpty
                  ? Colors.white70
                  : Colors.white,
            ),
            const Spacer(
              flex: 9,
            ),
            CustomText(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              color: Colors.grey.shade600,
              size: 12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
