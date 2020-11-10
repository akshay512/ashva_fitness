import 'dart:convert';
import 'package:ashva_fitness_example/constants/padding.dart';
import 'package:ashva_fitness_example/import/badge_icons_icons.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/model/dashBoardModel.dart';
import 'package:ashva_fitness_example/screens/calorieschart.dart';
import 'package:ashva_fitness_example/screens/chartbezier.dart';
import 'package:ashva_fitness_example/screens/chartpage.dart';
import 'package:ashva_fitness_example/screens/distancechart.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/widgets/Facts.dart';
import 'package:ashva_fitness_example/widgets/badgeWidget.dart';
import 'package:ashva_fitness_example/widgets/leaderboardsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ashva_fitness_example/constants/const.dart';
import 'package:intl/intl.dart';
import './leaderboardpage.dart';

//Start of Added by Mallikarjun
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'dart:async';
import 'package:ashva_fitness/ashva_fitness.dart';
import 'dart:io';
import 'package:ashva_fitness_example/utils/subscriber_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ashva_fitness_example/utils/showAlert.dart';
//End of Added by Mallikarjun

class DashBoardScreen extends StatefulWidget {
  static const String routeName = "/dashboard";

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  double width;
  double height;
  bool _isOn = false;
  TextStyle defaulttxtstyle = TextStyle(
    color: Colors.white,
  );
  int globalsteps = 6110;
  DashBoardModel dashBoardModel;
  Timer _timer;

  //Added by Mallikarjun
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
  double fSteps = 0;
  double fCalories = 0;
  bool _appAvailability = false;
  List<SubscriberSeries> sortedHistoryData = [];
  final List<SubscriberSeries> historyData = [];
  List<BadgeWidget> badgeWidgetList = [];
  Map<int, IconData> iconMap = {
    2000: BadgeIcons.medal3,
    4000: BadgeIcons.badge4,
    10000: BadgeIcons.banner8,
    12000: BadgeIcons.goldmedal21
  };

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  initState() {
    super.initState();

    getDashBoard();

    print("corporate login state in dash board" +
        prefs.get('corporate_login').toString());
    //call getDashBoardApi

    //Added by Mallikarjun for Google Fit

    _checkGoogleFit().then((value) {
      print("_onWillPop $value");
      setState(() {
        _appAvailability = value;
        if (_appAvailability) {
          _getDistanceConveredData().then((value) {
            // print("distance------------------------->" + value.toString()));
          });

          _getActivityHealthData()
              .then((steps) => _getCaloriesData().then((calories) {
                    var dateFormate = DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(DateTime.now().toString()));

                    double distance = fSteps * 0.0008;
                    print("got steps and calories---------------->");
                    print(dateFormate +
                        "steps------------->" +
                        fSteps.toString() +
                        "calories------------>" +
                        fCalories.toString() +
                        "distance ----->" +
                        distance.toString());

                    print("api call req body---->" +
                        {
                          "calories": fCalories.round(),
                          "distance": distance,
                          "stepsDateStr": dateFormate.toString(),
                          "totalSteps": fSteps.round()
                        }.toString());
                    postStepData([
                      {
                        "calories": fCalories.round(),
                        "distance": distance,
                        "stepsDateStr": dateFormate.toString(),
                        "totalSteps": fSteps.round()
                      }
                    ]);

                    _getActivityHealthData();
                    _getCaloriesData();
                    print("bedore timer--->");
                    _timer = Timer.periodic(Duration(hours: 1), (timer) {
                      print("timer called ------>");
                      var dateFormate = DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(DateTime.now().toString()));

                      double distance = fSteps * 0.0008;
                      print("got steps and calories---------------->");
                      print(dateFormate +
                          "steps------------->" +
                          fSteps.toString() +
                          "calories------------>" +
                          fCalories.toString() +
                          "distance ----->" +
                          distance.toString());

                      print("api call req body---->" +
                          {
                            "calories": fCalories.round(),
                            "distance": distance,
                            "stepsDateStr": dateFormate.toString(),
                            "totalSteps": fSteps.round()
                          }.toString());
                      postStepData([
                        {
                          "calories": fCalories.round(),
                          "distance": distance,
                          "stepsDateStr": dateFormate.toString(),
                          "totalSteps": fSteps.round()
                        }
                      ]);

                      _getActivityHealthData();
                      _getCaloriesData();
                    });
                  }));

          _getHeartPointsData();

          _getMoveInMinData();
        } else {
          Future.delayed(Duration.zero, () {
            showCloseAlert(context);
          });
        }
      });
    });
    _getStepsHistoryData()
        .then((value) => print("stepHistory--->" + _stepsHistory.toString()));
  }

  //Start of Added by Mallikarjun
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

  Future<double> _getDistanceConveredData() async {
    print("getDistanceCalled here --------->");
    try {
      await AshvaFitness.getDistanceData.then((value) {
        // print("distance got-------------------------------------------->" +
        //     value.toString());
        setState(() {
          _distanceCovered = value / 1000;
          _distanceCovered = num.parse(_distanceCovered.toStringAsFixed(2));
        });
        // print("distance-------------------------------------------->" +
        //     value.toString());
        return value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<double> _getCaloriesData() async {
    var calories = await AshvaFitness.getCaloriesData;
    setState(() {
      _calories = calories.toInt();
      fCalories = calories;
    });
    print("calories-------------------------->" + _calories.toString());

    return calories;
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

  Future<double> _getActivityHealthData() async {
    var steps = await AshvaFitness.getSteps;
    var running = await AshvaFitness.getWalkingAndRunningDistance;
    var cycle = await AshvaFitness.geCyclingDistance;
    var flights = await AshvaFitness.getFlights;

    setState(() {
      _activityData =
          "steps: $steps\nwalking running: $running\ncycle: $cycle flights: $flights";
      _todaysSteps = steps.toString();
      _totalStepCount = steps.toInt();
      fSteps = steps;

      _getStepsHistoryData();
      _createHistoryBarChat();
    });
    print("activity data---------------------->" + _activityData);
    print("steps------------------------------>" + _totalStepCount.toString());

    return steps;
  }

  Future<void> _getStepsHistoryData() async {
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

//End of added by Mallikarjun

  Widget _buildstatcard(BuildContext context, String heading, IconData icon,
      String value, Color color) {
    print(width * 0.25);
    print(height * 0.13);
    return Container(
      width: 102.85714285714286,
      height: 88.8457142857143,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 2.0,
        ),
      ], color: color, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0.0, 0.8),
            child: Container(
              width: 53,
              child: Text(
                heading,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.8, -0.8),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   width = MediaQuery.of(context).size.width;
  //   height = MediaQuery.of(context).size.height;
  //   return Container(
  //     padding: EdgeInsets.only(left: 20, right: 20, top: 70),
  //     decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //       colors: [
  //         Constants.darkPrimary,
  //         Constants.lightPrimary,
  //       ],
  //       begin: FractionalOffset.topLeft,
  //       end: FractionalOffset.bottomRight,
  //     )),
  //     child: ScrollConfiguration(
  //       behavior: MyBehavior(),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: <Widget>[
  //             SizedBox(
  //               height: 0,
  //             ),
  //             // Center(
  //             //   child: Text(
  //             //     'Dashboard',
  //             //     style: TextStyle(
  //             //         color: Colors.white,
  //             //         fontWeight: FontWeight.bold,
  //             //         fontSize: 28),
  //             //   ),
  //             // ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Center(
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.grey,
  //                         offset: Offset(0.0, 1.0), //(x,y)
  //                         blurRadius: 2.0,
  //                       ),
  //                     ],
  //                     color: Constants.lightPrimary,
  //                     borderRadius: BorderRadius.circular(15)),
  //                 width: width * 0.85,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 8),
  //                           child: Icon(
  //                             MdiIcons.shoePrint,
  //                             color: Colors.white,
  //                             size: 25,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 8),
  //                           child: Text(
  //                             '6,00,110',
  //                             style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 40),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 8),
  //                           child: Container(
  //                             width: 100,
  //                             child: Text(
  //                               'Steps achieved globally',
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     Align(
  //                       child: Container(
  //                         padding: EdgeInsets.only(left: 10, right: 10),
  //                         decoration: BoxDecoration(
  //                             border: Border(
  //                                 left: BorderSide(
  //                                     color: Colors.white.withOpacity(0.4)))),
  //                         child: Column(
  //                           children: <Widget>[
  //                             SizedBox(
  //                               height: 5,
  //                             ),
  //                             CircularPercentIndicator(
  //                                 radius: 70.0,
  //                                 lineWidth: 6.0,
  //                                 animation: true,
  //                                 percent: 0.2,
  //                                 header: Column(
  //                                   children: <Widget>[
  //                                     Text(
  //                                       'My contribution',
  //                                       style: defaulttxtstyle,
  //                                     ),
  //                                     SizedBox(
  //                                       height: 10,
  //                                     )
  //                                   ],
  //                                 ),
  //                                 center: Column(
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: <Widget>[
  //                                     Icon(
  //                                       MdiIcons.shoePrint,
  //                                       size: 14,
  //                                       color: Colors.white,
  //                                     ),
  //                                     Text(
  //                                       ((_totalStepCount / globalsteps) * 100)
  //                                           .toString(),
  //                                       style: TextStyle(
  //                                           color: Colors.white, fontSize: 10.0),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 footer: Column(
  //                                   children: <Widget>[
  //                                     SizedBox(
  //                                       height: 5,
  //                                     ),
  //                                     Text(
  //                                       _totalStepCount.toString(),
  //                                       style: TextStyle(
  //                                           fontWeight: FontWeight.bold,
  //                                           fontSize: 24.0,
  //                                           color: Colors.white),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 circularStrokeCap: CircularStrokeCap.butt,
  //                                 progressColor: Colors.white,
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Text(
  //                   'Your statistics',
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 22,
  //                       fontWeight: FontWeight.w600),
  //                 ),
  //                 Container(
  //                   child: Row(
  //                     children: <Widget>[
  //                       Container(
  //                         padding:
  //                             EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(color: Colors.white),
  //                             borderRadius: BorderRadius.circular(20)),
  //                         child: Row(
  //                           children: <Widget>[
  //                             Text(
  //                               'Today',
  //                               style: TextStyle(color: Colors.white),
  //                             ),
  //                             SizedBox(
  //                               width: 10,
  //                             ),
  //                             Icon(
  //                               MdiIcons.calendar,
  //                               color: Colors.white,
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           Navigator.pushNamed(context, '/profilePage');
  //                         },
  //                         child: Icon(
  //                           Icons.share,
  //                           color: Colors.white,
  //                           size: 20,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: <Widget>[
  //                 _buildstatcard(context, "steps taken", MdiIcons.shoePrint,
  //                     _totalStepCount.toString()),
  //                 _buildstatcard(context, "Calories burnt",
  //                     MdiIcons.fire, _calories.toString()),
  //                 _buildstatcard(context, "Distance covered",
  //                       MdiIcons.run, _distanceCovered.toString()),
  //               ],
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Center(
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height * .22,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Container(
  //                       child: Column(
  //                         children: <Widget>[
  //                           Container(
  //                             width: MediaQuery.of(context).size.width * .4,
  //                             height: MediaQuery.of(context).size.height * .1,
  //                             padding: EdgeInsets.all(7),
  //                             decoration: BoxDecoration(
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Colors.grey,
  //                                     offset: Offset(0.0, 1.0), //(x,y)
  //                                     blurRadius: 2.0,
  //                                   ),
  //                                 ],
  //                                 color: Constants.darkPrimary,
  //                                 borderRadius: BorderRadius.circular(15)),
  //                             child: Padding(
  //                               padding:
  //                                   const EdgeInsets.only(bottom: 5.0, left: 5),
  //                               child: Row(
  //                                 children: <Widget>[
  //                                   Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: <Widget>[
  //                                       Text(
  //                                         'Badges earned',
  //                                         style: defaulttxtstyle,
  //                                       ),
  //                                       CircleAvatar(
  //                                         radius: 10,
  //                                         child: Text(
  //                                           '4',
  //                                           style: defaulttxtstyle,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             width: MediaQuery.of(context).size.width * .4,
  //                             height: MediaQuery.of(context).size.height * .1,
  //                             decoration: BoxDecoration(
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Colors.grey,
  //                                     offset: Offset(0.0, 1.0), //(x,y)
  //                                     blurRadius: 2.0,
  //                                   ),
  //                                 ],
  //                                 color: Constants.lightAccent,
  //                                 borderRadius: BorderRadius.circular(15)),
  //                             child: Padding(
  //                                 padding: EdgeInsets.all(5),
  //                                 child: Row(
  //                                   children: <Widget>[
  //                                     CircleAvatar(
  //                                         radius: 15,
  //                                         backgroundColor:
  //                                             Colors.orange.shade400,
  //                                         child: Icon(
  //                                           CustomIcons.medal,
  //                                           color: Colors.white,
  //                                           size: 14,
  //                                         )),
  //                                     SizedBox(
  //                                       width: 5,
  //                                     ),
  //                                     Container(
  //                                         child: Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: <Widget>[
  //                                         Text('Recently earned',
  //                                             style: TextStyle(
  //                                               color: Colors.white,
  //                                               fontSize: 10,
  //                                             )),
  //                                         Text('ProRun',
  //                                             style: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontSize: 16)),
  //                                         Text('20km',
  //                                             style: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontWeight: FontWeight.w300,
  //                                                 fontSize: 8))
  //                                       ],
  //                                     )),
  //                                   ],
  //                                 )),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     InkWell(
  //                       onTap: () {
  //                         showModalBottomSheet<dynamic>(
  //                             isScrollControlled: true,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.vertical(
  //                                   top: Radius.circular(30)),
  //                             ),
  //                             context: context,
  //                             builder: (BuildContext context) {
  //                               return LeaderBoardSheet();
  //                             });
  //                       },
  //                       child: Container(
  //                         width: MediaQuery.of(context).size.width * .43,
  //                         height: MediaQuery.of(context).size.height * .2,
  //                         decoration: BoxDecoration(
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.grey,
  //                                 offset: Offset(0.0, 1.0), //(x,y)
  //                                 blurRadius: 2.0,
  //                               ),
  //                             ],
  //                             color: Constants.lightAccent,
  //                             borderRadius: BorderRadius.circular(15)),
  //                         child: Stack(
  //                           children: <Widget>[
  //                             Align(
  //                                 alignment: Alignment(-.7, -.9),
  //                                 child: Text(
  //                                   'Leaderboards',
  //                                   style: TextStyle(color: Colors.white),
  //                                 )),
  //                             Align(
  //                                 alignment: Alignment(-.1, -0.3),
  //                                 child: Icon(
  //                                   CustomIcons.world_map,
  //                                   size: 40,
  //                                   color: Colors.white,
  //                                 )),
  //                             Align(
  //                               alignment: Alignment(-.8, 0.9),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: <Widget>[
  //                                   RichText(
  //                                     text: TextSpan(
  //                                       style: TextStyle(color: Colors.white),
  //                                       text: '1',
  //                                       children: <TextSpan>[
  //                                         TextSpan(
  //                                           text: 'st',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.w300,
  //                                               fontSize: 10),
  //                                         ),
  //                                         TextSpan(
  //                                           text: ' in Bangalore',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.w300,
  //                                               fontSize: 10),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   RichText(
  //                                     text: TextSpan(
  //                                       style: TextStyle(color: Colors.white),
  //                                       text: '12',
  //                                       children: <TextSpan>[
  //                                         TextSpan(
  //                                           text: 'th',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.w300,
  //                                               fontSize: 10),
  //                                         ),
  //                                         TextSpan(
  //                                           text: ' Globally',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.w300,
  //                                               fontSize: 10),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 70),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Constants.darkPrimary,
          Constants.lightPrimary,
        ],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
      )),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(color: Constants.lightPrimary),
                    width: width * .85,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: width * 0.4,
                              child: Text(
                                'Steps achieved Globally',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              )),
                          dashBoardModel != null
                              ? Text(
                                  dashBoardModel.overAllSteps.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Center(
                                      child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator())),
                                ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: height * .05,
              ),

              Container(
                width: width * .8,
                height: height * .24,
                child: dashBoardModel != null
                    ? Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: width * 0.25,
                              height: height * 0.12,
                              child: LiquidCircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                value: dashBoardModel.overAllSteps == 0 &&
                                        dashBoardModel.totalSteps == 0
                                    ? 0
                                    : ((dashBoardModel.totalSteps /
                                            dashBoardModel.overAllSteps)) *
                                        100,
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                                borderColor: Colors.blue,
                                borderWidth: 4.0,
                                center: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "My Contribution",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        (dashBoardModel.overAllSteps == 0 &&
                                                        dashBoardModel
                                                                .totalSteps ==
                                                            0
                                                    ? 0
                                                    : ((dashBoardModel
                                                                .totalSteps /
                                                            dashBoardModel
                                                                .overAllSteps)) *
                                                        100.toInt())
                                                .toString()
                                                 +
                                            '%',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DistanceChartBezier()));
                                  },
                                  child: SizedBox(
                                    width: width * 0.25,
                                    height: height * 0.12,
                                    child: LiquidCircularProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                      value: 0,
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.green[600].withOpacity(0.5)),
                                      borderColor: Colors.green[400],
                                      borderWidth: 4.0,
                                      center: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "Distance",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${dashBoardModel.distance.toString()}KM',
                                              //                 (((_totalStepCount / globalsteps) * 100).toInt())
                                              //                     .toString()+'%',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * .20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChartBezier()));
                                  },
                                  child: SizedBox(
                                    width: width * 0.25,
                                    height: height * 0.12,
                                    child: LiquidCircularProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                      value: 0,
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.deepPurple.withOpacity(0.5)),
                                      borderColor: Colors.deepPurple[500],
                                      borderWidth: 4.0,
                                      center: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "Steps",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              dashBoardModel.totalSteps
                                                  .toString(),
                                              //                 (((_totalStepCount / globalsteps) * 100).toInt())
                                              //                     .toString()+'%',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CaloryChartBezier()));
                              },
                              child: SizedBox(
                                width: width * 0.25,
                                height: height * 0.12,
                                child: LiquidCircularProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  value: 0,
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.deepOrange.withOpacity(0.5),
                                  ),
                                  borderColor:
                                      Colors.deepOrange.withOpacity(0.5),
                                  borderWidth: 4.0,
                                  center: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Calories",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${dashBoardModel.calories.toString()}',
                                          //                 (((_totalStepCount / globalsteps) * 100).toInt())
                                          //                     .toString()+'%',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(child: CircularProgressIndicator()),
              ),

              // SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget>[
              //     Text(
              //       'Your statistics',
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 22,
              //           fontWeight: FontWeight.w600),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       '(today)',
              //       style: TextStyle(color: Colors.white, fontSize: 16),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         Navigator.pushNamed(context, '/profilePage');
              //       },
              //       child: Icon(
              //         Icons.share,
              //         color: Colors.white,
              //         size: 20,
              //       ),
              //     )

              //     // Container(
              //     //   child: Row(
              //     //     children: <Widget>[
              //     //       Container(
              //     //         padding:
              //     //             EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              //     //         decoration: BoxDecoration(
              //     //             border: Border.all(color: Colors.white),
              //     //             borderRadius: BorderRadius.circular(20)),
              //     //         child: Row(
              //     //           children: <Widget>[
              //     //             Text(
              //     //               '(Today)',
              //     //               style: TextStyle(color: Colors.white),
              //     //             ),
              //     //             SizedBox(
              //     //               width: 10,
              //     //             ),
              //     //             Icon(
              //     //               MdiIcons.calendar,
              //     //               color: Colors.white,
              //     //             )
              //     //           ],
              //     //         ),
              //     //       ),
              //     //       SizedBox(
              //     //         width: 10,
              //     //       ),
              //     //       InkWell(
              //     //         onTap: () {
              //     //           Navigator.pushNamed(context, '/profilePage');
              //     //         },
              //     //         child: Icon(
              //     //           Icons.share,
              //     //           color: Colors.white,
              //     //           size: 20,
              //     //         ),
              //     //       )
              //     //     ],
              //     //   ),
              //     // ),
              //   ],
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: <Widget>[
              //     _buildstatcard(context, "steps", MdiIcons.shoePrint,
              //         _totalStepCount.toString(), Color(0xff003366)),
              //     _buildstatcard(
              //       context,
              //       "Calories",
              //       MdiIcons.fire,
              //       _calories.toString(),
              //       Color(0xffff9900),
              //     ),
              //     _buildstatcard(context, "Distance", MdiIcons.run,
              //         _distanceCovered.toString(), Color(0xff097054)),
              //   ],
              // ),
              SizedBox(
                height: height * .05,
              ),
              dashBoardModel != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: badgeWidgetList.length != 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: badgeWidgetList)
                          : Container(),
                    )
                  : Container(),
              SizedBox(
                height: height * .05,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LeaderBoardPage()));
                  // showModalBottomSheet<dynamic>(
                  //     isScrollControlled: true,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.vertical(
                  //           top: Radius.circular(30)),
                  //     ),
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return LeaderBoardSheet();
                  //     });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    decoration: BoxDecoration(color: Constants.darkPrimary),
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: width * .09),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/Images/leaderboard.png'),
                        Text('How did you feel today ?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
              )
              // Center(
              //   child: Container(
              //     height: MediaQuery.of(context).size.height * .22,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         Container(
              //           child: Column(
              //             children: <Widget>[
              //               Container(
              //                 width: MediaQuery.of(context).size.width * .4,
              //                 height: MediaQuery.of(context).size.height * .1,
              //                 padding: EdgeInsets.all(7),
              //                 decoration: BoxDecoration(
              //                     boxShadow: [
              //                       BoxShadow(
              //                         color: Colors.grey,
              //                         offset: Offset(0.0, 1.0), //(x,y)
              //                         blurRadius: 2.0,
              //                       ),
              //                     ],
              //                     color: Constants.darkPrimary,
              //                     borderRadius: BorderRadius.circular(15)),
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.only(bottom: 5.0, left: 5),
              //                   child: Row(
              //                     children: <Widget>[
              //                       Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: <Widget>[
              //                           Text(
              //                             'Badges earned',
              //                             style: defaulttxtstyle,
              //                           ),
              //                           CircleAvatar(
              //                             radius: 10,
              //                             child: Text(
              //                               '4',
              //                               style: defaulttxtstyle,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         width: 5,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Container(
              //                 width: MediaQuery.of(context).size.width * .4,
              //                 height: MediaQuery.of(context).size.height * .1,
              //                 decoration: BoxDecoration(
              //                     boxShadow: [
              //                       BoxShadow(
              //                         color: Colors.grey,
              //                         offset: Offset(0.0, 1.0), //(x,y)
              //                         blurRadius: 2.0,
              //                       ),
              //                     ],
              //                     color: Constants.lightAccent,
              //                     borderRadius: BorderRadius.circular(15)),
              //                 child: Padding(
              //                     padding: EdgeInsets.all(5),
              //                     child: Row(
              //                       children: <Widget>[
              //                         CircleAvatar(
              //                             radius: 15,
              //                             backgroundColor:
              //                                 Colors.orange.shade400,
              //                             child: Icon(
              //                               CustomIcons.medal,
              //                               color: Colors.white,
              //                               size: 14,
              //                             )),
              //                         SizedBox(
              //                           width: 5,
              //                         ),
              //                         Container(
              //                             child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: <Widget>[
              //                             Text('Recently earned',
              //                                 style: TextStyle(
              //                                   color: Colors.white,
              //                                   fontSize: 10,
              //                                 )),
              //                             Text('ProRun',
              //                                 style: TextStyle(
              //                                     color: Colors.white,
              //                                     fontSize: 16)),
              //                             Text('20km',
              //                                 style: TextStyle(
              //                                     color: Colors.white,
              //                                     fontWeight: FontWeight.w300,
              //                                     fontSize: 8))
              //                           ],
              //                         )),
              //                       ],
              //                     )),
              //               ),
              //             ],
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () {
              //             showModalBottomSheet<dynamic>(
              //                 isScrollControlled: true,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.vertical(
              //                       top: Radius.circular(30)),
              //                 ),
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return LeaderBoardSheet();
              //                 });
              //           },
              //           child: Container(
              //             width: MediaQuery.of(context).size.width * .43,
              //             height: MediaQuery.of(context).size.height * .2,
              //             decoration: BoxDecoration(
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.grey,
              //                     offset: Offset(0.0, 1.0), //(x,y)
              //                     blurRadius: 2.0,
              //                   ),
              //                 ],
              //                 color: Constants.lightAccent,
              //                 borderRadius: BorderRadius.circular(15)),
              //             child: Stack(
              //               children: <Widget>[
              //                 Align(
              //                     alignment: Alignment(-.7, -.9),
              //                     child: Text(
              //                       'Leaderboards',
              //                       style: TextStyle(color: Colors.white),
              //                     )),
              //                 Align(
              //                     alignment: Alignment(-.1, -0.3),
              //                     child: Icon(
              //                       CustomIcons.world_map,
              //                       size: 40,
              //                       color: Colors.white,
              //                     )),
              //                 Align(
              //                   alignment: Alignment(-.8, 0.9),
              //                   child: Column(
              //                     mainAxisSize: MainAxisSize.min,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: <Widget>[
              //                       RichText(
              //                         text: TextSpan(
              //                           style: TextStyle(color: Colors.white),
              //                           text: '1',
              //                           children: <TextSpan>[
              //                             TextSpan(
              //                               text: 'st',
              //                               style: TextStyle(
              //                                   fontWeight: FontWeight.w300,
              //                                   fontSize: 10),
              //                             ),
              //                             TextSpan(
              //                               text: ' in Bangalore',
              //                               style: TextStyle(
              //                                   fontWeight: FontWeight.w300,
              //                                   fontSize: 10),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       RichText(
              //                         text: TextSpan(
              //                           style: TextStyle(color: Colors.white),
              //                           text: '12',
              //                           children: <TextSpan>[
              //                             TextSpan(
              //                               text: 'th',
              //                               style: TextStyle(
              //                                   fontWeight: FontWeight.w300,
              //                                   fontSize: 10),
              //                             ),
              //                             TextSpan(
              //                               text: ' Globally',
              //                               style: TextStyle(
              //                                   fontWeight: FontWeight.w300,
              //                                   fontSize: 10),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void doPostingOfStep() {}

  Future<void> postStepData(List<Map<String, dynamic>> requestBody) async {
    print("postStepDataCalled------>");
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': prefs.get('auth_token').toString()
      };

      String jsonBody = jsonEncode(requestBody);
      print(jsonBody.toString() + "" + uriList['postStepData'].toString());
      final encoding = Encoding.getByName('utf-8');

      Response response = await post(uriList['postStepData'],
          headers: headers, body: jsonBody, encoding: encoding);

      int statusCode = response.statusCode; //yet to handle http exception
      String responseBody = response.body;
      // Response response =
      //     await newHttpPost(uri: uriList['postStepData'], body: requestBody);
      // Map<String, dynamic> responseBody = json.decode(response.body);

      print("response of post step data----------->" + responseBody.toString());
    } catch (e) {
      print(e);
    }
    print("loading done for login up");
  }

  Future<void> getDashBoard() async {
    Map<String, dynamic> requestBody = {};
    Response response =
        await newHttpPostAuth(uri: uriList['getDashBoardDetails'], body: {});
    setState(() {
      dashBoardModel = DashBoardModel.fromJson(json.decode(response.body));
      dashBoardModel.badgeInfoList.forEach((item) {
        badgeWidgetList.add(BadgeWidget(
          count: item.numberOfBadges,
          distance: item.distance,
          badge: iconMap[item.distance],
        ));
      });
    });

    print("loading done ! inside getDashBoard");
  }
}

enum ConfirmAction1 { CANCEL, SUBMIT }

Future<ConfirmAction1> _asyncConfirmDialog1(BuildContext context,
    {String bedNo, bedId, propertyID}) async {
  return showDialog<ConfirmAction1>(
    context: context,
    barrierDismissible: false,
  );
}
