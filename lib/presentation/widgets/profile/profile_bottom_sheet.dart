import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/fe.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mi.dart';
import 'package:iconify_flutter/icons/uil.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildRow(const Iconify(Bi.gear_wide), 'Settings'),
          buildRow(const Iconify(Uil.history), 'Archive'),
          buildRow(const Iconify(Bi.clock_history), 'Your activity'),
          buildRow(const Iconify(Uil.qrcode_scan), 'QR code'),
          buildRow(const Iconify(Ic.sharp_bookmark_border), 'Saved'),
          buildRow(const Iconify(Gridicons.menus), 'Close friends'),
          buildRow(const Iconify(Mi.favorite), 'Favourites'),
          buildRow(
              const Iconify(Bi.heart_pulse), 'COVID-19 Information Centre'),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              Future.delayed(const Duration(seconds: 1), () async {
                await FirebaseAuth.instance.signOut();
              });
            },
            child: buildRow(const Iconify(Fe.logout), 'Sign out'),
          ),
        ],
      ),
    );
  }
}

Widget buildRow(Widget icon, String label) {
  return Row(
    children: [
      icon,
      const SizedBox(
        width: 8,
      ),
      CustomText(
        label,
        size: 17,
      )
    ],
  );
}
