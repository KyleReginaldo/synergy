import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synergy/firebase_options.dart';
import 'package:synergy/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:synergy/presentation/cubits/chat/chat_cubit.dart';
import 'package:synergy/presentation/cubits/comment/comment_cubit.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';

import 'presentation/screens/authentication/auth_manager.dart';
import 'dependency.dart';

void main() async {
  print('clone try');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Synergy',
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>(
            create: (context) => sl<AuthenticationCubit>()..userCheck(),
          ),
          BlocProvider<PostsCubit>(
            create: (context) => sl<PostsCubit>(),
          ),
          BlocProvider<UsersCubit>(
            create: (context) => sl<UsersCubit>(),
          ),
          BlocProvider<CommentCubit>(
            create: (context) => sl<CommentCubit>(),
          ),
          BlocProvider<ChatCubit>(
            create: (context) => sl<ChatCubit>(),
          ),
        ],
        child: const AuthManager(),
      ),
    );
  }
}
