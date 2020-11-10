import 'dart:math';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class ChartBezier extends StatefulWidget {
  @override
  _ChartBezierState createState() => _ChartBezierState();
}

class _ChartBezierState extends State<ChartBezier> {
  final fromDate = DateTime.now().subtract(Duration(days: 28));
  final toDate = DateTime.now();
  Random random = new Random();

  final date1 = DateTime.now().subtract(Duration(days: 2));
  final date2 = DateTime.now().subtract(Duration(days: 3));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Step Chart'),
        backgroundColor: Constants.darkPrimary
        ,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Constants.lightPrimary, Constants.lightPrimary],
          begin: Alignment.bottomCenter,
        )),
        child: Center(
          child: Card(
            elevation: 1,
            child: Container(
              color: Constants.darkPrimary,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: BezierChart(
                fromDate: fromDate,
                bezierChartScale: BezierChartScale.WEEKLY,
                toDate: toDate,
                selectedDate: toDate,
                series: [
                  BezierLine(
                    label: "Steps",
                    onMissingValue: (dateTime) {
                      double val =
                          double.parse(random.nextInt(1500).toString());
                      return val;
                    },
                    data: [
                      DataPoint<DateTime>(value: 10, xAxis: date1),
                      DataPoint<DateTime>(value: 50, xAxis: date2),
                    ],
                  ),
                ],
                config: BezierChartConfig(
                  yAxisTextStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  verticalIndicatorStrokeWidth: 3.0,
                  displayYAxis: true,
                  stepsYAxis: 300,
                  verticalIndicatorColor: Colors.black26,
                  showVerticalIndicator: true,
                  verticalIndicatorFixedPosition: false,
                  backgroundColor: Constants.darkPrimary,
                  footerHeight: 30.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
