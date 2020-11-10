import 'package:charts_flutter/flutter.dart' as charts;

class BarGraphModel {
  final String date;

  final double count;

  final charts.Color barColor;

  BarGraphModel({
    this.date,
    this.count,
    this.barColor,
  });
}
