import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/domain/usecase/fetchuser.dart';
import 'package:synergy/domain/usecase/fetchusers.dart';
import 'package:synergy/domain/usecase/follow.dart';
import 'package:synergy/domain/usecase/searchusers.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(
    this._fetchUser,
    this._searchUsers,
    this._follow,
    this._fetchUsers,
  ) : super(UsersInitial());

  final FetchUser _fetchUser;
  final SearchUsers _searchUsers;
  final Follow _follow;
  final FetchUsers _fetchUsers;

  void fetchUsers() async {
    emit(UsersLoading());
    final usersStream = _fetchUsers();
    usersStream.listen((event) {
      if (event.isEmpty) {
        emit(UsersEmpty());
      } else {
        emit(SearchLoaded(users: event));
      }
    });
  }

  void fetchUser(String uid) async {
    emit(UsersLoading());
    final user = await _fetchUser(uid);
    emit(UsersLoaded(user: user));
  }

  void searchUsers(String query) async {
    emit(UsersLoading());
    final usersStream = _searchUsers(query);
    usersStream.listen((event) {
      Future.delayed(const Duration(seconds: 1), () {
        if (event.isEmpty) {
          emit(UsersEmpty());
        } else {
          emit(SearchLoaded(users: event));
        }
      });
    });
  }

  void follow({
    required String myId,
    required String uid,
  }) async {
    await _follow(
      myId,
      uid,
    ).then((value) => fetchUser(uid));
  }
}
