import 'package:AlkometerApp/components/BottomNavigation.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationComponent(
        currentPage: 2,
        context: context,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "This is the SettingsScreen",
            ),
          ],
        ),
      ),
    );
  }
}
