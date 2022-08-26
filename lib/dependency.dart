import 'package:get_it/get_it.dart';
import 'package:synergy/data/datasource/remote_data_source.dart';
import 'package:synergy/data/repository/repository_impl.dart';
import 'package:synergy/domain/repository/repository.dart';
import 'package:synergy/domain/usecase/fetchchats.dart';
import 'package:synergy/domain/usecase/fetchcomments.dart';
import 'package:synergy/domain/usecase/fetchposts.dart';
import 'package:synergy/domain/usecase/fetchuser.dart';
import 'package:synergy/domain/usecase/fetchuserposts.dart';
import 'package:synergy/domain/usecase/fetchusers.dart';
import 'package:synergy/domain/usecase/follow.dart';
import 'package:synergy/domain/usecase/getpost.dart';
import 'package:synergy/domain/usecase/likepost.dart';
import 'package:synergy/domain/usecase/login_with_facebook.dart';
import 'package:synergy/domain/usecase/login_with_google.dart';
import 'package:synergy/domain/usecase/searchusers.dart';
import 'package:synergy/domain/usecase/sendcomment.dart';
import 'package:synergy/domain/usecase/sendmessage.dart';
import 'package:synergy/domain/usecase/signin.dart';
import 'package:synergy/domain/usecase/signup.dart';
import 'package:synergy/domain/usecase/user_state.dart';
import 'package:synergy/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:synergy/presentation/cubits/chat/chat_cubit.dart';
import 'package:synergy/presentation/cubits/comment/comment_cubit.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';

final sl = GetIt.instance;

Future init() async {
  //*state management
  sl.registerFactory(() => AuthenticationCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => PostsCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => UsersCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => CommentCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ChatCubit(sl(), sl()));

  //*usecases
  sl.registerLazySingleton(() => LoginWithFaceboook(repo: sl()));
  sl.registerLazySingleton(() => LoginWithGoogle(repo: sl()));
  sl.registerLazySingleton(() => StreamUserState(repo: sl()));
  sl.registerLazySingleton(() => Signin(repo: sl()));
  sl.registerLazySingleton(() => Signup(repo: sl()));
  sl.registerLazySingleton(() => FetchPosts(repo: sl()));
  sl.registerLazySingleton(() => FetchUser(repo: sl()));
  sl.registerLazySingleton(() => SearchUsers(repo: sl()));
  sl.registerLazySingleton(() => LikePost(repo: sl()));
  sl.registerLazySingleton(() => GetPost(repo: sl()));
  sl.registerLazySingleton(() => SendComment(repo: sl()));
  sl.registerLazySingleton(() => FetchComments(repo: sl()));
  sl.registerLazySingleton(() => FetchUserPosts(repo: sl()));
  sl.registerLazySingleton(() => Follow(repo: sl()));
  sl.registerLazySingleton(() => SendMessage(repo: sl()));
  sl.registerLazySingleton(() => FetchChats(repo: sl()));
  sl.registerLazySingleton(() => FetchUsers(repo: sl()));

  //*Firebase Repository
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(remote: sl()));

  //*Data Source
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
}
