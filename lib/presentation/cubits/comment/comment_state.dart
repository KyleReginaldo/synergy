// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentEntity> comments;
  CommentLoaded({
    required this.comments,
  });
}

class CommentLoading extends CommentState {}

class CommentEmpty extends CommentState {
  final PostEntity posts;
  CommentEmpty({required this.posts});
}

class Empty extends CommentState {}
