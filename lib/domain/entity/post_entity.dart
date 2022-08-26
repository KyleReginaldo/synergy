class PostEntity {
  final String createdAt;
  final String description;
  final List likes;
  String postId;
  final String postUrl;
  final String profileImage;
  final String uid;
  final String username;
  PostEntity({
    required this.createdAt,
    required this.description,
    required this.likes,
    this.postId = '',
    required this.postUrl,
    required this.profileImage,
    required this.uid,
    required this.username,
  });
}
