import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:synergy/presentation/screens/main_screens/home_screen.dart';
import 'package:synergy/presentation/screens/main_screens/profile_screen.dart';
import 'package:synergy/presentation/screens/main_screens/search_screen.dart';

import '../../../core/global/global_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppbar(_selectedIndex, context),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Iconify(Mdi.home_variant,
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
              icon: Iconify(Uil.search,
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
              icon: Iconify(Bi.person_circle,
                  color: _selectedIndex == 2 ? Colors.black : Colors.grey),
              label: ''),
        ],
      ),
    );
  }
}
