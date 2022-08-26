import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/domain/usecase/login_with_facebook.dart';
import 'package:synergy/domain/usecase/login_with_google.dart';
import 'package:synergy/domain/usecase/signin.dart';
import 'package:synergy/domain/usecase/signup.dart';
import 'package:synergy/domain/usecase/user_state.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
    this._loginWithFaceboook,
    this._streamUserState,
    this._signin,
    this._signup,
    this._loginWithGoogle,
  ) : super(AuthenticationInitial());

  final LoginWithFaceboook _loginWithFaceboook;
  final LoginWithGoogle _loginWithGoogle;
  final StreamUserState _streamUserState;
  final Signin _signin;
  final Signup _signup;

  void userCheck() async {
    emit(Authenticating());
    final state = _streamUserState();
    state.listen((user) {
      user != null ? emit(Authenticated(user: user)) : emit(UnAuthenticated());
    });
  }

  void loginWithFb() async {
    emit(Authenticating());
    await _loginWithFaceboook();
  }

  void loginWithGoogle() async {
    emit(Authenticating());
    await _loginWithGoogle();
  }

  void signin(String email, String password) async {
    emit(Authenticating());
    await _signin(email, password);
  }

  void signup(UserEntity user) async {
    emit(Authenticating());
    await _signup(user);
  }
}
