import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const CustomText('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextField("Search", controller: controller),
            rowBuilder(
                () {}, const Icon(Icons.add), 'Follow and invite friends'),
            rowBuilder(() {}, const Icon(Icons.notifications), 'Notification'),
            rowBuilder(() {}, const Icon(Icons.create_sharp), 'Creator'),
            rowBuilder(() {}, const Icon(Icons.lock), 'Privacy'),
            rowBuilder(() {}, const Icon(Icons.security), 'Security'),
            rowBuilder(() {}, const Icon(Icons.ads_click), 'Ads'),
            rowBuilder(() {}, const Icon(Icons.person), 'Account'),
            rowBuilder(() {}, const Icon(Icons.help), 'Help'),
            rowBuilder(() {}, const Icon(Icons.info), 'About'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child:
                  CustomText('K\'s Project', weight: FontWeight.w600, size: 18),
            ),
            const CustomText(
              'Account Center',
              color: Colors.blue,
            ),
            const CustomText(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),
            const CustomText('Logins'),
            const CustomText('Add accounts'),
            GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  Future.delayed(const Duration(seconds: 1), () async {
                    await FirebaseAuth.instance.signOut();
                  });
                },
                child: const CustomText('Log out'))
          ],
        ),
      ),
    );
  }
}

Widget rowBuilder(
  VoidCallback function,
  Widget icon,
  String label,
) {
  return GestureDetector(
    onTap: function,
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomText(label),
          )
        ],
      ),
    ),
  );
}
