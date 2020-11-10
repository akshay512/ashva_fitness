import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/screens/individual/barchartnew.dart';
import 'package:flutter/material.dart';

class ChartNewPage extends StatefulWidget {
  @override
  _ChartNewPageState createState() => _ChartNewPageState();
}

class _ChartNewPageState extends State<ChartNewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Constants.lightPrimary, Constants.darkPrimary],
        begin: Alignment.bottomCenter,
      )),
        child: Center(
          child: BarChartSample3(),
        ),
      ),
    );
  }
}