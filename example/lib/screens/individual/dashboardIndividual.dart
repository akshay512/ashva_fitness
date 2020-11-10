import 'dart:convert';

import 'package:ashva_fitness_example/constants/padding.dart';
import 'package:ashva_fitness_example/import/badge_icons_icons.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/screens/calorieschart.dart';
import 'package:ashva_fitness_example/screens/chartbezier.dart';
import 'package:ashva_fitness_example/screens/distancechart.dart';
import 'package:ashva_fitness_example/screens/individual/barchartnew.dart';
import 'package:ashva_fitness_example/screens/individual/historysheetIndividual.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/widgets/Facts.dart';
import 'package:ashva_fitness_example/widgets/leaderboardsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ashva_fitness_example/constants/const.dart';

//Start of Added by Mallikarjun
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'dart:async';
import 'package:ashva_fitness/ashva_fitness.dart';
import 'dart:io';
import 'package:ashva_fitness_example/utils/subscriber_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ashva_fitness_example/utils/showAlert.dart';
//End of Added by Mallikarjun

class DashBoardScreenIndividual extends StatefulWidget {
  static const String routeName = "/dashboardIndividual";

  @override
  _DashBoardScreenIndividualState createState() =>
      _DashBoardScreenIndividualState();
}

class _DashBoardScreenIndividualState extends State<DashBoardScreenIndividual> {
  double width;
  double height;
  bool _isOn = false;
  TextStyle defaulttxtstyle = TextStyle(
    color: Colors.white,
  );

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
  bool _appAvailability = false;
  List<SubscriberSeries> sortedHistoryData = [];
  final List<SubscriberSeries> historyData = [];

  @override
  initState() {
    super.initState();
    print("corporate login state in dash board" +
        prefs.get('corporate_login').toString());
    //call getDashBoardApi

    //Added by Mallikarjun for Google Fit
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

//End of added by Mallikarjun

  Widget _buildstatcard(
      BuildContext context, String heading, IconData icon, String value) {
    return Container(
      width: width * 0.25,
      height: height * 0.13,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
          color: Constants.lightPrimary,
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(-0.8, -0.8),
            child: Container(
              width: 40,
              child: Text(
                heading,
                style: TextStyle(color: Colors.white, fontSize: 10),
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
            alignment: Alignment.bottomCenter,
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
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
                              'Steps achieved Overall',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            )),
                        Text(
                          '10,110',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Text(
            //       'Your statistics',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 22,
            //           fontWeight: FontWeight.w600),
            //     ),
            //     Container(
            //       child: Row(
            //         children: <Widget>[
            //           Container(
            //             padding:
            //                 EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            //             decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.white),
            //                 borderRadius: BorderRadius.circular(20)),
            //             child: Row(
            //               children: <Widget>[
            //                 Text(
            //                   'Today',
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 SizedBox(
            //                   width: 10,
            //                 ),
            //                 Icon(
            //                   MdiIcons.calendar,
            //                   color: Colors.white,
            //                 )
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Navigator.pushNamed(context, '/profilePage');
            //             },
            //             child: Icon(
            //               Icons.share,
            //               color: Colors.white,
            //               size: 20,
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: width * .8,
              height: height * .24,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: width * 0.25,
                      height: height * 0.12,
                      child: LiquidCircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        value: 0.4,
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
                                '40%',
                                //                 (((_totalStepCount / globalsteps) * 100).toInt())
                                //                     .toString()+'%',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DistanceChartBezier()));
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
                                padding: EdgeInsets.symmetric(horizontal: 8),
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
                                      '1.2KM',
                                      //                 (((_totalStepCount / globalsteps) * 100).toInt())
                                      //                     .toString()+'%',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChartBezier()));
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
                                padding: EdgeInsets.symmetric(horizontal: 8),
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
                                      '2540',
                                      //                 (((_totalStepCount / globalsteps) * 100).toInt())
                                      //                     .toString()+'%',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
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
                          valueColor:
                              AlwaysStoppedAnimation(Colors.transparent),
                          borderColor: Colors.deepOrange.withOpacity(0.5),
                          borderWidth: 4.0,
                          center: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
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
                                  '2000',
                                  //                 (((_totalStepCount / globalsteps) * 100).toInt())
                                  //                     .toString()+'%',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BarChartSample3())),
            //             child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: <Widget>[
            //       _buildstatcard(context, "steps taken", MdiIcons.shoePrint,
            //           _totalStepCount.toString()),
            //       _buildstatcard(context, "Calories burnt", MdiIcons.fire,
            //           _calories.toString()),
            //       _buildstatcard(context, "Distance covered", MdiIcons.run,
            //           _distanceCovered.toString()),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: height * 0.05,
            ),
            RatingBar(
              initialRating: 5,
              itemSize: 60,
              itemCount: 5,
              ignoreGestures: true,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('2',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(
                          BadgeIcons.medal3,
                          color: Colors.white,
                        ),
                        Text('2k',
                            style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    );
                  case 1:
                    return Column(
                      children: <Widget>[
                        Text('2',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(
                          BadgeIcons.badge4,
                          color: Colors.white,
                        ),
                        Text('4k',
                            style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    );
                  case 2:
                    return Column(
                      children: <Widget>[
                        Text('10',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(
                          BadgeIcons.banner8,
                          color: Colors.white,
                        ),
                        Text('8k',
                            style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    );
                  case 3:
                    return Column(
                      children: <Widget>[
                        Text('7',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(
                          BadgeIcons.medal6,
                          color: Colors.white,
                        ),
                        Text('10k',
                            style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    );
                  case 4:
                    return Column(
                      children: <Widget>[
                        Text('1',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(
                          BadgeIcons.goldmedal21,
                          color: Colors.white,
                        ),
                        Text('12k',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600))
                      ],
                    );
                }
              },
              onRatingUpdate: (rating) {
                // if (rating == 1) {
                //   setState(() {
                //     feedText = "OK";
                //     goodFeed = false;
                //   });
                // }
                // if (rating == 2) {
                //   setState(() {
                //     feedText = "GOOD";
                //     goodFeed = true;
                //   });
                // }
                // if (rating == 3) {
                //   setState(() {
                //     feedText = "VERY GOOD";
                //     goodFeed = true;
                //   });
                // }
                // if (rating == 4) {
                //   setState(() {
                //     feedText = "EXCELLENT";
                //     goodFeed = true;
                //   });
                // }
                // print(rating);
              },
            ),
            SizedBox(
              height: height * .05,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return HistorySheet();
                    });
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
                      Icon(
                        Icons.history,
                        size: 40,
                        color: Colors.grey.shade200,
                      ),
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
            //                               style: TextStyle(fontSize: 13),
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
            //                             backgroundColor: Colors.orange.shade400,
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
            //                   return HistorySheet();
            //                 });
            //           },
            //           child: Container(
            //             height: height * 0.2,
            //             width: MediaQuery.of(context).size.width * .43,
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
            //                     alignment: Alignment(0, -.9),
            //                     child: Text(
            //                       'History',
            //                       style: TextStyle(
            //                           color: Colors.white, fontSize: 20),
            //                     )),
            //                 Align(
            //                     alignment: Alignment(-.1, 0.2),
            //                     child: Icon(
            //                       Icons.history,
            //                       size: 40,
            //                       color: Colors.grey.shade200,
            //                     )),
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
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(
  //           height: 30,
  //         ),
  //         // Center(
  //         //   child: Text(
  //         //     'Dashboard',
  //         //     style: TextStyle(
  //         //         color: Colors.white,
  //         //         fontWeight: FontWeight.bold,
  //         //         fontSize: 28),
  //         //   ),
  //         // ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         // Center(
  //         //   child: Container(
  //         //     decoration: BoxDecoration(
  //         //         boxShadow: [
  //         //           BoxShadow(
  //         //             color: Colors.grey,
  //         //             offset: Offset(0.0, 1.0), //(x,y)
  //         //             blurRadius: 2.0,
  //         //           ),
  //         //         ],
  //         //         color: Constants.lightPrimary,
  //         //         borderRadius: BorderRadius.circular(15)),
  //         //     width: width * 0.85,
  //         //     child: Row(
  //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         //       children: <Widget>[
  //         //         Column(
  //         //           mainAxisSize: MainAxisSize.min,
  //         //           crossAxisAlignment: CrossAxisAlignment.start,
  //         //           children: <Widget>[
  //         //             Padding(
  //         //               padding: const EdgeInsets.only(left: 8),
  //         //               child: Icon(
  //         //                 CustomIcons.steps,
  //         //                 color: Colors.white,
  //         //               ),
  //         //             ),
  //         //             SizedBox(
  //         //               height: 10,
  //         //             ),
  //         //             Padding(
  //         //               padding: const EdgeInsets.only(left: 8),
  //         //               child: Text(
  //         //                 '6,00,110',
  //         //                 style: TextStyle(
  //         //                     color: Colors.white,
  //         //                     fontWeight: FontWeight.bold,
  //         //                     fontSize: 40),
  //         //               ),
  //         //             ),
  //         //             SizedBox(
  //         //               height: 10,
  //         //             ),
  //         //             Padding(
  //         //               padding: const EdgeInsets.only(left: 8),
  //         //               child: Container(
  //         //                 width: 100,
  //         //                 child: Text(
  //         //                   'Steps achieved globally',
  //         //                   style: TextStyle(
  //         //                     color: Colors.white,
  //         //                   ),
  //         //                 ),
  //         //               ),
  //         //             )
  //         //           ],
  //         //         ),
  //         //         Align(
  //         //           child: Container(
  //         //             padding: EdgeInsets.only(left: 10, right: 10),
  //         //             decoration: BoxDecoration(
  //         //                 border: Border(
  //         //                     left: BorderSide(
  //         //                         color: Colors.white.withOpacity(0.4)))),
  //         //             child: Column(
  //         //               children: <Widget>[
  //         //                 SizedBox(
  //         //                   height: 5,
  //         //                 ),
  //         //                 CircularPercentIndicator(
  //         //                   radius: 70.0,
  //         //                   lineWidth: 6.0,
  //         //                   animation: true,
  //         //                   percent: 0.2,
  //         //                   header: Column(
  //         //                     children: <Widget>[
  //         //                       Text(
  //         //                         'My contribution',
  //         //                         style: defaulttxtstyle,
  //         //                       ),
  //         //                       SizedBox(
  //         //                         height: 10,
  //         //                       )
  //         //                     ],
  //         //                   ),
  //         //                   center: Column(
  //         //                     mainAxisSize: MainAxisSize.min,
  //         //                     children: <Widget>[
  //         //                       Icon(
  //         //                         CustomIcons.steps,
  //         //                         size: 14,
  //         //                         color: Colors.white,
  //         //                       ),
  //         //                       Text(
  //         //                         "2%",
  //         //                         style: TextStyle(
  //         //                             color: Colors.white, fontSize: 10.0),
  //         //                       ),
  //         //                     ],
  //         //                   ),
  //         //                   footer: Column(
  //         //                     children: <Widget>[
  //         //                       SizedBox(
  //         //                         height: 5,
  //         //                       ),
  //         //                       Text(
  //         //                         "12,002",
  //         //                         style: TextStyle(
  //         //                             fontWeight: FontWeight.bold,
  //         //                             fontSize: 24.0,
  //         //                             color: Colors.white),
  //         //                       ),
  //         //                     ],
  //         //                   ),
  //         //                   circularStrokeCap: CircularStrokeCap.butt,
  //         //                   progressColor: Colors.white,
  //         //                 ),
  //         //               ],
  //         //             ),
  //         //           ),
  //         //         )
  //         //       ],
  //         //     ),
  //         //   ),
  //         // ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Text(
  //               'Your statistics',
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //             Container(
  //               child: Row(
  //                 children: <Widget>[
  //                   Container(
  //                     padding:
  //                         EdgeInsets.symmetric(vertical: 5, horizontal: 15),
  //                     decoration: BoxDecoration(
  //                         border: Border.all(color: Colors.white),
  //                         borderRadius: BorderRadius.circular(20)),
  //                     child: Row(
  //                       children: <Widget>[
  //                         Text(
  //                           'Today',
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Icon(
  //                           MdiIcons.calendar,
  //                           color: Colors.white,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.pushNamed(context, '/profilePage');
  //                     },
  //                     child: Icon(
  //                       Icons.share,
  //                       color: Colors.white,
  //                       size: 20,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 15,
  //         ),
  //         InkWell(
  //           onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BarChartSample3())),
  //                     child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: <Widget>[
  //               _buildstatcard(context, "steps taken", MdiIcons.shoePrint,
  //                   _totalStepCount.toString()),
  //               _buildstatcard(context, "Calories burnt", MdiIcons.fire,
  //                   _calories.toString()),
  //               _buildstatcard(context, "Distance covered", MdiIcons.run,
  //                   _distanceCovered.toString()),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: height * 0.09,
  //         ),
  //         Center(
  //           child: Container(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Container(
  //                   child: Column(
  //                     children: <Widget>[
  //                       Container(
  //                         width: MediaQuery.of(context).size.width * .4,
  //                         height: MediaQuery.of(context).size.height * .1,
  //                         padding: EdgeInsets.all(7),
  //                         decoration: BoxDecoration(
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.grey,
  //                                 offset: Offset(0.0, 1.0), //(x,y)
  //                                 blurRadius: 2.0,
  //                               ),
  //                             ],
  //                             color: Constants.darkPrimary,
  //                             borderRadius: BorderRadius.circular(15)),
  //                         child: Padding(
  //                           padding:
  //                               const EdgeInsets.only(bottom: 5.0, left: 5),
  //                           child: Row(
  //                             children: <Widget>[
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     'Badges earned',
  //                                     style: defaulttxtstyle,
  //                                   ),
  //                                   CircleAvatar(
  //                                     radius: 10,
  //                                     child: Text(
  //                                       '4',
  //                                       style: TextStyle(fontSize: 13),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               SizedBox(
  //                                 width: 5,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Container(
  //                         width: MediaQuery.of(context).size.width * .4,
  //                         height: MediaQuery.of(context).size.height * .1,
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
  //                         child: Padding(
  //                             padding: EdgeInsets.all(5),
  //                             child: Row(
  //                               children: <Widget>[
  //                                 CircleAvatar(
  //                                     radius: 15,
  //                                     backgroundColor: Colors.orange.shade400,
  //                                     child: Icon(
  //                                       CustomIcons.medal,
  //                                       color: Colors.white,
  //                                       size: 14,
  //                                     )),
  //                                 SizedBox(
  //                                   width: 5,
  //                                 ),
  //                                 Container(
  //                                     child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: <Widget>[
  //                                     Text('Recently earned',
  //                                         style: TextStyle(
  //                                           color: Colors.white,
  //                                           fontSize: 10,
  //                                         )),
  //                                     Text('ProRun',
  //                                         style: TextStyle(
  //                                             color: Colors.white,
  //                                             fontSize: 16)),
  //                                     Text('20km',
  //                                         style: TextStyle(
  //                                             color: Colors.white,
  //                                             fontWeight: FontWeight.w300,
  //                                             fontSize: 8))
  //                                   ],
  //                                 )),
  //                               ],
  //                             )),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     showModalBottomSheet<dynamic>(
  //                         isScrollControlled: true,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius:
  //                               BorderRadius.vertical(top: Radius.circular(30)),
  //                         ),
  //                         context: context,
  //                         builder: (BuildContext context) {
  //                           return HistorySheet();
  //                         });
  //                   },
  //                   child: Container(
  //                     height: height * 0.2,
  //                     width: MediaQuery.of(context).size.width * .43,
  //                     decoration: BoxDecoration(
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey,
  //                             offset: Offset(0.0, 1.0), //(x,y)
  //                             blurRadius: 2.0,
  //                           ),
  //                         ],
  //                         color: Constants.lightAccent,
  //                         borderRadius: BorderRadius.circular(15)),
  //                     child: Stack(
  //                       children: <Widget>[
  //                         Align(
  //                             alignment: Alignment(0, -.9),
  //                             child: Text(
  //                               'History',
  //                               style: TextStyle(
  //                                   color: Colors.white, fontSize: 20),
  //                             )),
  //                         Align(
  //                             alignment: Alignment(-.1, 0.2),
  //                             child: Icon(
  //                               Icons.history,
  //                               size: 40,
  //                               color: Colors.grey.shade200,
  //                             )),
  //                         // Align(
  //                         //   alignment: Alignment(-.8, 0.9),
  //                         //   child: Column(
  //                         //     mainAxisSize: MainAxisSize.min,
  //                         //     crossAxisAlignment: CrossAxisAlignment.start,
  //                         //     children: <Widget>[
  //                         //       RichText(
  //                         //         text: TextSpan(
  //                         //           style: TextStyle(color: Colors.white),
  //                         //           text: '1',
  //                         //           children: <TextSpan>[
  //                         //             TextSpan(
  //                         //               text: 'st',
  //                         //               style: TextStyle(
  //                         //                   fontWeight: FontWeight.w300,
  //                         //                   fontSize: 10),
  //                         //             ),
  //                         //             TextSpan(
  //                         //               text: ' in Bangalore',
  //                         //               style: TextStyle(
  //                         //                   fontWeight: FontWeight.w300,
  //                         //                   fontSize: 10),
  //                         //             ),
  //                         //           ],
  //                         //         ),
  //                         //       ),
  //                         //       RichText(
  //                         //         text: TextSpan(
  //                         //           style: TextStyle(color: Colors.white),
  //                         //           text: '12',
  //                         //           children: <TextSpan>[
  //                         //             TextSpan(
  //                         //               text: 'th',
  //                         //               style: TextStyle(
  //                         //                   fontWeight: FontWeight.w300,
  //                         //                   fontSize: 10),
  //                         //             ),
  //                         //             TextSpan(
  //                         //               text: ' Globally',
  //                         //               style: TextStyle(
  //                         //                   fontWeight: FontWeight.w300,
  //                         //                   fontSize: 10),
  //                         //             ),
  //                         //           ],
  //                         //         ),
  //                         //       ),
  //                         //     ],
  //                         //   ),
  //                         // )
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<void> getDashBoard() async {
    Map<String, dynamic> requestBody = {};
    Response response =
        await newHttpPost(uri: uriList['homePage'], body: requestBody);
    // dashBoard = DashBoard.fromJson(json.decode(responseBody));
    setState(() {
      // dBoard = dashBoard;
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
