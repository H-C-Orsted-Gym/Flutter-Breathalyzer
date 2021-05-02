import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:AlkometerApp/classes/TrackingClass.dart';
import 'package:AlkometerApp/components/BottomNavigationComponent.dart';
import 'package:AlkometerApp/components/BreakLineComponent.dart';
import 'package:AlkometerApp/components/CircleComponent.dart';
import 'package:AlkometerApp/components/HeaderComponent.dart';
import 'package:AlkometerApp/globals.dart' as globals;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = "";

  StreamSubscription<Uint8List> subscription;

  @override
  void initState() {
    super.initState();

    if (globals.currentConnection != null) {
      subscription = globals.currentConnection.input.listen((data) {
        print(ascii.decode(data));
        setState(() {
          createRecord((double.parse(ascii.decode(data)) / 1000).toStringAsExponential(2).toString(), DateFormat('dd/MM/yyyy – kk:mm').format(DateTime.now()).toString());
          this.result = (double.parse(ascii.decode(data)) / 1000).toStringAsExponential(2).toString().trim();
        });
      });
    }

    getLatestRecording();
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel().then((value) {
        print("Im done :)");
      });
    }

    super.dispose();
  }

  void getLatestRecording() async {
    List<Map<String, Object>> trackingResult = await Tracking.instance.getLatestSample();

    setState(() {
      if (trackingResult.isNotEmpty) {
        result = trackingResult[0]["DataTracked"];
      } else {
        result = "0.0";
      }
    });
  }

  void createRecord(String promille, String dateTracked) async {
    await Tracking.instance.insert({
      Tracking.columnDate: dateTracked,
      Tracking.columnData: promille,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationComponent(
        currentPage: 1,
        context: context,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.green,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CircleComponent(
                fillings: Center(
                  child: Text(
                    this.result,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                ),
                child: BreakLineComponent(),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Column(
                  children: [
                    Text(
                      "Du er ædru om:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                    Text(
                      "52 min",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: BreakLineComponent(),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                height: 200,
                width: 300,
                child: LineChart(
                  LineChartData(
                    minX: 1,
                    maxX: 5,
                    minY: 0,
                    maxY: 5,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map(
                            (touchedSpot) {
                              return LineTooltipItem(touchedSpot.y.toString(), TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
                            },
                          ).toList();
                        },
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                        showTitles: false,
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    axisTitleData: FlAxisTitleData(
                      show: true,
                      leftTitle: AxisTitle(
                        titleText: "Promille",
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        margin: -10,
                        showTitle: true,
                      ),
                      bottomTitle: AxisTitle(
                        titleText: "Målinger d. 30/04/2021",
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        showTitle: true,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(1, 4),
                          FlSpot(2, 3),
                          FlSpot(3, 2),
                          FlSpot(4, 5),
                          FlSpot(5, 4),
                        ],
                        isCurved: true,
                        colors: [
                          Colors.white,
                        ],
                        barWidth: 3.0,
                        show: true,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
