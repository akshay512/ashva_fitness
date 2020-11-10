import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarChartSample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {

  final List<Map<Object,String>> graphData= [{'steps': '12', 'date': '2020-06-07 (tod)'}, {'steps': '341', 'date':' 2020-06-06 (Sat)'}, {'steps': '16', 'date': '2020-06-05 (Fri)'}, {'steps': '173', 'date': '2020-06-04 (Thu)'}, {'steps': '14', 'date': '2020-05-31 (Sun)'}];
  List<BarChartGroupData> barGroups= List();

  int getx(String value) {
    switch (value.toLowerCase()) {
                    case 'tod':
                      return -1;
                    case 'mon':
                      return 0;
                    case 'tue':
                      return 1;
                    case 'wed':
                      return 2;
                    case 'thu':
                      return 3;
                    case 'fri':
                      return 4;
                    case 'sat':
                      return 5;
                    case 'sun':
                      return 6;
                    default:
                      return 7;
                  }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var list = widget.list;
    // print("data from behind-->" + list.toString());
    for (Map<Object, String> entry in graphData) {
      // DateTime d = DateFormat("dd-MM-yyyy").parse(entry["date"].toString());
      // double value = double.parse(entry["steps"].toString());
      
      // print(value);
      barGroups.add(
        BarChartGroupData(
                  x: getx(entry["date"].substring(entry["date"].indexOf('(') + 1, entry["date"].indexOf(')'))),
                  barRods: [BarChartRodData(y: double.parse(entry['steps'].toString()), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 1000,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipBottomMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(
                    color: const Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case -1:
                      return 'Tod';
                    case 0:
                      return 'Mon';
                    case 1:
                      return 'Tue';
                    case 2:
                      return 'Wed';
                    case 3:
                      return 'Thu';
                    case 4:
                      return 'Fri';
                    case 5:
                      return 'Sat';
                    case 6:
                      return 'Sun';
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: barGroups
          ),
        ),
      ),
    );
  }
}