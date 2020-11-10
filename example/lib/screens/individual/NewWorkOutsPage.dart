import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/model/event.dart';
import 'package:ashva_fitness_example/pages/liveTrainingLinkPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class NewWorkOutsPage extends StatefulWidget {
  @override
  _NewWorkOutsPageState createState() => _NewWorkOutsPageState();
}

class _NewWorkOutsPageState extends State<NewWorkOutsPage> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events = new Map();
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  String _selectedDate;
  DateTime _selectedDay;
  double width, height;
  final controller = ScrollController();
  Color color = Colors.white;

  String desc = """
  # Limen nati ferunt cape currus facienda illic
## Levi mergis iramque sonus ostendit fratres nunc
*Lorem markdownum* neci! Vim ab colubrasque vagas **et nectaris** color nocte
quae artus ab.
- Muneris flores obliquaque et auras
- Nil neque classe dignus subterque humum
- Viris religata
- Parte colantur in vetus signorum orbem
- Tales at squamaque Aesonides sic ira nomen
## Accessit petit tibi moratur disiectisque patre tenebrasque
Cetera frigore satus Actaeon quo radice denique resolvit tanto, favoni desine
dea aut victae. Morari dum in mihi Rhoetei inpia sponte qui nec vultu, est. Haec
haeret, maestaeque, violata hortator *Coeranon mole adnuimusque* addidit
*magnis* spectans! Navit pando. Igitur satus tum subiectaque [ea mihi
effusus](http://visaque.com/in-celat) infraque sceleri potes mutavit tertius
illis rasilis.
    tunneling(desktop_nic_secondary);
    if (-2) {
        graphic_powerpoint.coldFsb = 60 + server;
    }
    bashDvdMegapixel(dockPim, proxy_netiquette_sip(610697, 948850 /
            quadFilePhreaking, fileDriveThird));
## Indigenae Lycias inter onerataque dulcedine it foedera
Pontus rapit modo ramos, ille eosdem tectum, exit inventum Scyrumve aether
quodque [quo](http://corpus.com/vero)! Veritus mortalia in eurus de non inpiger
Priapi.
## Ora ossibus neve satyros considerat atque
Neptunia sentit, et coeptus pulvere Titania, seposuisse dilata, tamen. Rupta
grata [idem est](http://tibivisa.io/) annis Aurora furori; obsessa si tenera,
fuerat nunc, me eos. Nec animam Achille vipereas: facto non captivis Haud cui
coniugis et servatos et.
1. Domos edere
2. Alexiroe totum
3. Nec lux comas ulla carina plectrumque antra
4. Dumque duritia lupum lyramque tamen pro a
5. Male gestit
## Videt ungues membra viros tantus pro colit
Ubi aeternus aquas occiderat exhortor seductus, visu arma, quid tellure
pudibunda Solem pectora inponere tuus. Dis adiecisset, tibi, enim, **vidisse
imum** et! Sunt terris. Hunc cum densas certe summissoque cupidine docuit ferro
saepe te artus, quae attonitus bella corpore, a diu. Tumens parum illic locis
munus nullaque quoniam forte miserabile iter in?
Qua vimque quinque. **Est** pompa novatrix pollice habenis quare; ita nocte,
mutavit hinc sanguine temptat cretum laboras conscia. Avidos inquit rupes ille:
arces, Arachnes argumenta et tangit. Aspicit molibar haberet viriles totas,
coniunx Polydoreo pugnantem omnibus fuit nec, vocavit, marmora.
  """;

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Markdown(
                styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
                styleSheet: MarkdownStyleSheet(
                    h1: TextStyle(
                        color: color,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                    a: TextStyle(color: Colors.blueGrey[100]),
                    code: TextStyle(color: color),
                    p: TextStyle(color: color),
                    h2: TextStyle(color: color, fontSize: 20),
                    blockquote: TextStyle(color: color, fontSize: 16),
                    listBullet: TextStyle(color: color)),
                data: desc,
                controller: controller,
                selectable: true,
                shrinkWrap: true,
              ),
            ),
          ),

          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       top: 20,
          //       left: 20,
          //       right: 20,
          //     ),
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: <Widget>[

          //           // Container(
          //           //   child: Card(
          //           //     shape: RoundedRectangleBorder(
          //           //         borderRadius: BorderRadius.circular(13)),
          //           //     child: Row(
          //           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           //       children: <Widget>[
          //           //         Container(
          //           //           padding: EdgeInsets.symmetric(
          //           //               vertical: 5, horizontal: 10),
          //           //           decoration: BoxDecoration(
          //           //               color: Constants.lightAccent,
          //           //               borderRadius: BorderRadius.circular(13)),
          //           //           child: Column(
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 DateFormat('EEE').format(_selectedDay),
          //           //                 style: TextStyle(
          //           //                     color: Colors.white, fontSize: 18),
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 40,
          //           //               ),
          //           //               Text(
          //           //                 _selectedDay.day.toString(),
          //           //                 style: TextStyle(
          //           //                     color: Colors.white, fontSize: 18),
          //           //               ),
          //           //             ],
          //           //           ),
          //           //         ),
          //           //         Container(
          //           //           padding: EdgeInsets.all(10),
          //           //           child: Column(
          //           //             mainAxisSize: MainAxisSize.min,
          //           //             mainAxisAlignment:
          //           //                 MainAxisAlignment.spaceEvenly,
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 '09:00 am',
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Text('to'),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Text('10:00 am')
          //           //             ],
          //           //           ),
          //           //         ),
          //           //         Container(
          //           //           child: Column(
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 'Morning session',
          //           //                 style: TextStyle(
          //           //                   color: Constants.darkPrimary,
          //           //                 ),
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Column(
          //           //                 mainAxisAlignment: MainAxisAlignment.end,
          //           //                 children: <Widget>[
          //           //                   Text(
          //           //                     '90/100',
          //           //                     style: TextStyle(fontSize: 10),
          //           //                   ),
          //           //                   LinearPercentIndicator(
          //           //                     width: width * 0.3,
          //           //                     lineHeight: 8.0,
          //           //                     percent: 0.9,
          //           //                     progressColor: Constants.lightAccent,
          //           //                   ),
          //           //                 ],
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Container(
          //           //                   width: width * 0.3,
          //           //                   child: Text(
          //           //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          //           //                       style: TextStyle(fontSize: 12),
          //           //                       maxLines: 2,
          //           //                       overflow: TextOverflow.ellipsis)),
          //           //             ],
          //           //           ),
          //           //         ),

          //           //         Column(
          //           //           children: <Widget>[
          //           //             Text('Join '),
          //           //             IconButton(
          //           //                 icon: Icon(
          //           //                   Icons.play_arrow,
          //           //                   color: Constants.darkPrimary,
          //           //                   size: 30,
          //           //                 ),
          //           //                 onPressed: () {
          //           //                   if (!_events.containsKey(_selectedDay)) {
          //           //                     setState(() {
          //           //                       _events.putIfAbsent(_selectedDay,
          //           //                           () => ['Morning Session']);
          //           //                     });

          //           //                     //   {
          //           //                     //   d:[event.title]
          //           //                     // };
          //           //                   } else {
          //           //                     //List<String> buff =[_events[d].toString(),event.id];
          //           //                     setState(() {
          //           //                       _events[_selectedDay]
          //           //                           .add('Morning session');
          //           //                     });
          //           //                   }
          //           //                   Navigator.push(
          //           //                       context,
          //           //                       MaterialPageRoute(
          //           //                           builder: (context) =>
          //           //                               LiveTrainingLinkPage()));
          //           //                 }),
          //           //           ],
          //           //         )
          //           //         // Container(
          //           //         //       decoration: BoxDecoration(
          //           //         //         borderRadius: BorderRadius.circular(13),
          //           //         //         image: DecorationImage(image: AssetImage('assets/Images/video-conference.png'),fit: BoxFit.contain)),
          //           //         //         child: Column(),
          //           //         //     )
          //           //       ],
          //           //     ),
          //           //   ),
          //           // ),
          //           // SizedBox(
          //           //   height: 20,
          //           // ),
          //           // Container(
          //           //   child: Card(
          //           //     shape: RoundedRectangleBorder(
          //           //         borderRadius: BorderRadius.circular(13)),
          //           //     child: Row(
          //           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           //       children: <Widget>[
          //           //         Container(
          //           //           padding: EdgeInsets.symmetric(
          //           //               vertical: 5, horizontal: 10),
          //           //           decoration: BoxDecoration(
          //           //               color: Constants.lightAccent,
          //           //               borderRadius: BorderRadius.circular(13)),
          //           //           child: Column(
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 DateFormat('EEE').format(_selectedDay),
          //           //                 style: TextStyle(
          //           //                     color: Colors.white, fontSize: 18),
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 40,
          //           //               ),
          //           //               Text(
          //           //                 _selectedDay.day.toString(),
          //           //                 style: TextStyle(
          //           //                     color: Colors.white, fontSize: 18),
          //           //               ),
          //           //             ],
          //           //           ),
          //           //         ),
          //           //         Container(
          //           //           padding: EdgeInsets.all(10),
          //           //           child: Column(
          //           //             mainAxisSize: MainAxisSize.min,
          //           //             mainAxisAlignment:
          //           //                 MainAxisAlignment.spaceEvenly,
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 '02:00 pm',
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Text('to'),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Text('03:00 pm')
          //           //             ],
          //           //           ),
          //           //         ),
          //           //         Container(
          //           //           child: Column(
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 'Afternoon session',
          //           //                 style: TextStyle(
          //           //                   color: Constants.darkPrimary,
          //           //                 ),
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Column(
          //           //                 mainAxisAlignment: MainAxisAlignment.end,
          //           //                 children: <Widget>[
          //           //                   Text(
          //           //                     '40/100',
          //           //                     style: TextStyle(fontSize: 10),
          //           //                   ),
          //           //                   LinearPercentIndicator(
          //           //                     width: width * 0.3,
          //           //                     lineHeight: 8.0,
          //           //                     percent: 40 / 100,
          //           //                     progressColor: Constants.lightAccent,
          //           //                   ),
          //           //                 ],
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Container(
          //           //                   width: width * 0.3,
          //           //                   child: Text(
          //           //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          //           //                       style: TextStyle(fontSize: 12),
          //           //                       maxLines: 2,
          //           //                       overflow: TextOverflow.ellipsis)),
          //           //             ],
          //           //           ),
          //           //         ),

          //           //         Column(
          //           //           children: <Widget>[
          //           //             Text('Join '),
          //           //             IconButton(
          //           //                 icon: Icon(
          //           //                   Icons.play_arrow,
          //           //                   color: Constants.darkPrimary,
          //           //                   size: 30,
          //           //                 ),
          //           //                 onPressed: () {
          //           //                   if (!_events.containsKey(_selectedDay)) {
          //           //                     _events.putIfAbsent(_selectedDay,
          //           //                         () => ['Morning Session']);
          //           //                     //   {
          //           //                     //   d:[event.title]
          //           //                     // };
          //           //                   } else {
          //           //                     //List<String> buff =[_events[d].toString(),event.id];
          //           //                     _events[_selectedDay]
          //           //                         .add('Morning session');
          //           //                   }
          //           //                   Navigator.push(
          //           //                       context,
          //           //                       MaterialPageRoute(
          //           //                           builder: (context) =>
          //           //                               LiveTrainingLinkPage()));
          //           //                 }),
          //           //           ],
          //           //         )
          //           //         // Container(
          //           //         //       decoration: BoxDecoration(
          //           //         //         borderRadius: BorderRadius.circular(13),
          //           //         //         image: DecorationImage(image: AssetImage('assets/Images/video-conference.png'),fit: BoxFit.contain)),
          //           //         //         child: Column(),
          //           //         //     )
          //           //       ],
          //           //     ),
          //           //   ),
          //           // ),
          //           // SizedBox(
          //           //   height: 20,
          //           // ),
          //           // Container(
          //           //   child: Card(
          //           //     shape: RoundedRectangleBorder(
          //           //         borderRadius: BorderRadius.circular(13)),
          //           //     child: Row(
          //           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           //       children: <Widget>[
          //           //         Container(
          //           //           padding: EdgeInsets.symmetric(
          //           //               vertical: 5, horizontal: 10),
          //           //           decoration: BoxDecoration(
          //           //               color: Constants.lightAccent,
          //           //               borderRadius: BorderRadius.circular(13)),
          //           //           child: Column(
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 DateFormat('EEE').format(_selectedDay),
          //           //                 style: TextStyle(
          //           //                     color: Colors.white, fontSize: 18),
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 40,
          //           //               ),
          //           //               Text(
          //           //                 _selectedDay.day.toString(),
          //           //                 style: TextStyle(
          //           //                     color: Colors.white, fontSize: 18),
          //           //               ),
          //           //             ],
          //           //           ),
          //           //         ),
          //           //         Container(
          //           //           padding: EdgeInsets.all(10),
          //           //           child: Column(
          //           //             mainAxisSize: MainAxisSize.min,
          //           //             mainAxisAlignment:
          //           //                 MainAxisAlignment.spaceEvenly,
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 '05:00 pm',
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Text('to'),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Text('06:00 pm')
          //           //             ],
          //           //           ),
          //           //         ),
          //           //         Container(
          //           //           child: Column(
          //           //             children: <Widget>[
          //           //               Text(
          //           //                 'Evening session',
          //           //                 style: TextStyle(
          //           //                   color: Constants.darkPrimary,
          //           //                 ),
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Column(
          //           //                 mainAxisAlignment: MainAxisAlignment.end,
          //           //                 children: <Widget>[
          //           //                   Text(
          //           //                     '65/100',
          //           //                     style: TextStyle(fontSize: 10),
          //           //                   ),
          //           //                   LinearPercentIndicator(
          //           //                     width: width * 0.3,
          //           //                     lineHeight: 8.0,
          //           //                     percent: 65 / 100,
          //           //                     progressColor: Constants.lightAccent,
          //           //                   ),
          //           //                 ],
          //           //               ),
          //           //               SizedBox(
          //           //                 height: 8,
          //           //               ),
          //           //               Container(
          //           //                   width: width * 0.3,
          //           //                   child: Text(
          //           //                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          //           //                       style: TextStyle(fontSize: 12),
          //           //                       maxLines: 2,
          //           //                       overflow: TextOverflow.ellipsis)),
          //           //             ],
          //           //           ),
          //           //         ),

          //           //         Column(
          //           //           children: <Widget>[
          //           //             Text('Join '),
          //           //             IconButton(
          //           //                 icon: Icon(
          //           //                   Icons.play_arrow,
          //           //                   color: Constants.darkPrimary,
          //           //                   size: 30,
          //           //                 ),
          //           //                 onPressed: () {
          //           //                   if (!_events.containsKey(_selectedDay)) {
          //           //                     _events.putIfAbsent(_selectedDay,
          //           //                         () => ['Morning Session']);
          //           //                     //   {
          //           //                     //   d:[event.title]
          //           //                     // };
          //           //                   } else {
          //           //                     //List<String> buff =[_events[d].toString(),event.id];
          //           //                     _events[_selectedDay]
          //           //                         .add('Morning session');
          //           //                   }
          //           //                   Navigator.push(
          //           //                       context,
          //           //                       MaterialPageRoute(
          //           //                           builder: (context) =>
          //           //                               LiveTrainingLinkPage()));
          //           //                 }),
          //           //           ],
          //           //         )
          //           //         // Container(
          //           //         //       decoration: BoxDecoration(
          //           //         //         borderRadius: BorderRadius.circular(13),
          //           //         //         image: DecorationImage(image: AssetImage('assets/Images/video-conference.png'),fit: BoxFit.contain)),
          //           //         //         child: Column(),
          //           //         //     )
          //           //       ],
          //           //     ),
          //           //   ),
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
