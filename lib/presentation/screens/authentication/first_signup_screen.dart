import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/system_uicons.dart';
import 'package:synergy/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:synergy/presentation/screens/authentication/second_signup_screen.dart';

import '../../../dependency.dart';

class FirstSignupScreen extends StatefulWidget {
  const FirstSignupScreen({Key? key}) : super(key: key);

  @override
  State<FirstSignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<FirstSignupScreen> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CustomTextField(
              'Email address',
              controller: emailController,
              radius: 4,
              suffix: emailController.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () async {
                        emailController.clear();
                      },
                      icon: const Iconify(
                        SystemUicons.cross,
                        color: Colors.black,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            BtnFilled(
              onTap: () {
                if (emailController.text.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<AuthenticationCubit>(
                        create: (context) => sl<AuthenticationCubit>(),
                        child: SecondSignupScreen(
                          email: emailController.text,
                        ),
                      ),
                    ),
                  );
                }
              },
              text: 'next',
              width: MediaQuery.of(context).size.width,
              radius: 4,
              color: emailController.text.isEmpty
                  ? Colors.blue.shade200
                  : Colors.blue,
              text_color:
                  emailController.text.isEmpty ? Colors.white70 : Colors.white,
            ),
            const Spacer(),
            const Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  'Already have an account? ',
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CustomText(
                    'Log In',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
