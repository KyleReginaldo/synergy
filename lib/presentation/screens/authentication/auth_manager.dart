import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synergy/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:synergy/presentation/screens/main_screens/main_screen.dart';
import 'package:synergy/presentation/screens/authentication/login_screen.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const MainScreen();
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}
