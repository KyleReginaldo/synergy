import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class Signup {
  final Repository repo;
  Signup({
    required this.repo,
  });

  Future<void> call(UserEntity user) async {
    await repo.signup(user);
  }
}
