// ignore_for_file: overridden_fields

import 'package:synergy/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  @override
  String uid;
  @override
  final String email;
  @override
  final String password;
  @override
  final String createdAt;
  @override
  String url;
  @override
  final String fullname;
  @override
  final String username;
  @override
  List? posts;
  @override
  String lastLogin;
  @override
  final List following;
  @override
  final List followers;
  @override
  UserModel({
    this.uid = '',
    required this.email,
    required this.password,
    required this.createdAt,
    this.url = '',
    required this.fullname,
    this.username = '',
    this.posts,
    this.lastLogin = '',
    required this.following,
    required this.followers,
  }) : super(
          uid: uid,
          email: email,
          password: password,
          createdAt: createdAt,
          url: url,
          fullname: fullname,
          username: username,
          lastLogin: lastLogin,
          followers: followers,
          following: following,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      createdAt: json['createdAt'],
      url: json['url'],
      fullname: json['fullname'],
      username: json['username'],
      posts: json['posts'],
      lastLogin: json['lastLogin'],
      followers: json['followers'],
      following: json['following'],
    );
  }
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      password: user.password,
      createdAt: user.createdAt,
      url: user.url,
      fullname: user.fullname,
      posts: user.posts,
      lastLogin: user.lastLogin,
      followers: user.followers,
      following: user.following,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'password': password,
        'createdAt': createdAt,
        'url': url,
        'fullname': fullname,
        'username': username,
        'posts': posts,
        'lastLogin': lastLogin,
        'followers': followers,
        'following': following,
      };
}
