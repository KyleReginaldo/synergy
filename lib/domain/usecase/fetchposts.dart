import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class FetchPosts {
  final Repository repo;
  FetchPosts({
    required this.repo,
  });

  Stream<List<PostEntity>> call() {
    return repo.fetchPosts();
  }
}
