import 'package:synergy/domain/repository/repository.dart';

class SendMessage {
  final Repository repo;
  SendMessage({
    required this.repo,
  });

  Future<void> call(
    String msg,
    String chatUid,
    String userId,
    String friendName,
    String recieverUrl,
    String senderUrl,
  ) async {
    await repo.sendMessage(
      msg,
      chatUid,
      userId,
      friendName,
      recieverUrl,
      senderUrl,
    );
  }
}
