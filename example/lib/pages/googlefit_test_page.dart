import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ashva_fitness/ashva_fitness.dart';
import 'dart:convert';

class GoogleFitTest extends StatefulWidget {
  @override
  _GoogleFitTestState createState() => _GoogleFitTestState();
}

class _GoogleFitTestState extends State<GoogleFitTest> {

  bool _isAuthorized = false;
  String _basicHealthString = "";
  String _activityData;
  String _todaysSteps;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await AshvaFitness.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      //_platformVersion = platformVersion;
    });
  }



  _authorizeHealthOrFit() async {
    bool isAuthorized = await AshvaFitness.authorize;
    setState(() {
      _isAuthorized = isAuthorized;
    });
  }

  _getStepsHistoryData() async{
    var getStepsHistoryData = await AshvaFitness.getStepsHistoryData;
    var res = getStepsHistoryData;//json.decode(getStepsHistoryData);
    print("getStepsHistoryData in main example project -- "+ res.toString());
  }

  _getUserBasicHealthData() async{
   /* var basicHealth = await AshvaFitness.getBasicHealthData;
    var caloriesData = await AshvaFitness.getCaloriesData;
    var getDistanceData = await AshvaFitness.getDistanceData;
    var getHeartRateData = await AshvaFitness.getHeartRateData;
    var getMoveInMinData = await AshvaFitness.getMoveInMinData;*/



    
    /*print("getHeartRateData -- "+ getHeartRateData.toString());
    print("getDistanceData -- "+ getDistanceData.toString());
    print("caloriesData -- "+ caloriesData.toString());*/
   /* setState(() {
     // _basicHealthString = basicHealth.toString();
      print('_basicHealthString -- '+_basicHealthString);
    });*/
  }

  _getActivityHealthData() async {
    var steps = await AshvaFitness.getSteps;
    var running = await AshvaFitness.getWalkingAndRunningDistance;
    var cycle = await AshvaFitness.geCyclingDistance;
    var flights = await AshvaFitness.getFlights;
    
    setState(() {
      _todaysSteps = steps.toString();
      _activityData = "steps: $steps\nwalking running: $running\ncycle: $cycle flights: $flights";
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Authorized: $_isAuthorized\n'),
              RaisedButton(child: Text("Authorize Health"), onPressed: (){_authorizeHealthOrFit();
              }),
              RaisedButton(child: Text("Get basic data"), onPressed: _getStepsHistoryData),
              Text('Basic health: $_basicHealthString\n'),
              RaisedButton(child: Text("Get Activity Data"), onPressed: _getActivityHealthData),
              Text('\n$_activityData\n'),
            ],
          ),
        ),
      ),
    );
  }
}
