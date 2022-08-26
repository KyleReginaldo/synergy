import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class FetchUserPosts {
  final Repository repo;
  FetchUserPosts({
    required this.repo,
  });

  Stream<List<PostEntity>> call(String uid) {
    return repo.fetchUserPosts(uid);
  }
}
