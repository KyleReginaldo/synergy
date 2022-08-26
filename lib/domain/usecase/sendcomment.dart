import 'package:synergy/domain/entity/comment_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class SendComment {
  final Repository repo;
  SendComment({
    required this.repo,
  });

  Future<void> call(CommentEntity comment, String uid) async {
    await repo.sendComment(comment, uid);
  }
}
