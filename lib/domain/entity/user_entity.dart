class UserEntity {
  String uid;
  final String email;
  final String password;
  final String createdAt;
  String url;
  final String fullname;
  String username;
  List? posts;
  String lastLogin;
  final List following;
  final List followers;
  UserEntity({
    this.uid = '',
    required this.email,
    required this.password,
    required this.createdAt,
    this.url = '',
    required this.fullname,
    this.username = ' ',
    this.posts,
    this.lastLogin = '',
    required this.following,
    required this.followers,
  });
}
