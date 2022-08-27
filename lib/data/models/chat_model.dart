import 'package:synergy/domain/entity/chat_entity.dart';

class ChatModel extends ChatEntity {
  @override
  final String createdOn;
  @override
  final String friendName;
  @override
  final String msg;
  @override
  final String uid;
  @override
  final String recieverUrl;
  @override
  final String senderUrl;
  ChatModel({
    required this.createdOn,
    required this.friendName,
    required this.msg,
    required this.uid,
    required this.recieverUrl,
    required this.senderUrl,
  }) : super(
          createdOn: createdOn,
          friendName: friendName,
          msg: msg,
          uid: uid,
          recieverUrl: recieverUrl,
          senderUrl: senderUrl,
        );
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      createdOn: json['createdOn'],
      friendName: json['friendName'],
      msg: json['msg'],
      uid: json['uid'],
      recieverUrl: json['recieverUrl'],
      senderUrl: json['senderUrl'],
    );
  }
}
