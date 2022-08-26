import 'package:firebase_auth/firebase_auth.dart';
import 'package:synergy/data/datasource/remote_data_source.dart';
import 'package:synergy/data/models/comment_model.dart';
import 'package:synergy/data/models/user_model.dart';
import 'package:synergy/domain/entity/chat_entity.dart';
import 'package:synergy/domain/entity/comment_entity.dart';
import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/domain/entity/user_entity.dart';
import 'package:synergy/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remote;
  RepositoryImpl({
    required this.remote,
  });
  @override
  Future<void> loginWithFaceBook() async {
    try {
      await remote.loginWithFaceBook();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Stream<User?> userState() => remote.userState();

  @override
  Future<void> signin(String email, String password) async {
    try {
      await remote.signin(email, password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signup(UserEntity user) async {
    try {
      await remote.signup(UserModel.fromEntity(user));
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Stream<List<PostEntity>> fetchPosts() {
    try {
      final postResult = remote.fetchPosts();
      return postResult;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      await remote.loginWithGoogle();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<UserEntity> fetchUser(String uid) async {
    try {
      final user = await remote.fetchUser(uid);
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>> searchUsers(String query) {
    try {
      final result = remote.searchUsers(query);
      return result;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<String> likePost(String postId, String uid, List likes) async {
    try {
      final result = await remote.likePost(postId, uid, likes);
      return result;
    } on FirebaseException {
      print('di malike lods');
      rethrow;
    }
  }

  @override
  Future<PostEntity> getPost(String uid) async {
    try {
      final result = await remote.getPost(uid);
      return result;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> sendComment(CommentEntity comment, String uid) async {
    try {
      await remote.sendComment(CommentModel.fromEntity(comment), uid);
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Stream<List<CommentEntity>> fetchComments(String uid) {
    try {
      final result = remote.fetchComments(uid);
      return result;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Stream<List<PostEntity>> fetchUserPosts(String uid) {
    try {
      final result = remote.fetchUserPosts(uid);
      return result;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> follow(
    String myId,
    String uid,
  ) async {
    try {
      await remote.follow(myId, uid);
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> sendMessage(
      String msg, String chatUid, String userId, String friendName) async {
    try {
      await remote.sendMessage(msg, chatUid, userId, friendName);
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Stream<List<ChatEntity>> fetchChats(String chatUid) {
    try {
      final result = remote.fetchChats(chatUid);
      return result;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>> fetchUsers() {
    try {
      final result = remote.fetchUsers();
      return result;
    } on FirebaseException {
      rethrow;
    }
  }
}
