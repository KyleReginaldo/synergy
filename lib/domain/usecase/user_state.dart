import 'package:firebase_auth/firebase_auth.dart';
import 'package:synergy/domain/repository/repository.dart';

class StreamUserState {
  final Repository repo;
  StreamUserState({
    required this.repo,
  });

  Stream<User?> call() {
    return repo.userState();
  }
}
