import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:synergy/domain/entity/chat_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class CurrentUser extends StatefulWidget {
  final ChatEntity e;
  const CurrentUser({Key? key, required this.e}) : super(key: key);

  @override
  State<CurrentUser> createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (widget.e.uid != FirebaseAuth.instance.currentUser!.uid) {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 60,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const CustomText('Reply',
                            size: 17, weight: FontWeight.w500),
                        const CustomText('Unsend',
                            size: 17, weight: FontWeight.w500),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomText(
                                              timeago.format(DateTime.parse(
                                                  widget.e.createdOn)),
                                              weight: FontWeight.w600,
                                            ),
                                            const CustomText(
                                              'Foward',
                                              weight: FontWeight.w600,
                                            ),
                                            const CustomText(
                                              'Copy',
                                              weight: FontWeight.w600,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const CustomText('More',
                                size: 17, weight: FontWeight.w500)),
                      ]),
                );
              });
        } else {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 60,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const CustomText('Reply',
                            size: 17, weight: FontWeight.w500),
                        const CustomText('Report',
                            size: 17, weight: FontWeight.w500),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomText(
                                              timeago.format(DateTime.parse(
                                                  widget.e.createdOn)),
                                              weight: FontWeight.w600,
                                            ),
                                            const CustomText(
                                              'Foward',
                                              weight: FontWeight.w600,
                                            ),
                                            const CustomText(
                                              'Copy',
                                              weight: FontWeight.w600,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const CustomText('More',
                                size: 17, weight: FontWeight.w500)),
                      ]),
                );
              });
        }
      },
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      child: Align(
        alignment: widget.e.uid != FirebaseAuth.instance.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              widget.e.uid != FirebaseAuth.instance.currentUser!.uid
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Container(
              margin: widget.e.uid == FirebaseAuth.instance.currentUser!.uid
                  ? const EdgeInsets.only(right: 100, top: 5)
                  : const EdgeInsets.only(left: 100, top: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: widget.e.msg.length != 20
                      ? BorderRadius.circular(10)
                      : BorderRadius.circular(15)),
              child: CustomText(
                widget.e.msg,
                textAlign: TextAlign.right,
              ),
            ),
            isVisible
                ? CustomText(
                    timeago.format(DateTime.parse(widget.e.createdOn)),
                    size: 10,
                    color: Colors.grey,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
