import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ashva_fitness_example/pages/myappbar_widget.dart';
import 'package:ashva_fitness_example/utils/showAlert.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ashva_fitness_example/utils/subscriber_chart.dart';
import 'package:ashva_fitness_example/utils/subscriber_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:ashva_fitness_example/pages/nav_drawer.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'dart:async';
import 'package:ashva_fitness/ashva_fitness.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isAuthorized = false;
  String _basicHealthString = "";
  String _activityData;
  String _todaysSteps;
  int _totalStepCount = 0;
  int _heartPoints = 0;
  var _distanceCovered = 0.0;
  int _moveInMinute = 0;
  int _calories = 0;
  var _customFontSize = 18.0;
  var _stepsHistory;
  var _customFontSizeSubHeadidng = 18.0;
  bool _appAvailability = false;

  List<SubscriberSeries> sortedHistoryData = [];
  final List<SubscriberSeries> historyData = [];

  @override
  initState() {
    super.initState();
    //initPlatformState();

    _checkGoogleFit().then((value) {
      print("_onWillPop $value");
      setState(() {
        _appAvailability = value;
        if (_appAvailability) {
          _getActivityHealthData();
          _getHeartPointsData();
          _getDistanceConveredData();
          _getCaloriesData();
          _getMoveInMinData();
        } else {
          Future.delayed(Duration.zero, () {
            showCloseAlert(context);
          });
        }

      });
    });

//    _getStepsHistoryData();
//    _createHistoryBarChat();
  }

  Future<bool> _checkGoogleFit() async {
    if (await AppAvailability.isAppEnabled("com.google.android.apps.fitness")) {
      print('Continue using app');
      return true;

    } else {
      print('Close app');
      return false;
    }
  }

  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;
    if (Platform.isAndroid) {
      if (await AppAvailability.isAppEnabled(
          "com.google.android.apps.fitness")) {
        print('Continue using app');
        setState(() {
          _appAvailability = true;
        });
      } else {
        setState(() {
          _appAvailability = false;
        });
        print('Close app');
      }
    } else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
      print(await AppAvailability.checkAvailability("calshow://"));
      // Returns: Map<String, String>{app_name: , package_name: calshow://, versionCode: , version_name: }
    }
  }

  _createHistoryBarChat() {
    setState(() {});
  }

  _getHeartPointsData() async {
    var heartPoints = await AshvaFitness.getHeartRateData;
    setState(() {
      _heartPoints = heartPoints.toInt();
    });
  }

  _getDistanceConveredData() async {
    var distanceCovered = await AshvaFitness.getDistanceData;
    setState(() {
      _distanceCovered = distanceCovered / 1000;
      _distanceCovered = num.parse(_distanceCovered.toStringAsFixed(2));
    });
  }

  _getCaloriesData() async {
    var calories = await AshvaFitness.getCaloriesData;
    setState(() {
      _calories = calories.toInt();
    });
  }

  _getMoveInMinData() async {
    var moveInMin = await AshvaFitness.getMoveInMinData;
    setState(() {
      _moveInMinute = moveInMin.toInt();
    });
  }

  _authorizeHealthOrFit() async {
    bool isAuthorized = await AshvaFitness.authorize;
    setState(() {
      _isAuthorized = isAuthorized;
    });
  }

  _getUserBasicHealthData() async {
    var basicHealth = await AshvaFitness.getBasicHealthData;
    setState(() {
      _basicHealthString = basicHealth.toString();
    });
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
      _createHistoryBarChat();
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
        if(stepsObjsJson['$name'] == ""){
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
    //error was here
    // sortedHistoryData = [...todaysHistory, ...historyData.reversed.toList()];
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    if (queryData.size.width < 370) {
      _customFontSize = 14.0;
      _customFontSizeSubHeadidng = 20.0;
    } else if (queryData.size.width > 370 && queryData.size.width < 420) {
      _customFontSize = 16.0;
    } else if (queryData.size.width > 420 && queryData.size.width < 500) {
      _customFontSize = 18.0;
    } else {
      //print('else');
      _customFontSize = 20.0;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: NavDrawer(),
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColor.withAlpha(50),
                  ),
                  child: Image.asset(
                    'assets/img/shoe.png',
                    width: 60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  _totalStepCount.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 80,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '0 Steps'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '9000 Steps'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      LinearPercentIndicator(
                        lineHeight: 8.0,
                        percent: 0.7,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor:
                            Theme.of(context).accentColor.withAlpha(30),
                        progressColor: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        'YOU WALKED'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontFamily: 'Bebas',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$_moveInMinute min today',
                        style: TextStyle(
                          color: Colors.pink[600],
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'DISTANCE',
                              style: TextStyle(
                                fontSize: _customFontSize,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: _distanceCovered.toString(),
                                    style: TextStyle(
                                      fontSize: _customFontSizeSubHeadidng,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' km',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 1.0,
                        color: Colors.grey,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CALORIES',
                              style: TextStyle(
                                fontSize: _customFontSize,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: _calories.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' cal',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 1.0,
                        color: Colors.grey,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'HEART POINTS',
                              style: TextStyle(
                                fontSize: _customFontSize,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: _heartPoints.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' pts',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                /*Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
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
                ),*/
                /*Container(
                  height: 250,
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      StatCard(
                        title: 'Carbs',
                        achieved: 200,
                        total: 350,
                        color: Colors.orange,
                        image: Image.asset('assets/img/bolt.png', width: 20),
                      ),
                      StatCard(
                        title: 'Protien',
                        achieved: 350,
                        total: 300,
                        color: Theme.of(context).primaryColor,
                        image: Image.asset('assets/img/fish.png', width: 20),
                      ),
                      StatCard(
                        title: 'Fats',
                        achieved: 100,
                        total: 200,
                        color: Colors.green,
                        image: Image.asset('assets/img/sausage.png', width: 20),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
