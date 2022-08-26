import 'package:synergy/domain/entity/comment_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class FetchComments {
  final Repository repo;
  FetchComments({
    required this.repo,
  });

  Stream<List<CommentEntity>> call(String uid) {
    return repo.fetchComments(uid);
  }
}
