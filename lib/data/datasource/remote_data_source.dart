import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:synergy/data/models/chat_model.dart';
import 'package:synergy/data/models/comment_model.dart';
import 'package:synergy/data/models/post_model.dart';

import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<void> loginWithFaceBook();
  Stream<User?> userState();
  Future<void> signin(String email, String password);
  Future<void> signup(UserModel user);
  Stream<List<PostModel>> fetchPosts();
  Future<void> loginWithGoogle();
  Future<UserModel> fetchUser(String uid);
  Stream<List<UserModel>> searchUsers(String query);
  Future<String> likePost(String postId, String uid, List likes);
  Future<PostModel> getPost(String uid);
  Future<void> sendComment(CommentModel comment, String uid);
  Stream<List<CommentModel>> fetchComments(String uid);
  Stream<List<PostModel>> fetchUserPosts(String uid);
  Future<void> follow(
    String myId,
    String uid,
  );
  Future<void> sendMessage(
    String msg,
    String chatUid,
    String userId,
    String friendName,
  );
  Stream<List<ChatModel>> fetchChats(String chatUid);
  Stream<List<UserModel>> fetchUsers();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  @override
  Future<void> loginWithFaceBook() async {
    final facebookLoginResult = await FacebookAuth.instance.login();
    final userData = await FacebookAuth.instance.getUserData();
    final facebookAuthCredential =
        FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
    final docUser = await _auth.signInWithCredential(facebookAuthCredential);
    if (docUser.additionalUserInfo!.isNewUser) {
      await _db.collection('users').doc(docUser.user!.uid).set({
        'uid': docUser.user!.uid,
        'email': userData['email'],
        'password': 'not applicable',
        'fullname': userData['name'],
        'url': userData['picture']['data']['url'],
        'createdAt': DateTime.now().toString(),
        'username': '',
        'lastLogin': DateTime.now().toString(),
        'posts': [],
        'followers': [],
        'following': [],
      });
    } else {
      await _db.collection('users').doc(docUser.user!.uid).update({
        'lastLogin': DateTime.now().toString(),
      });
    }
  }

  @override
  Stream<User?> userState() => _auth.userChanges();

  @override
  Future<void> signin(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) async => _db
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'lastLogin': DateTime.now().toString()}),
        );
  }

  @override
  Future<void> signup(UserModel user) async {
    final docUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    user.uid = docUser.user!.uid;
    user.url = 'https://graph.facebook.com/1271871656883523/picture';
    await _db.collection('users').doc(docUser.user!.uid).set(user.toJson());
  }

  @override
  Stream<List<PostModel>> fetchPosts() {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => PostModel.fromJson(e.data())).toList());
  }

  @override
  Future<void> loginWithGoogle() async {
    final googleSinginAccount = await GoogleSignIn().signIn();

    final googleAccount = await googleSinginAccount!.authentication;
    final googleCredential = GoogleAuthProvider.credential(
      idToken: googleAccount.idToken,
      accessToken: googleAccount.accessToken,
    );
    final userDoc =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
    if (userDoc.additionalUserInfo!.isNewUser) {
      await _db.collection('users').doc(userDoc.user!.uid).set({
        'uid': userDoc.user!.uid,
        'email': userDoc.user!.email,
        'password': 'not applicable',
        'fullname': userDoc.user!.displayName,
        'url': userDoc.user!.photoURL,
        'createdAt': DateTime.now().toString(),
        'username': '',
        'lastLogin': DateTime.now().toString(),
        'posts': [],
        'followers': [],
        'following': [],
      });
    } else {
      await _db.collection('users').doc(userDoc.user!.uid).update({
        'lastLogin': DateTime.now().toString(),
      });
    }
  }

  @override
  Future<UserModel> fetchUser(String uid) async {
    final user = await _db.collection('users').doc(uid).get();
    return UserModel.fromJson(user.data()!);
  }

  @override
  Stream<List<UserModel>> searchUsers(String query) {
    final searchResult = _db
        .collection('users')
        .where('fullname', isGreaterThanOrEqualTo: query)
        .where('fullname', isLessThan: '${query}z')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => UserModel.fromJson(e.data())).toList());
    return searchResult;
  }

  //*like specific post
  @override
  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _db.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _db.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  Future<PostModel> getPost(String uid) async {
    final post = await _db.collection('posts').doc(uid).get();
    return PostModel.fromJson(post.data()!);
  }

  @override
  Future<void> sendComment(CommentModel comment, String uid) async {
    final commentDoc =
        _db.collection('posts').doc(uid).collection('comments').doc();
    comment.uid = commentDoc.id;
    await commentDoc.set(comment.toJson());
  }

  @override
  Stream<List<CommentModel>> fetchComments(String uid) {
    return _db
        .collection('posts')
        .doc(uid)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CommentModel.fromJson(e.data())).toList());
  }

  @override
  Stream<List<PostModel>> fetchUserPosts(String uid) {
    return _db
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => PostModel.fromJson(e.data())).toList());
  }

  @override
  Future<void> follow(String myId, String uid) async {
    final snap = await _db.collection('users').doc(myId).get();
    List following = (snap.data()!)['following'];

    if (following.contains(uid)) {
      await _db.collection('users').doc(uid).update({
        'followers': FieldValue.arrayRemove([myId])
      });

      await _db.collection('users').doc(myId).update({
        'following': FieldValue.arrayRemove([uid])
      });
    } else {
      await _db.collection('users').doc(uid).update({
        'followers': FieldValue.arrayUnion([myId])
      });

      await _db.collection('users').doc(myId).update({
        'following': FieldValue.arrayUnion([uid])
      });
    }
  }

  @override
  Future<void> sendMessage(
    String msg,
    String chatUid,
    String userId,
    String friendName,
  ) async {
    if (msg == '') return;
    await _db.collection('chats').doc(chatUid).collection('messages').add({
      'createdOn': DateTime.now().toString(),
      'uid': userId,
      'friendName': friendName,
      'msg': msg
    }).then((value) {
      '';
    });
  }

  @override
  Stream<List<ChatModel>> fetchChats(String chatUid) {
    return _db
        .collection('chats')
        .doc(chatUid)
        .collection('messages')
        .orderBy('createdOn', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              print(e);
              return ChatModel.fromJson(e.data());
            }).toList());
  }

  @override
  Stream<List<UserModel>> fetchUsers() {
    return _db.collection('users').snapshots().map((event) =>
        event.docs.map((e) => UserModel.fromJson(e.data())).toList());
  }
}
