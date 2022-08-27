import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

Future<void> uploadImage(
  File file,
  String name,
  String description,
  String profileImage,
  String username,
  String userId,
) async {
  await storage
      .ref('${FirebaseAuth.instance.currentUser!.uid}/$name')
      .putFile(file)
      .then((p0) async {
    final profile = await getProfileUrl(name);
    updateProfilePicture(
      profile,
      description,
      profileImage,
      username,
      userId,
    );
  });
}

Future<void> updateProfilePicture(
  String url,
  String description,
  String profile,
  String username,
  String userId,
) async {
  final postDoc = FirebaseFirestore.instance.collection('posts').doc();

  await postDoc.set({
    'createdAt': DateTime.now().toString(),
    'description': description,
    'likes': [],
    'postUrl': url,
    'profileImage': profile,
    'postId': postDoc.id,
    'uid': userId,
    'username': username,
  }).then((value) async =>
      FirebaseFirestore.instance.collection('users').doc(userId).update({
        'posts': FieldValue.arrayUnion([postDoc.id])
      }));
}

Future<String> getProfileUrl(String name) async {
  String profileUrl = await storage
      .ref('${FirebaseAuth.instance.currentUser!.uid}/$name')
      .getDownloadURL();
  return profileUrl;
}

Future<void> uploadFile(File file, String name) async {
  List downloadUrls = [];

  await storage
      .ref('${FirebaseAuth.instance.currentUser!.uid}/$name')
      .putFile(file)
      .then((p0) async {
    String downloadUrl = await getDownloadUrl(name);
    downloadUrls.add(downloadUrl);
  });

  // _uploadPaymentDetails(downloadUrls: downloadUrls, paymentId: paymentId);
}

Future<String> getDownloadUrl(String imagename) async {
  String downloadUrl = await storage
      .ref('${FirebaseAuth.instance.currentUser!.uid}/$imagename')
      .getDownloadURL();
  return downloadUrl;
}
