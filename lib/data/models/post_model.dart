// ignore_for_file: overridden_fields

import 'package:synergy/domain/entity/post_entity.dart';

class PostModel extends PostEntity {
  @override
  final String createdAt;
  @override
  final String description;
  @override
  final List likes;
  @override
  String postId;
  @override
  final String postUrl;
  @override
  final String profileImage;
  @override
  final String uid;
  @override
  final String username;
  PostModel({
    required this.createdAt,
    required this.description,
    required this.likes,
    this.postId = '',
    required this.postUrl,
    required this.profileImage,
    required this.uid,
    required this.username,
  }) : super(
          createdAt: createdAt,
          description: description,
          likes: likes,
          postId: postId,
          postUrl: postUrl,
          profileImage: profileImage,
          uid: uid,
          username: username,
        );
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      createdAt: json['createdAt'],
      description: json['description'],
      likes: json['likes'] ?? [],
      postId: json['postId'],
      postUrl: json['postUrl'],
      profileImage: json['profileImage'],
      uid: json['uid'],
      username: json['username'],
    );
  }
  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'description': description,
        'likes': likes,
        'postId': postId,
        'postUrl': postUrl,
        'profileImage': profileImage,
        'username': username,
      };
}
