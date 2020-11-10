import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/screens/individual/barGraphPahe.dart';
import 'package:ashva_fitness_example/screens/individual/barchartnew.dart';
import 'package:ashva_fitness_example/screens/registerpage.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartPage extends StatefulWidget {
  // static const String routeName = "/leveldetails";
  // final List<Map<String, Object>> list;
  // ChartPage({Key key, this.list}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  int selectedplan = 0;
  double width, height;
  final fromDate = DateTime(2020, 05, 12);
  final toDate = DateTime.now();
  bool swapcalendar = true;

  final date1 = DateTime.now().subtract(Duration(days: 2));
  final date2 = DateTime.now().subtract(Duration(days: 3));
  List<DataPoint<DateTime>> data = List<DataPoint<DateTime>>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var list = widget.list;
    // print("data from behind-->" + list.toString());
    // for (Map<String, Object> entry in list) {
    //   DateTime d = DateFormat("dd-MM-yyyy").parse(entry["date"].toString());
    //   double value = double.parse(entry["steps"].toString());
    //   print(value);
    //   data.add(
    //     DataPoint<DateTime>(value: value, xAxis: d),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Constants.lightPrimary, Constants.darkPrimary],
          begin: Alignment.bottomCenter,
        )),
        child: Center(
          child: ListView(shrinkWrap: true, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                                  child: IconButton(icon: Icon(Icons.swap_horiz), onPressed: () {
                    setState(() {
                      swapcalendar=!swapcalendar;
                    });
                  }),
                )
              ],),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            //   child: Card(
            //     elevation: 12,
            //     clipBehavior: Clip.hardEdge,
            //     child: Container(
            //       height: MediaQuery.of(context).size.height / 2,
            //       width: MediaQuery.of(context).size.width * 0.9,
            //       child: BezierChart(
            //         fromDate: fromDate,
            //         bezierChartScale: BezierChartScale.WEEKLY,
            //         toDate: toDate,
            //         selectedDate: toDate,
            //         series: [
            //           BezierLine(
            //             label: "Steps",
            //             onMissingValue: (dateTime) {
            //               if (dateTime.day.isEven) {
            //                 return 10.0;
            //               }
            //               return 5.0;
            //             },
            //             data: data,
            //           ),
            //         ],
            //         config: BezierChartConfig(
            //           yAxisTextStyle: TextStyle(
            //             fontSize: 12,
            //             color: Colors.white,
            //           ),
            //           backgroundGradient: LinearGradient(
            //             colors: [
            //               // Colors.red[300],
            //               // Colors.red[400],
            //               // Colors.red[400],
            //               // Colors.red[500],
            //               // Colors.red,
            //               Colors.blue,
            //               Colors.blueAccent
            //             ],
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //           ),
            //           verticalIndicatorStrokeWidth: 3.0,
            //           displayYAxis: true,
            //           verticalIndicatorColor: Colors.black26,
            //           showVerticalIndicator: true,
            //           verticalIndicatorFixedPosition: false,
            //           backgroundColor: Colors.red,
            //           stepsYAxis: 500,
            //           footerHeight: 30.0,
            //         ),
            //       ),
            //       // child: BezierChart(
            //       //   bezierChartScale: BezierChartScale.WEEKLY,
            //       //   xAxisCustomValues: widget.list.cast(),
            //       //   footerValueBuilder: (double value) {
            //       //     return "${(value).toInt()}\ndays";
            //       //   },
            //       //   series: const [
            //       //     BezierLine(
            //       //       label: "m",
            //       //       data: const [
            //       //         DataPoint<double>(value: 10, xAxis: 0),
            //       //         DataPoint<double>(value: 130, xAxis: 5),
            //       //         DataPoint<double>(value: 50, xAxis: 10),
            //       //         DataPoint<double>(value: 150, xAxis: 15),
            //       //         DataPoint<double>(value: 75, xAxis: 20),
            //       //         DataPoint<double>(value: 0, xAxis: 25),
            //       //         DataPoint<double>(value: 5, xAxis: 30),
            //       //         DataPoint<double>(value: 45, xAxis: 35),
            //       //       ],
            //       //     ),
            //       //   ],
            //       //   config: BezierChartConfig(displayYAxis: true,
            //       //   stepsYAxis: 30,
            //       //     footerHeight: 40,
            //       //     verticalIndicatorStrokeWidth: 3.0,
            //       //     verticalIndicatorColor: Colors.black26,
            //       //     showVerticalIndicator: true,
            //       //     verticalIndicatorFixedPosition: false,yAxisTextStyle: TextStyle(fontSize: 12,color: Colors.white,),
            //       //     backgroundGradient: LinearGradient(
            //       //       colors: [
            //       //         // Colors.red[300],
            //       //         // Colors.red[400],
            //       //         // Colors.red[400],
            //       //         // Colors.red[500],
            //       //         // Colors.red,
            //       //         Colors.blue,
            //       //         Colors.blueAccent
            //       //       ],
            //       //       begin: Alignment.topCenter,
            //       //       end: Alignment.bottomCenter,
            //       //     ),
            //       //     snap: false,
            //       //   ),
            //       // ),
            //     ),
            //   ),
            // ),
            (swapcalendar)?Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .99,
                  child: Card(
                      elevation: 12,
                      clipBehavior: Clip.hardEdge,
                      // child: Container(
                      //     height: MediaQuery.of(context).size.height / 2,
                      //     width: MediaQuery.of(context).size.width * 0.9,
                      //     child: BarGraphDemo(
                      //       list: widget.list,
                      //     ))
                          ),
                )) : BarChartSample3(),
          ]),
        ));
  }
}
