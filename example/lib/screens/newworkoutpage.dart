import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class WorkoutPage extends StatefulWidget {
  final int weeks;
  WorkoutPage({Key key, this.weeks}) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  DateTime _selectedDay;
  double width, height;
  String month;
  DateTime startDate = DateTime.now();
  DateTime endDate;
  DateTime selectedDate = DateTime.now();
  final controller = ScrollController();
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];

  @override
  void initState() {
    super.initState();
    endDate = DateTime.now().add(Duration(days: 7 * (widget.weeks)));
    print(startDate.month);
    if (startDate.month > 9) {
      month = monthsInYear["${startDate.month}"];
    } else {
      month = monthsInYear["0${startDate.month}"];
    }
    print(month);
  }

  Map<String, String> monthsInYear = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December",
  };

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

  onSelect(data) {
    print("Selected Date -> $data");
    String seldate = data.toString();
    // print(seldate);
    setState(() {
      month = monthsInYear["${seldate.substring(5, 7)}"];
    });

    print(month);
    // print(seldate.substring(5, 7));
  }

  _monthNameWidget(monthName) {
    return Container();
  }

  // getMarkedIndicatorWidget() {
  //   return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //     Container(
  //       margin: EdgeInsets.only(left: 1, right: 1),
  //       width: 7,
  //       height: 7,
  //       decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
  //     ),
  //     Container(
  //       width: 7,
  //       height: 7,
  //       decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
  //     )
  //   ]);
  // }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    // if (isDateMarked == true) {
    //   _children.add(getMarkedIndicatorWidget());
    // }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'My workouts ($month)',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 8, bottom: 4),
              ),
              Container(
                  child: CalendarStrip(
                addSwipeGesture: true,
                startDate: startDate,
                endDate: endDate,
                onDateSelected: onSelect,
                dateTileBuilder: dateTileBuilder,
                iconColor: Colors.black87,
                monthNameWidget: _monthNameWidget,
                // markedDates: markedDates,
                containerDecoration: BoxDecoration(color: Colors.black12),
              )),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Markdown(
                    data: desc,
                    controller: controller,
                    selectable: true,
                    shrinkWrap: true,
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
