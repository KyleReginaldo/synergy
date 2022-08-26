import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:synergy/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:synergy/presentation/screens/authentication/first_signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/syn.png',
                height: 80,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                'Email',
                controller: email,
                radius: 4,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                'Password',
                controller: password,
                radius: 4,
              ),
              const SizedBox(height: 32),
              BtnFilled(
                onTap: () async {
                  context
                      .read<AuthenticationCubit>()
                      .signin(email.text, password.text);
                },
                text: 'Log In',
                radius: 4,
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      context.read<AuthenticationCubit>().loginWithFb();
                    },
                    icon: const Iconify(Logos.facebook),
                  ),
                  IconButton(
                    onPressed: () async {
                      context.read<AuthenticationCubit>().loginWithGoogle();
                    },
                    icon: const Iconify(Logos.google_icon),
                  ),
                ],
              ),
              const Divider(color: Colors.black),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    'Don\'t have an account? ',
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FirstSignupScreen(),
                        ),
                      );
                    },
                    child: const CustomText(
                      'Sign Up.',
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CustomText(
                'Synergy from K\'s Project',
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }
}
