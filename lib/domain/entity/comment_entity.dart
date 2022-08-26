class CommentEntity {
  final String createdAt;
  final String fullname;
  final String url;
  final String body;
  String uid;
  CommentEntity({
    required this.createdAt,
    required this.fullname,
    required this.url,
    required this.body,
    this.uid = "",
  });
}
