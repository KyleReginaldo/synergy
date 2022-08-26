import 'package:synergy/domain/repository/repository.dart';

class Signin {
  final Repository repo;
  Signin({
    required this.repo,
  });

  Future<void> call(String email, String password) async {
    await repo.signin(email, password);
  }
}
