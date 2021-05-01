import 'package:AlkometerApp/components/BottomNavigationComponent.dart';
import 'package:AlkometerApp/components/HeaderComponent.dart';
import 'package:AlkometerApp/components/SquareComponent.dart';
import 'package:AlkometerApp/components/TrackingComponent.dart';
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
            HeaderComponent(icon: Icons.bar_chart, title: "Data", color: Colors.blue),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              child: SquareComponent(
                fillings: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Trackings",
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: [
                            TrackingComponent(
                              dateTracked: DateTime.now(),
                              promille: 3.14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
