import 'package:synergy/domain/repository/repository.dart';

class LoginWithFaceboook {
  final Repository repo;
  LoginWithFaceboook({
    required this.repo,
  });

  Future<void> call() async {
    await repo.loginWithFaceBook();
  }
}
