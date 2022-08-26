import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class SearchUsers {
  final Repository repo;
  SearchUsers({
    required this.repo,
  });

  Stream<List<UserEntity>> call(String query) {
    return repo.searchUsers(query);
  }
}
