import 'package:firebase_auth/firebase_auth.dart';
import 'package:synergy/domain/entity/chat_entity.dart';
import 'package:synergy/domain/entity/comment_entity.dart';
import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/domain/entity/user_entity.dart';

abstract class Repository {
  Future<void> loginWithFaceBook();
  Stream<User?> userState();
  Future<void> signin(String email, String password);
  Future<void> signup(UserEntity user);
  Stream<List<PostEntity>> fetchPosts();
  Future<void> loginWithGoogle();
  Future<UserEntity> fetchUser(String uid);
  Stream<List<UserEntity>> searchUsers(String query);
  Future<String> likePost(String postId, String uid, List likes);
  Future<PostEntity> getPost(String uid);
  Future<void> sendComment(CommentEntity comment, String uid);
  Stream<List<CommentEntity>> fetchComments(String uid);
  Stream<List<PostEntity>> fetchUserPosts(String uid);
  Future<void> follow(String myId, String uid);
  Future<void> sendMessage(
    String msg,
    String chatUid,
    String userId,
    String friendName,
    String recieverUrl,
    String senderUrl,
  );
  Stream<List<ChatEntity>> fetchChats(String chatUid);
  Stream<List<UserEntity>> fetchUsers();
}
