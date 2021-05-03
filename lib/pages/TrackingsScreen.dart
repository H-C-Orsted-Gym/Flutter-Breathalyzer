import 'package:AlkometerApp/classes/TrackingClass.dart';
import 'package:AlkometerApp/components/BottomNavigationComponent.dart';
import 'package:AlkometerApp/components/HeaderComponent.dart';
import 'package:AlkometerApp/components/LoadingComponent.dart';
import 'package:AlkometerApp/components/SquareComponent.dart';
import 'package:AlkometerApp/components/TrackingComponent.dart';
import 'package:AlkometerApp/components/TrackingList.dart';
import 'package:AlkometerApp/main.dart';
import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  TrackingScreen({Key key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  List<Map<String, Object>> records;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRecords();
  }

  void getRecords() async {
    List<Map<String, Object>> result = await Tracking.instance.getRecords();

    setState(() {
      records = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (records == null) {
      return LoadingComponent();
    } else {
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
                        padding: EdgeInsets.only(top: 20.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                  "Trackings",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 35, top: 5.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      print("reloaded...");
                                      Navigator.of(context).pushReplacement(createRoute(TrackingScreen()));
                                    });
                                  },
                                  child: Icon(Icons.replay),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: TrackingList(
                            data: records,
                          ),
                          /*ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: [
                            TrackingComponent(
                              dateTracked: DateTime.now(),
                              promille: 3.14,
                            ),
                          ],
                        ),*/
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
}
