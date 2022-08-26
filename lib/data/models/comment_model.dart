// ignore_for_file: overridden_fields

import 'package:synergy/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  @override
  final String createdAt;
  @override
  final String fullname;
  @override
  final String url;
  @override
  final String body;
  @override
  String uid;
  CommentModel({
    required this.createdAt,
    required this.fullname,
    required this.url,
    required this.body,
    this.uid = "",
  }) : super(
          createdAt: createdAt,
          fullname: fullname,
          url: url,
          body: body,
        );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'fullname': fullname,
        'url': url,
        'body': body,
        'uid': uid,
      };

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      createdAt: json['createdAt'],
      fullname: json['fullname'],
      url: json['url'],
      body: json['body'],
      uid: json['uid'],
    );
  }
  factory CommentModel.fromEntity(CommentEntity comment) {
    return CommentModel(
      createdAt: comment.createdAt,
      fullname: comment.fullname,
      url: comment.url,
      body: comment.body,
      uid: comment.uid,
    );
  }
}
