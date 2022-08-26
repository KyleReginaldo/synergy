import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class GetPost {
  final Repository repo;
  GetPost({
    required this.repo,
  });

  Future<PostEntity> call(String uid) async {
    return await repo.getPost(uid);
  }
}
