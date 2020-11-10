import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/screens/chartpage.dart';
import 'package:ashva_fitness_example/screens/individual/barGraphPahe.dart';
import 'package:flutter/material.dart';
import 'package:ashva_fitness_example/constants/const.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

//Start of Added by Mallikarjun
import 'package:ashva_fitness/ashva_fitness.dart';
import 'dart:convert';
//End of Added by Mallikarjun

class HistorySheet extends StatefulWidget {
  HistorySheet({Key key}) : super(key: key);

  @override
  _HistorySheetState createState() => _HistorySheetState();
}

class _HistorySheetState extends State<HistorySheet> {
  TextStyle defaultheaderstyle =
      TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700);
  double width, height;
  var data = ['ALL', 'GLOBALLY', 'BANGALORE', 'MTW'];
  int selectedchip = 0;
  TextStyle defaultchipstyle = TextStyle(color: Color(0xFFB1B1B1));
  TextStyle selectedchipstyle = TextStyle(color: Colors.white);
  String selecteddate, selectedstep;

  Map<String, dynamic> fitData = {
    "Mon": 200,
    "Tue": 300,
    "Wed": 500,
    "Thu": 200,
    "Fri": 300,
    "Sat": 500,
    "Sun": 600
  };

  //send to graph actual data from google fit  {"Sun":"671","Mon":"177","Tue":"306","Wed":"169","Thu":"258","Fri":"534","Sat":"511"}

  //Start of Added by Mallikarjun
  int _totalStepCount = 0;
  var _stepsHistory;

//End of Added by Mallikarjun

  var userlist = [];

  // var userlist = [
  //   {
  //     "steps": 2400,
  //     "date": '12-05-2020',
  //   },
  //   {
  //     "steps": 2400,
  //     "date": '13-05-2020',
  //   },
  //   {
  //     "steps": 2400,
  //     "date": '14-05-2020',
  //   },
  //   {
  //     "steps": 1400,
  //     "date": '15-05-2020',
  //   },
  //   {
  //     "steps": 5400,
  //     "date": '16-05-2020',
  //   },
  //   {
  //     "steps": 4400,
  //     "date": '17-05-2020',
  //   },
  //   {
  //     "steps": 2800,
  //     "date": '18-05-2020',
  //   }
  // ];

  bool isLoading = true;

  setValue(String date, String step) {
    setState(() {
      selecteddate = date;
      selectedstep = step;
    });
  }

  @override
  void initState() {
    super.initState();
    //Added by Mallikarjun for Google Fit

    _getStepsHistoryData();
    //setValue(userlist[0]["date"], _totalStepCount.toString());
    print(fitData);
  }

  _getStepsHistoryData() async {
    await _getActivityHealthData();
    var getStepsHistoryData = await AshvaFitness.getStepsHistoryData;
    var res = getStepsHistoryData; //json.decode(getStepsHistoryData);
    setState(() {
      _stepsHistory = res;
      fitData = jsonDecode(res);

      print("new data------->" + fitData.toString());
    });

    print("new data------->" + fitData.toString());
    getUserList();
    print("getStepsHistoryData in main example project -- " + _stepsHistory);
    var stepsObjsJson = jsonDecode(_stepsHistory);

    print("stepsObjsJson ${stepsObjsJson}");
  }

  _getActivityHealthData() async {
    var steps = await AshvaFitness.getSteps;
    setState(() {
      _totalStepCount = steps.toInt();
      selectedstep = steps.toString();
    });
  }

  Widget _buildList(BuildContext context) {
    int count = 0;
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: height * 0.4,
      child: !isLoading
          ? ListView.builder(
              itemCount: userlist.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "${userlist[index]["date"].toString()}",
                          style: TextStyle(color: Color(0xFFB1B1B1)),
                        ),
                        // Text(
                        //   (++count).toString(),
                        //   style: defaultchipstyle,
                        // ),
                        // SizedBox(
                        //   width: width * 0.03,
                        // ),
                        // ClipOval(
                        //     child: CircleAvatar(
                        //         radius: 30,
                        //         backgroundColor: Color(0xFFF2F2F2),
                        //         child: Icon(
                        //           CustomIcons.steps,
                        //           size: 18,
                        //           color: Colors.orange,
                        //         ))),
                      ],
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "${userlist[index]["steps"].toString()} Steps",
                          style: TextStyle(
                              color: Color(
                                0xFFB1B1B1,
                              ),
                              fontWeight: FontWeight.w500),
                        ),
                        // Text(
                        //   userlist[index]["name"],
                        //   style: TextStyle(
                        //       color: Color(
                        //         0xFFB1B1B1,
                        //       ),
                        //       fontWeight: FontWeight.w500),
                        // ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: <Widget>[
                        //     Icon(
                        //       Icons.calendar_today,
                        //       color: Colors.orange[300],
                        //     ),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Text(
                        //       "${userlist[index]["date"]}",
                        //       style: TextStyle(color: Color(0xFFB1B1B1)),
                        //     ),
                        //     SizedBox(
                        //       width: 4,
                        //     ),
                        //     // Text('|',
                        //     //     style: TextStyle(
                        //     //         color: Color(
                        //     //       0xFFB1B1B1,
                        //     //     ))),
                        //     // RichText(
                        //     //   text: TextSpan(
                        //     //     style: TextStyle(color: Color(0xFFB1B1B1)),
                        //     //     text: userlist[index]["steps"].toString(),
                        //     //     children: <TextSpan>[
                        //     //       TextSpan(
                        //     //         text: ' steps',
                        //     //         style: TextStyle(
                        //     //             fontWeight: FontWeight.w300, fontSize: 16),
                        //     //       ),
                        //     //     ],
                        //     //   ),
                        //     // ),
                        //   ],
                        // )
                      ],
                    ),
                    trailing: ClipOval(
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFF2F2F2),
                            child: Icon(
                              MdiIcons.stepForward,
                              size: 18,
                              color: Constants.darkPrimary,
                            ))),
                    onTap: () {
                      setValue(userlist[index]["date"],
                          userlist[index]["steps"].toString());
                    },
                  ),
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              // color: Constants.darkPrimary,
              gradient: LinearGradient(
                  colors: [Constants.darkPrimary, Constants.lightPrimary])),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          selecteddate == null ? "" : selecteddate,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        // RichText(
                        //   text: TextSpan(
                        //     style: defaultheaderstyle,
                        //     text: "12",
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         text: 'th',
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w300, fontSize: 16),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Text(
                        //   'Rank',
                        //   style: TextStyle(
                        //       fontSize: 18,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w300),
                        // ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 51.5,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Neha Kapoor',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18),
                        ),

                        // Text(
                        //   '#SemiPro',
                        //   style: TextStyle(color: Color(0xFFE8E8E8)),
                        // )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          selectedstep == null ? "" : selectedstep,
                          style: defaultheaderstyle,
                        ),
                        Text(
                          'Steps',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 25,
                top: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: ClipOval(
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Constants.lightAccent,
                          child: Icon(
                            MdiIcons.close,
                            color: Colors.grey.shade300,
                            size: 14,
                          ))),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Center(
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(40),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Color(0xFFF2F2F2),
        //       ),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           ChoiceChip(
        //             padding: EdgeInsets.symmetric(
        //                 vertical: 15, horizontal: width * 0.015),
        //             labelPadding:
        //                 EdgeInsets.symmetric(vertical: height * 0.006),
        //             label: Text('ALL'),
        //             backgroundColor: Color(0xFFF2F2F2),
        //             selected: selectedchip == 0,
        //             labelStyle: (selectedchip == 0)
        //                 ? selectedchipstyle
        //                 : defaultchipstyle,
        //             selectedColor: Constants.darkPrimary,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             onSelected: (value) {
        //               setState(() {
        //                 selectedchip = 0;
        //               });
        //             },
        //             pressElevation: 0,
        //           ),
        //           ChoiceChip(
        //             padding: EdgeInsets.symmetric(
        //                 vertical: 15, horizontal: width * 0.02),
        //             labelStyle: (selectedchip == 1)
        //                 ? selectedchipstyle
        //                 : defaultchipstyle,
        //             labelPadding:
        //                 EdgeInsets.symmetric(vertical: height * 0.006),
        //             label: Text('GLOBALLY'),
        //             backgroundColor: Color(0xFFF2F2F2),
        //             selected: selectedchip == 1,
        //             selectedColor: Constants.darkPrimary,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             onSelected: (value) {
        //               setState(() {
        //                 selectedchip = 1;
        //               });
        //             },
        //             pressElevation: 0,
        //           ),
        //           ChoiceChip(
        //             padding: EdgeInsets.symmetric(
        //                 vertical: 15, horizontal: width * 0.02),
        //             labelPadding:
        //                 EdgeInsets.symmetric(vertical: height * 0.006),
        //             labelStyle: (selectedchip == 2)
        //                 ? selectedchipstyle
        //                 : defaultchipstyle,
        //             label: Text('BANGALORE'),
        //             backgroundColor: Color(0xFFF2F2F2),
        //             selected: selectedchip == 2,
        //             selectedColor: Constants.darkPrimary,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             onSelected: (value) {
        //               setState(() {
        //                 selectedchip = 2;
        //               });
        //             },
        //             pressElevation: 0,
        //           ),
        //           ChoiceChip(
        //             padding: EdgeInsets.symmetric(
        //                 vertical: 15, horizontal: width * 0.02),
        //             labelPadding:
        //                 EdgeInsets.symmetric(vertical: height * 0.006),
        //             labelStyle: (selectedchip == 3)
        //                 ? selectedchipstyle
        //                 : defaultchipstyle,
        //             label: Text('MTW'),
        //             backgroundColor: Color(0xFFF2F2F2),
        //             selected: selectedchip == 3,
        //             selectedColor: Constants.darkPrimary,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             pressElevation: 0,
        //             onSelected: (value) {
        //               setState(() {
        //                 selectedchip = 3;
        //               });
        //             },
        //           ),
        //           ChoiceChip(
        //             padding: EdgeInsets.symmetric(
        //                 vertical: 15, horizontal: width * 0.02),
        //             label: Icon(
        //               CustomIcons.filter,
        //               color: (selectedchip == 4)
        //                   ? Colors.white
        //                   : Color(0xFFB1B1B1),
        //             ),
        //             backgroundColor: Color(0xFFF2F2F2),
        //             selected: selectedchip == 4,
        //             selectedColor: Constants.darkPrimary,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(30),
        //             ),
        //             pressElevation: 0,
        //             onSelected: (value) {
        //               setState(() {
        //                 selectedchip = 4;
        //               });
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.show_chart,
                  color: Constants.darkPrimary,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChartPage(
                          // list: userlist
                          )));
                })
          ],
        ),
        _buildList(context),
      ],
    );
  }

  void getUserList() {
    Map<int, String> weekLookUp = {
      1: "Mon",
      2: "Tue",
      3: "Wed",
      4: "Thu",
      5: "Fri",
      6: "Sat",
      7: "Sun"
    };
    Map<int, String> pastSeven = {};

    for (var i = 0; i < 7; i++) {
      DateTime dateTime = DateTime.now().subtract(Duration(days: i + 1));
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(dateTime);
      String weekDay = DateFormat('EEEE').format(dateTime);
      print(formatted + weekDay + dateTime.weekday.toString());
      pastSeven[dateTime.weekday] = formatted;
    }
    print("past seven ----------------- " + pastSeven.toString());
    List<Map<String, Object>> finalList = List();

    DateTime now = DateTime.now();

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);

    // print(formatted + weekDay + now.weekday.toString());

    // String formattedDate =
    //     '${DateFormat('yyyy-MM-dd').format(now)}\n(${weekLookUp[now.weekday]})';
    String formattedDate = '${DateFormat('yyyy-MM-dd').format(now)}\n(today)';

    var stepObj1 = {
      "steps": _totalStepCount == null ? "0" : _totalStepCount,
      "date": formattedDate,
    };

    finalList.add(stepObj1);
    var stepObj = {
      "steps": fitData[weekLookUp[7]] == null
          ? "0"
          : fitData[weekLookUp[7]].toString(),
      "date": pastSeven[7] + "\n(${weekLookUp[7]})",
    };
    finalList.add(stepObj);

    for (var i = 6; i > 0; i--) {
      print("$i inside loop--> ${fitData[weekLookUp[i]]}");
      var stepObj = {
        "steps": fitData[weekLookUp[i]] == null
            ? "0"
            : fitData[weekLookUp[i]].toString(),
        "date": pastSeven[i] + "\n(${weekLookUp[i]})",
      };

      finalList.add(stepObj);
      insertionSort(finalList);
    }

    print(finalList);
    setState(() {
      userlist = insertionSort(finalList);
      selecteddate = userlist[0]["date"];
      selectedstep = userlist[0]["steps"] != "null"
          ? userlist[0]["steps"].toString()
          : "0";
      isLoading = false;
    });
    print("past seven ----------------- " + pastSeven.toString());
    print("user list is --->" +
        userlist.toString() +
        "final list -------- " +
        finalList.toString());
  }

  void getMaxObj(String d1, String d2) {
    print(DateTime.parse(d1));
    print(DateTime.parse(d2));
    print(DateTime.parse(d1).compareTo(DateTime.parse(d2)));
  }

  List<Map<String, dynamic>> insertionSort(List<Map<String, dynamic>> list) {
    for (int j = 1; j < list.length; j++) {
      Map<String, dynamic> key = list[j];

      int i = j - 1;
      print("---------->" + list[i]['date'].toString().substring(0, 10));
      DateTime d1 =
          DateTime.parse("${list[i]['date'].toString().substring(0, 10)}");
      while (i >= 0 &&
          DateTime.parse(list[i]['date'].toString().substring(0, 10)).compareTo(
                  DateTime.parse(key['date'].toString().substring(0, 10))) <
              0) {
        list[i + 1] = list[i];
        i = i - 1;
        list[i + 1] = key;
      }
    }
    print("after sort-------->" + list.toString());
    return list;
  }
}
