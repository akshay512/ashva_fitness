import 'package:ashva_fitness_example/utils/showAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fit_kit/fit_kit.dart';
import 'dart:io';

//import 'package:health_flutter_app/flutter_health_fit.dart';
import 'package:launch_review/launch_review.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _activityData;

  bool _appAvailability = false;

  @override
  initState() {
    print(" LandingPage initState");
    super.initState();
    //print('  _onWillPop() ${ _onWillPop()}');

    _checkGoogleFit().then((value) {
      print("_checkGoogleFit $value");
      setState(() {
        _appAvailability = value;
        if (_appAvailability) {
          read();
          readAll();
        } else {
          Future.delayed(Duration.zero, () {
            showGoogleFitAlert(context);
          });
        }

      });
    });


    //getApps();
   // print('mallikarjun appAvailability $_appAvailability');

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

//  Future<bool> _onBackPressed() {
//    if (true) {
//
//      return true;
//    } else {
//      return false;
//    }
//  }

  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;
    //bool returnedVal = false;
    if (Platform.isAndroid) {
      //_installedApps = await AppAvailability.getInstalledApps();
      // Returns: true
      print(await AppAvailability.isAppEnabled(
          "com.google.android.apps.fitness"));

      if (await AppAvailability.isAppEnabled(
          "com.google.android.apps.fitness")) {
        print('Continue using app');
        setState(() {
          _appAvailability = true;
        });
      } else {
        //_showGoogleFitAlert(context);
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

  void read() async {
    final results = await FitKit.read(
      DataType.STEP_COUNT,
      dateFrom: DateTime.now().subtract(Duration(days: 1)),
      dateTo: DateTime.now(),
    );

    //print("result read() STEP_COUNT $results");
    //_getActivityHealthData();
  }

  void readLast() async {
    final result = await FitKit.readLast(DataType.HEIGHT);
  }

  void readAll() async {
    if (await FitKit.requestPermissions(DataType.values)) {
      for (DataType type in DataType.values) {
        final results = await FitKit.read(
          type,
          dateFrom: DateTime.now().subtract(Duration(days: 5)),
          dateTo: DateTime.now(),
        );

        print("readAll $results");
      }
    }
  }

  Widget _showLogoImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Center(
        child: Image.asset(
          "assets/img/source.gif",
          width: 250,
          height: 150,
        ),
      ),
    );
  }

  Widget _showWelcmeText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Text(
          "Welcome to",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _showCreateAccountButton() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: RaisedButton(
        child: Text(
          "Create your Account",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        elevation: 8.0,
        color: Colors.pink[600],
        onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  Widget _showHaveAccountText() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        "Already haev an account?",
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _showSignInButon() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: FlatButton(
        child: Text(
          "Sign in here",
          style: TextStyle(
            color: Colors.green,
            fontSize: 18,
          ),
        ),
        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
      decoration: new BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        image: new DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.7), BlendMode.dstATop),
          image: new AssetImage(
            'assets/img/bg.jpg',
          ),
        ),
      ),
//      decoration: BoxDecoration(
//        image: DecorationImage(
//            image: AssetImage('assets/img/bg.jpg'), fit: BoxFit.fitHeight),
//      ),
//      decoration: new BoxDecoration(
//
//        image: new DecorationImage(
//          image: new AssetImage("assets/img/bg.jpg"),
//          fit: BoxFit.fill,
//        ),
//      ),
      child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: <Widget>[
              _showWelcmeText(),
              _showLogoImage(),
              _showCreateAccountButton(),
              _showHaveAccountText(),
              _showSignInButon()
            ],
          ),
        ),
      ),
    ));
  }
}
