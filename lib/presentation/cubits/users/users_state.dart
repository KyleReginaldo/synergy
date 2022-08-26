part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class Home extends UsersState {}

class UsersLoaded extends UsersState {
  final UserEntity user;
  UsersLoaded({
    required this.user,
  });
}

class SearchLoaded extends UsersState {
  final List<UserEntity> users;
  SearchLoaded({
    required this.users,
  });
}

class UsersLoading extends UsersState {}

class UsersEmpty extends UsersState {}
