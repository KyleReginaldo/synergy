class ChatEntity {
  final String createdOn;
  final String friendName;
  final String msg;
  final String uid;

  final String recieverUrl;
  final String senderUrl;
  ChatEntity({
    required this.createdOn,
    required this.friendName,
    required this.msg,
    required this.uid,
    required this.recieverUrl,
    required this.senderUrl,
  });
}
