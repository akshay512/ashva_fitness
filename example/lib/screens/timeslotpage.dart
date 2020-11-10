import 'dart:convert';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/model/event.dart';
import 'package:ashva_fitness_example/model/liveSEssionModel.dart';
import 'package:ashva_fitness_example/pages/liveTrainingLinkPage.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/widgets/liveTrainingTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeSlotPage extends StatefulWidget {
  @override
  _TimeSlotPageState createState() => _TimeSlotPageState();
}

class _TimeSlotPageState extends State<TimeSlotPage> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events = new Map();
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  String _selectedDate;
  DateTime _selectedDay;
  double width, height;
  bool isLoading = true;
  LiveSessionModel liveSessionModel;
  List<Widget> trainingTiles;
  final f = new DateFormat('dd-MM-yyyy');
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedDate = _selectedDay.day.toString() +
        '-' +
        _selectedDay.month.toString() +
        '-' +
        _selectedDay.year.toString();

    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];

    print("selected date--->" + f.format(_selectedDay));
    // getAllSessions(f.format(_selectedDay));
    getAllSessions('22-04-2020');
    // initPrefs();
  }

  // initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _events = Map<DateTime, List<dynamic>>.from(
  //         decodeMap(json.decode(prefs.get('events') ?? '{}')));
  //   });
  // }

  // Encode Date Time Helper Method
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  // decode Date Time Helper Method
  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    //  dp.DatePickerStyles styles = dp.DatePickerRangeStyles(
    //     selectedDateStyle: ,
    //     selectedSingleDateDecoration: BoxDecoration(
    //         color: selectedSingleDateDecorationColor, shape: BoxShape.circle));

    return Container(
      padding: EdgeInsets.only(top: 80.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Constants.lightPrimary, Constants.darkPrimary],
        begin: Alignment.bottomCenter,
      )),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Constants.darkPrimary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: TableCalendar(
              startDay: DateTime.now(),
              endDay: DateTime.now().add(Duration(days: 14)),
              events: _events,
              initialCalendarFormat: CalendarFormat.twoWeeks,
              calendarStyle: CalendarStyle(
                markersColor: Colors.white60,
                todayColor: Colors.yellowAccent.shade400,
                selectedColor: Constants.lightAccent,
                weekendStyle: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.yellowAccent),
                todayStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                outsideDaysVisible: false,
                weekdayStyle: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontWeight: FontWeight.w500),
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                formatButtonDecoration: BoxDecoration(
                  color: Constants.lightAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarController: _calendarController,
              onDaySelected: (date, events) {
                _selectedDay = date;
                _selectedDate = date.day.toString() +
                    '-' +
                    date.month.toString() +
                    '-' +
                    date.year.toString();
                setState(() {
                  print(date.toIso8601String());
                  _selectedEvents = events;
                });
                // getAllSessions(f.format(_selectedDay));
                getAllSessions(DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(date.toString())));
              },
            ),
          ),

          //     ..._selectedEvents.map(
          //   (event) => Padding(
          //     padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.all(10),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Colors.purple,
          //               borderRadius: BorderRadius.circular(10.0),
          //             ),
          //             child: Padding(
          //               padding: EdgeInsets.all(10.0),
          //               child: Text(
          //                 event,
          //                 style: TextStyle(
          //                     fontSize: 16.0,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: !isLoading
                    ? Column(
                        children: trainingTiles,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 75.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getAllSessions(String date) async {
    try {
      setState(() {
        isLoading = true;
      });
      Response response =
          await newHttpGetAuth(uri: uriList['getLiveSessions'] + date);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          print("\"allItems\": ${response.body.toString()}");
          liveSessionModel = LiveSessionModel.fromJson(
              jsonDecode("{\"allItems\": ${response.body.toString()}}"));

          // isLoading = false;
          print(response.body);
          buildTiles();
        });
      }
    } catch (e) {
      print(e);
    }
    print("loading done for live session up");
  }

  void buildTiles() {
    List<Widget> trainingTilesLocal = List();
    liveSessionModel.allItems.forEach((element) {
      trainingTilesLocal.add(LiveTrainingTile(
        element: element,
        selectedDate: _selectedDay,
        events: _events,
      ));
    });
    setState(() {
      trainingTiles = trainingTilesLocal;
      isLoading = false;
    });
  }
}
