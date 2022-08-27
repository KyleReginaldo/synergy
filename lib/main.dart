import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:synergy/core/theme/text_theme.dart';
import 'package:synergy/firebase_options.dart';
import 'package:synergy/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:synergy/presentation/cubits/chat/chat_cubit.dart';
import 'package:synergy/presentation/cubits/comment/comment_cubit.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:synergy/core/theme/theme_provider.dart';

import 'presentation/screens/authentication/auth_manager.dart';
import 'dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return MaterialApp(
        title: 'Synergy',
        theme: ThemeData(
          textTheme: ubuntuTextTheme,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: provider.themeMode,
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
    });
  }
}
