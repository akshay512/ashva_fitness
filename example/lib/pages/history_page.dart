import 'package:ashva_fitness_example/pages/myappbar_widget.dart';
import 'package:ashva_fitness_example/pages/nav_drawer.dart';
import 'package:ashva_fitness_example/utils/subscriber_chart.dart';
import 'package:ashva_fitness_example/utils/subscriber_series.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:ashva_fitness/ashva_fitness.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<SubscriberSeries> sortedHistoryData = [];
  final List<SubscriberSeries> historyData = [];
  int _totalStepCount = 0;
  String _activityData;
  String _todaysSteps;
  var _stepsHistory;

  TextEditingController startDateInputController;
  TextEditingController endDateInputController;
  DateTime _startDate;
  DateTime _endDate;

  DateTime _selectedDate = DateTime.now();
  DateTime _pastWeek = DateTime.now().subtract(Duration(days: 7));

  //_endDate = DateTime.now().subtract(Duration(days: 7));
//  void getWeek(){
//    DateTime pastWeek = DateTime.now().subtract(Duration(days: 7));
//    print('Recent pastMonth $pastWeek');
//  }
  @override
  initState() {
    super.initState();
    print('HistoryPage initState()');
    _getActivityHealthData();
    //getWeek();
  }

  _getActivityHealthData() async {
    var steps = await AshvaFitness.getSteps;
    var running = await AshvaFitness.getWalkingAndRunningDistance;
    var cycle = await AshvaFitness.geCyclingDistance;
    var flights = await AshvaFitness.getFlights;

    setState(() {
      _activityData =
          "steps: $steps\nwalking running: $running\ncycle: $cycle flights: $flights";
      _todaysSteps = steps.toString();
      _totalStepCount = steps.toInt();
      _getStepsHistoryData();
    });
  }

  _getStepsHistoryData() async {
    var getStepsHistoryData = await AshvaFitness.getStepsHistoryData;
    var res = getStepsHistoryData; //json.decode(getStepsHistoryData);
    setState(() {
      _stepsHistory = res;
    });
    print("getStepsHistoryData in main example project -- " + res);
    var stepsObjsJson = jsonDecode(_stepsHistory);

    print("_totalStepCount $_totalStepCount");
    int k = 0;
    final List<SubscriberSeries> todaysHistory = [];
    for (final name in stepsObjsJson.keys) {
      if (k == 0) {
        todaysHistory.add(SubscriberSeries(
          year: name,
          subscribers: _totalStepCount,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        ));
        //return;
        k++;
      }
    }

    //print(todaysHistory);
    int i = 0;
    for (final name in stepsObjsJson.keys) {
      if (i > 0) {
        if (stepsObjsJson['$name'] == "") {
          print('Value is zero');
          stepsObjsJson['$name'] = "0";
        }
        historyData.add(SubscriberSeries(
          year: name,
          subscribers: int.parse(stepsObjsJson['$name']),
          barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        ));
      }
      i++;
    }
    //print(historyData);
    sortedHistoryData = [...todaysHistory, ...historyData.reversed.toList()];
  }

  void _callDatePicker() async {
    var order = await getDate();

    if(order != null){
      setState(() {
        _selectedDate = order;
        _pastWeek = _selectedDate.subtract(Duration(days: 7));
        print('_pastWeek - $_pastWeek');
        print('_selectedDate - $_selectedDate');
      });
    }
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.pink[600],
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: NavDrawer(),
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 15, 25, 25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //startDateInput,
                  //endDateInput,
//                  Divider(
//                    height: 10,
//                    color: Colors.grey[300],
//                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'WEEKLY PROGRESS',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24,
                          fontFamily: 'Bebas',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //HistoryChart(_stepsHistory),
                      SubscriberChart(
                        data: sortedHistoryData,
                      )
                    ],
                  ),

                  Divider(
                    height: 10,
                    color: Colors.grey[300],
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Date Range",
                      style: TextStyle(fontSize: 14, color: Colors.pink[600]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Choose date');
                      _callDatePicker();
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          "From",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Spacer(),
                        //Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "${_selectedDate.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  print("onTap dateInput end date");
                                  //_showStartDatePicker();
                                },
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.pink[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.grey[400],
                  ),

                  Row(
                    children: <Widget>[
                      Text(
                        "To",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Spacer(),
                      //Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "${_pastWeek.toLocal()}".split(' ')[0],
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: () {
                                print("onTap dateInput end date");
                                //_showStartDatePicker();
                              },
                              child: Icon(
                                Icons.date_range,
                                color: Colors.pink[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
