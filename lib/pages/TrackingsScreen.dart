import 'package:AlkometerApp/components/BottomNavigation.dart';
import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  TrackingScreen({Key key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationComponent(
        currentPage: 0,
        context: context,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "This is the TrackingScreen",
            ),
          ],
        ),
      ),
    );
  }
}
