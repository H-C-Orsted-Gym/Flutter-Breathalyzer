import 'package:AlkometerApp/components/BottomNavigation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationComponent(
        currentPage: 1,
        context: context,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "This is the HomeScreen",
            ),
          ],
        ),
      ),
    );
  }
}
