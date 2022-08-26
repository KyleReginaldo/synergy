part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class Loaded extends PostsState {
  final List<PostEntity> posts;
  Loaded({
    required this.posts,
  });
}

class UserPostLoaded extends PostsState {
  final List<PostEntity> posts;
  UserPostLoaded({
    required this.posts,
  });
}

class PostLoaded extends PostsState {
  final PostEntity post;
  PostLoaded({
    required this.post,
  });
}

class Loading extends PostsState {}

class Empty extends PostsState {}
