
import 'package:ashva_fitness_example/model/barGraphStepsModel.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;

import 'dart:math';

class BarGraphDemo extends StatefulWidget {
  final List<Map<String, Object>> list;
  BarGraphDemo({Key key, this.list}) : super(key: key);


  @override
  _BarGraphDemoState createState() => _BarGraphDemoState();
}

class _BarGraphDemoState extends State<BarGraphDemo> {
  List<BarGraphModel> data = List();


  //akshay use this data for your chart
  final List<Map<Object,String>> graphData= [{'steps': '12', 'date': '2020-06-07 (tod)'}, {'steps': '341', 'date':' 2020-06-06 (Sat)'}, {'steps': '16', 'date': '2020-06-05 (Fri)'}, {'steps': '173', 'date': '2020-06-04 (Thu)'}, {'steps': '14', 'date': '2020-05-31 (Sun)'}];

 
  @override
  void initState() {
    super.initState();

    getGraphData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * .9,
            padding: const EdgeInsets.all(12),
            child: data != null
                ? MyBarChart(data)
                : Center(child: CircularProgressIndicator()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Text(
              '',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  void getGraphData() {
    List<BarGraphModel> temp = List();
    widget.list.forEach((item) {
      print(item['date']);
      temp.add(
        BarGraphModel(
          date: item['date'].toString().substring(12, 15),
          count: double.parse(item['steps'].toString()),
          barColor: charts.ColorUtil.fromDartColor(
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0)),
        ),
      );
    });
    setState(() {
      print(data);
      data = temp;
    });
  }
}

class MyBarChart extends StatelessWidget {
  final List<BarGraphModel> data;

  MyBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarGraphModel, String>> series = [
      charts.Series(
          id: 'BarGraphModel',
          data: data,
          domainFn: (BarGraphModel downloads, _) => downloads.date,
          measureFn: (BarGraphModel downloads, _) => downloads.count,
          colorFn: (BarGraphModel downloads, _) => downloads.barColor)
    ];

    return charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
    );
  }
}
