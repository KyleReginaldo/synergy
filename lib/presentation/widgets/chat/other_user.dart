import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:synergy/domain/entity/chat_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class OtherUser extends StatelessWidget {
  final ChatEntity e;
  const OtherUser({Key? key, required this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
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
                                            timeago.format(
                                                DateTime.parse(e.createdOn)),
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
      },
      child: Container(
        margin: const EdgeInsets.only(right: 100, top: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: Colors.grey.shade400),
            borderRadius: e.msg.length != 20
                ? BorderRadius.circular(10)
                : BorderRadius.circular(15)),
        child: CustomText(
          e.msg,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
