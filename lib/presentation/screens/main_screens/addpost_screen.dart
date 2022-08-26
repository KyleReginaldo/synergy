import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:path_provider/path_provider.dart';

import 'package:synergy/presentation/cubits/users/users_cubit.dart';

import '../../../core/firebase_storage.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? file;
  String name = '';

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    print('name : ${result!.names}');
    if (result != null) {
      final image = await saveFile(result.files.first);
      name = result.names.first!;
      setState(() {
        file = image;
      });
    } else {
      return;
    }
  }

  Future<File> saveFile(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  @override
  void initState() {
    context
        .read<UsersCubit>()
        .fetchUser(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  final descriptionController = TextEditingController();
  String url = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const CustomText(
          'New post',
          color: Colors.black,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              uploadImage(
                file!,
                name,
                descriptionController.text,
                url,
                username,
                FirebaseAuth.instance.currentUser!.uid,
              ).then((value) => Navigator.pop(context, true));
            },
            icon: const Iconify(Ic.baseline_check),
          ),
        ],
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoaded) {
            url = state.user.url;
            username = state.user.fullname;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          state.user.url,
                          height: 54,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          pickFile();
                        },
                        icon: const Iconify(
                          Uil.image_upload,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(height: 16),
                  file != null
                      ? Image.file(
                          file!,
                          height: 420,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        )
                      : const CustomText(
                          'Upload image to level up your content.',
                        ),
                  const Spacer(),
                ],
              ),
            );
          } else if (state is Loading) {
            return const LinearProgressIndicator();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
