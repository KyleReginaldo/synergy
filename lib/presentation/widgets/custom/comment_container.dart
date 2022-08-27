import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:synergy/domain/entity/comment_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../domain/entity/post_entity.dart';

class CommentContainer extends StatefulWidget {
  final CommentEntity comment;
  const CommentContainer({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.comment.url),
                  radius: 20,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    widget.comment.fullname,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    timeago.format(
                      DateTime.parse(widget.comment.createdAt),
                    ),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: isVisible
                  ? CustomText(
                      widget.comment.body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  : CustomText(
                      widget.comment.body,
                    )),
          const SizedBox(height: 15),
          Row(
            children: const [
              CustomText('Like'),
              SizedBox(width: 5),
              CustomText('Reply'),
              SizedBox(width: 5),
              CustomText('Delete'),
            ],
          ),
          const Divider(height: 15)
        ],
      ),
    );
  }
}

class EmptyComment extends StatefulWidget {
  final PostEntity post;
  const EmptyComment({Key? key, required this.post}) : super(key: key);

  @override
  State<EmptyComment> createState() => _EmptyCommentState();
}

class _EmptyCommentState extends State<EmptyComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.profileImage),
                  radius: 20,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    widget.post.username,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    timeago.format(
                      DateTime.parse(widget.post.createdAt),
                    ),
                  ),
                ],
              )
            ],
          ),
          CustomText(
            widget.post.description,
          ),
        ],
      ),
    );
  }
}
