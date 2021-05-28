import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/pages/home/fragments/home_fragment.dart';
import 'package:vootech_realchat/src/pages/home/fragments/notification_fragment.dart';
import 'package:vootech_realchat/src/pages/home/fragments/profile_fragment.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageAccountantState createState() => _HomePageAccountantState();
}

class _HomePageAccountantState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> _fragments = [
    HomeFragment(),
    NotificationFragment(),
    ProfileFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _fragments[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _currentIndex == 0 ? Icon(Icons.home, size: 28) : Icon(Icons.home_outlined, size: 28),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1 ? Icon(Icons.notifications, size: 28) : Icon(Icons.notifications_outlined, size: 28),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2 ? Icon(Icons.person, size: 28) : Icon(Icons.person_outline, size: 28),
            label: "",
          ),

        ],
        currentIndex: _currentIndex,
        unselectedItemColor: AppColors.hintFontColor,
        selectedItemColor: AppColors.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
