import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ashva_fitness_example/pages/myappbar_widget.dart';
import 'package:ashva_fitness_example/pages/appbar_widget.dart';
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
      backgroundColor: Colors.pink[600],
      drawer: NavDrawer(),
      appBar: showAppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 300,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.pink,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        //leading: Icon(Icons.album, size: 70),
                        title: Text('Heart Shaker', style: TextStyle(color: Colors.white)),
                        subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
                      ),

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
