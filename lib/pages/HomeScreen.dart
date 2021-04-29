import 'package:AlkometerApp/components/BottomNavigationComponent.dart';
import 'package:AlkometerApp/components/BreakLineComponent.dart';
import 'package:AlkometerApp/components/CircleComponent.dart';
import 'package:AlkometerApp/components/HeaderComponent.dart';
import 'package:fl_chart/fl_chart.dart';
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
                    "1.23",
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
                    minX: 0,
                    maxX: 10,
                    minY: 0,
                    maxY: 5,
                    gridData: FlGridData(
                      show: true,
                    ),
                    axisTitleData: FlAxisTitleData(
                      show: true,
                      leftTitle: AxisTitle(
                        titleText: "Promille",
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        margin: -30,
                        showTitle: true,
                      ),
                      bottomTitle: AxisTitle(
                        titleText: "Målinger d. 29/04/2021",
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
                          FlSpot(2, 4),
                          FlSpot(5, 3),
                          FlSpot(7, 2),
                          FlSpot(8, 5),
                          FlSpot(9, 4),
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
