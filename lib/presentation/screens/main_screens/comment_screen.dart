import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/presentation/cubits/comment/comment_cubit.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';

import '../../../domain/entity/comment_entity.dart';
import '../../widgets/custom/comment_container.dart';

class CommentScreen extends StatefulWidget {
  final String uid;
  const CommentScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    context.read<CommentCubit>().fetchComments(widget.uid);
    super.initState();
  }

  Future<void> _onRefresh() async {
    context.read<CommentCubit>().fetchComments(widget.uid);
  }

  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const CustomText('Comments', color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UsersLoaded) {
              final user = state.user;
              return Column(
                children: [
                  Expanded(
                    child: BlocBuilder<CommentCubit, CommentState>(
                      builder: (context, state) {
                        if (state is CommentLoaded) {
                          final comments = state.comments;
                          return RefreshIndicator(
                            onRefresh: _onRefresh,
                            color: Colors.black,
                            child: SingleChildScrollView(
                              child: Column(
                                children: comments
                                    .map(
                                      (comment) => CommentContainer(
                                        comment: comment,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        } else if (state is CommentEmpty) {
                          final emptyComment = state.posts;
                          return EmptyComment(post: emptyComment);
                        } else if (state is CommentLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  CustomTextField(
                    'Add a comment...',
                    controller: commentController,
                    suffix: IconButton(
                      onPressed: () async {
                        final comment = CommentEntity(
                          createdAt: DateTime.now().toString(),
                          fullname: user.fullname,
                          url: user.url,
                          body: commentController.text,
                        );

                        context
                            .read<CommentCubit>()
                            .sendComment(comment, widget.uid);
                        commentController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ],
              );
            } else if (state is UsersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: CustomText('Empty from bloc', color: Colors.black),
            );
          },
        ),
      ),
    );
  }
}
