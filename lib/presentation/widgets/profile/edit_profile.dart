import 'package:flutter/material.dart';
import 'package:general/widgets/text.dart';
import 'package:general/widgets/textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final name = TextEditingController();
  final username = TextEditingController();
  final pronouns = TextEditingController();
  final website = TextEditingController();
  final bio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const CustomText(
          'Edit Profile',
          color: Colors.black,
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(backgroundImage: NetworkImage(''), radius: 50),
              const SizedBox(height: 15),
              const CustomText(
                'Change Profile Picture',
                color: Colors.blue,
              ),
              const SizedBox(height: 35),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelTextBuilder('Name'),
                      CustomTextField('Name', controller: name),
                      labelTextBuilder('Username'),
                      CustomTextField('Username', controller: username),
                      labelTextBuilder('Pronouns'),
                      CustomTextField('Pronouns', controller: pronouns),
                      labelTextBuilder('Website'),
                      CustomTextField('Website', controller: website),
                      labelTextBuilder('Bio'),
                      CustomTextField('Bio', controller: bio),
                      const SizedBox(height: 20),
                      buttonTextBuilder('Switch to prefessional account'),
                      buttonTextBuilder('Edit Avatar'),
                      buttonTextBuilder('Personal information settings')
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget labelTextBuilder(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: CustomText(
      text,
      size: 12,
      color: Colors.grey.shade700,
    ),
  );
}

Widget buttonTextBuilder(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: CustomText(text, color: Colors.blue),
  );
}
