import 'package:synergy/domain/repository/repository.dart';

class LoginWithGoogle {
  final Repository repo;
  LoginWithGoogle({
    required this.repo,
  });

  Future<void> call() async {
    await repo.loginWithGoogle();
  }
}
