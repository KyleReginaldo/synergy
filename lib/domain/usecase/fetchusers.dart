import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class FetchUsers {
  final Repository repo;
  FetchUsers({
    required this.repo,
  });

  Stream<List<UserEntity>> call() {
    return repo.fetchUsers();
  }
}
