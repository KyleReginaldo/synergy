import 'package:synergy/domain/repository/repository.dart';

class Follow {
  final Repository repo;
  Follow({
    required this.repo,
  });

  Future<void> call(String myId, String uid) async {
    await repo.follow(
      myId,
      uid,
    );
  }
}
