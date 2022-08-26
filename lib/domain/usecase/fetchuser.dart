import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class FetchUser {
  final Repository repo;
  FetchUser({
    required this.repo,
  });

  Future<UserEntity> call(String uid) async {
    return await repo.fetchUser(uid);
  }
}
