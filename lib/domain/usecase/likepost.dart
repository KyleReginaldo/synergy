import 'package:synergy/domain/repository/repository.dart';

class LikePost {
  final Repository repo;
  LikePost({
    required this.repo,
  });

  Future<String> call(String postId, String uid, List likes) async {
    return await repo.likePost(postId, uid, likes);
  }
}
