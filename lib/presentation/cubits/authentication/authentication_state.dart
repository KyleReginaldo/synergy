part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated({
    required this.user,
  });
}

class UnAuthenticated extends AuthenticationState {}

class Authenticating extends AuthenticationState {}
