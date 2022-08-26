import 'package:synergy/domain/entity/chat_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class FetchChats {
  final Repository repo;
  FetchChats({
    required this.repo,
  });
  Stream<List<ChatEntity>> call(String chatUid) {
    return repo.fetchChats(chatUid);
  }
}
