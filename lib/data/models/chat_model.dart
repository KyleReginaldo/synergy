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
  ChatModel({
    required this.createdOn,
    required this.friendName,
    required this.msg,
    required this.uid,
  }) : super(
          createdOn: createdOn,
          friendName: friendName,
          msg: msg,
          uid: uid,
        );
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      createdOn: json['createdOn'],
      friendName: json['friendName'],
      msg: json['msg'],
      uid: json['uid'],
    );
  }
}
