import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synergy/domain/usecase/fetchuserposts.dart';
import 'package:synergy/domain/usecase/getpost.dart';
import 'package:synergy/domain/usecase/likepost.dart';

import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/domain/usecase/fetchposts.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(
    this._fetchPosts,
    this._likePost,
    this._getPost,
    this._fetchUserPosts,
  ) : super(PostsInitial());

  final FetchPosts _fetchPosts;
  final LikePost _likePost;
  final GetPost _getPost;
  final FetchUserPosts _fetchUserPosts;

  void fetchPosts() async {
    emit(Loading());
    final postStream = _fetchPosts();

    postStream.listen((event) {
      Future.delayed(const Duration(seconds: 2), () {
        if (event.isEmpty) {
          emit(Empty());
        } else {
          emit(Loaded(
            posts: event,
          ));
        }
      });
    });
  }

  void likePost(String postId, String uid, List likes) async {
    await _likePost(postId, uid, likes);
  }

  void getPost(String uid) async {
    emit(Loading());
    final post = await _getPost(uid);

    emit(PostLoaded(post: post));
  }

  void fetchUserPosts(String uid) async {
    emit(Loading());
    final userPosts = _fetchUserPosts(uid);
    userPosts.listen((userPosts) {
      if (userPosts.isEmpty) {
        emit(Empty());
      } else {
        emit(UserPostLoaded(posts: userPosts));
      }
    });
  }
}
