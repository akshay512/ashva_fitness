import 'package:ashva_fitness_example/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../constants/staticText.dart';
import '../constants/staticText.dart';
import '../state/agreebtnstate.dart';

//Start of Added By Mallikarjun for google fit autherization
import 'package:fit_kit/fit_kit.dart';
import 'dart:io';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:ashva_fitness_example/utils/showAlert.dart';
//End of added by Mallikarjun

class SelectionPage extends StatelessWidget {
  static const String routeName = "/selectionpage";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AgreeCheckboxState>.value(
            value: AgreeCheckboxState())
      ],
      child: SelectionPageBody(),
    );
  }
}

class SelectionPageBody extends StatefulWidget {
  SelectionPageBody({Key key}) : super(key: key);

  @override
  _SelectionPageBodyState createState() => _SelectionPageBodyState();
}

class _SelectionPageBodyState extends State<SelectionPageBody> {
  double width, height;

  //Start of Added By Mallikarjun
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
//End of added by Mallikarjun

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AgreeCheckboxState>(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Ashva',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:
            EdgeInsets.only(top: 80, left: width * 0.05, right: width * 0.05),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Constants.darkPrimary, Constants.lightPrimary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: 'main-logo',
                    child: ShapeOfView(
                      width: width * 0.35,
                      height: height * 0.2,
                      shape: CircleShape(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .2,
                        child: Image.asset('assets/Images/carrot.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .5,
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.3,
                                  vertical: height * 0.02),
                              onPressed: () {
                                //get in as corporate
                                Navigator.pushNamed(context, '/signUpPage');
                              },
                              color: Constants.darkPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                StaticText.buttontext["corporateLoginButton"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: height * .1,
                              child: Center(
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.3,
                                  vertical: height * 0.02),
                              onPressed: () {
                                Navigator.pushNamed(context, '/aboutUs');
                              },
                              color: Constants.darkPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                StaticText.buttontext["individualLoginButton"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
