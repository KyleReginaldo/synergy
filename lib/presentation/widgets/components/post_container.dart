import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:synergy/presentation/screens/main_screens/comment_screen.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../../dependency.dart';
import '../../cubits/comment/comment_cubit.dart';
import '../../cubits/users/users_cubit.dart';
import '../animation/heart_animation_screen.dart';

class PostContainer extends StatefulWidget {
  final PostEntity post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  bool isHeartAnimation = false;
  bool isFavorite() {
    final isFav = widget.post.likes.where((element) {
      final like = element.contains(FirebaseAuth.instance.currentUser!.uid);
      return like as bool;
    });
    return isFav.isEmpty ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //*wag muna galawin di pa ayos
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => MultiBlocProvider(
                        //       providers: [
                        //         BlocProvider<UsersCubit>(
                        //           create: (context) => sl<UsersCubit>(),
                        //         ),
                        //         BlocProvider<PostsCubit>(
                        //           create: (context) => sl<PostsCubit>(),
                        //         ),
                        //       ],
                        //       child: ViewPersonScreen(
                        //         uid: widget.post.uid,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(widget.post.profileImage),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          widget.post.username,
                          weight: FontWeight.w600,
                          size: 15,
                        ),
                        CustomText(
                          timeago.format(
                            DateTime.parse(widget.post.createdAt),
                          ),
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            height: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    containerBuilder(const Icon(Icons.share)),
                                    containerBuilder(
                                        const Iconify(Ph.link_simple_duotone)),
                                    containerBuilder(
                                        const Icon(Icons.qr_code_2)),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Iconify(
                                          Ic.baseline_report,
                                          color: Colors.red,
                                        ) // widget
                                        )
                                  ],
                                ),
                                const CustomText('Hide Post',
                                    weight: FontWeight.w600),
                                const CustomText('Unfollow this person',
                                    weight: FontWeight.w600)
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          InkWell(
            onDoubleTap: () {
              setState(() {
                isHeartAnimation = true;
              });
              context.read<PostsCubit>().likePost(widget.post.postId,
                  FirebaseAuth.instance.currentUser!.uid, widget.post.likes);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  image: DecorationImage(
                      image: NetworkImage(widget.post.postUrl))),
              width: double.infinity,
              child: Opacity(
                opacity: isHeartAnimation ? 1 : 0,
                child: HeartAnimationWidget(
                  isAnimating: isHeartAnimation,
                  duration: const Duration(milliseconds: 700),
                  onEnd: () => setState(() {
                    isHeartAnimation = false;
                  }),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red.shade700,
                    size: 80,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 12),
              InkWell(
                onTap: () async {
                  context.read<PostsCubit>().likePost(
                        widget.post.postId,
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.post.likes,
                      );
                },
                child: isFavorite()
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red.shade700,
                      )
                    : const Icon(Icons.favorite_border),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: sl<CommentCubit>(),
                          ),
                          BlocProvider.value(
                            value: sl<UsersCubit>()
                              ..fetchUser(
                                  FirebaseAuth.instance.currentUser!.uid),
                          ),
                        ],
                        child: CommentScreen(uid: widget.post.postId),
                      ),
                    ),
                  );
                },
                child: const Iconify(Ri.chat_1_line),
              ),
              const SizedBox(width: 12),
              const Iconify(Cil.send)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: widget.post.likes.length <= 1
                ? CustomText('${widget.post.likes.length.toString()} like')
                : CustomText(
                    '${widget.post.likes.length.toString()} likes',
                    weight: FontWeight.w600,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomText(
              widget.post.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

Widget containerBuilder(Widget icon) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(50)),
      child: icon);
}
