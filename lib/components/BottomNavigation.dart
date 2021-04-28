import 'package:AlkometerApp/main.dart';
import 'package:AlkometerApp/pages/HomeScreen.dart';
import 'package:AlkometerApp/pages/SettingsScreen.dart';
import 'package:AlkometerApp/pages/TrackingsScreen.dart';
import 'package:flutter/material.dart';

class BottomNavigationComponent extends StatelessWidget {
  int currentPage;
  BuildContext context;

  BottomNavigationComponent({
    @required this.currentPage,
    @required this.context,
  });

  List<StatefulWidget> _screens = [
    TrackingScreen(),
    HomeScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    Navigator.of(context).pushReplacement(
      createRoute(_screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Trackings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: this.currentPage,
      selectedItemColor: Colors.lightBlue,
      onTap: _onItemTapped,
    );
  }
}
