import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:ashva_fitness_example/constants/const.dart';

//Start of Added by Mallikarjun
import 'package:ashva_fitness/ashva_fitness.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shape_of_view/shape_of_view.dart';
//End of Added by Mallikarjun

class LeaderBoardSheet extends StatefulWidget {
  LeaderBoardSheet({Key key}) : super(key: key);

  @override
  _LeaderBoardSheetState createState() => _LeaderBoardSheetState();
}

class _LeaderBoardSheetState extends State<LeaderBoardSheet> {
  TextStyle defaultheaderstyle =
      TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700);
  double width, height;
  var data = ['ALL', 'GLOBALLY', 'BANGALORE', 'MTW'];
  int selectedchip = 0;
  TextStyle defaultchipstyle = TextStyle(color: Color(0xFFB1B1B1));
  TextStyle selectedchipstyle = TextStyle(color: Colors.white);

  //Start of Added by Mallikarjun
  int _totalStepCount = 0;

  @override
  initState() {
    super.initState();
    //Added by Mallikarjun for Google Fit
    _getActivityHealthData();
  }

  _getActivityHealthData() async {
    var steps = await AshvaFitness.getSteps;
    setState(() {
      _totalStepCount = steps.toInt();
    });
  }
//End of Added by Mallikarjun

  var userlist = [
    {
      "name": "Rahul Mishra",
      "steps": 2400,
      "level": "Hustler",
      "profileimg":
          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg",
      "loc": "Bangalore",
    },
    {
      "name": "Rahul Mishra",
      "steps": 2400,
      "level": "Hustler",
      "profileimg":
          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg",
      "loc": "Bangalore",
    },
    {
      "name": "Rahul Mishra",
      "steps": 2400,
      "level": "Hustler",
      "profileimg":
          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg",
      "loc": "Bangalore",
    },
    {
      "name": "Rahul Mishra",
      "steps": 1400,
      "level": "Hustler",
      "profileimg":
          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg",
      "loc": "Bangalore",
    },
    {
      "name": "Rahul Mishra",
      "steps": 5400,
      "level": "Hustler",
      "profileimg":
          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg",
      "loc": "Bangalore",
    },
    {
      "name": "Rahul Mishra",
      "steps": 4400,
      "level": "Hustler",
      "profileimg":
          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg",
      "loc": "Bangalore",
    },
    {
      "name": "Rahul Mishra",
      "steps": 2800,
      "level": "Hustler",
      "profileimg":
          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg",
      "loc": "Bangalore",
    }
  ];

  Widget _buildList(BuildContext context) {
    int count = 0;
    return Container(
      // margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
          itemCount: userlist.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      (++count).toString(),
                      style: defaultchipstyle,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Constants.lightPrimary,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(userlist[index]["profileimg"]),
                      ),
                    ),
                  ],
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      userlist[index]["name"],
                      style: TextStyle(
                          color: Color(
                            0xFFB1B1B1,
                          ),
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "#${userlist[index]["level"]}",
                          style: TextStyle(color: Color(0xFFB1B1B1)),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('|',
                            style: TextStyle(
                                color: Color(
                              0xFFB1B1B1,
                            ))),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Color(0xFFB1B1B1)),
                            text: userlist[index]["steps"].toString(),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' steps',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                trailing: ClipOval(
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFF2F2F2),
                        child: Icon(
                          CustomIcons.clap,
                          size: 18,
                          color: Colors.orange,
                        ))),
              ),
            );
          }),
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
            // gradient: LinearGradient(
            //     colors: [Constants.darkPrimary, Constants.lightPrimary])
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Card(
                          elevation: 0,
                          color: Constants.darkPrimary,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: defaultheaderstyle,
                                  text: "12",
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'th',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'World Rank',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ShapeOfView(
                          width: width * 0.35,
                          height: height * 0.2,
                          shape: StarShape(noOfPoints: 5),
                          child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU"),
                          // child: Container(
                          //   width: width*0.2,
                          //   height: height*0.2,
                          //   child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU")),
                        ),
                        // CircleAvatar(
                        //   radius: 51.5,
                        //   backgroundColor: Colors.white,
                        //   child: CircleAvatar(
                        //     radius: 48,
                        //     backgroundImage: NetworkImage(
                        //         "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU"),
                        //   ),
                        // ),
                        Text(
                          'Neha Kapoor',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   '#SemiPro',
                        //   style: TextStyle(color: Color(0xFFE8E8E8)),
                        // )
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Card(
                            elevation: 0,
                            color: Constants.darkPrimary,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "200",
                                        style: defaultheaderstyle,
                                      ),
                                      Icon(
                                        MdiIcons.shoePrint,
                                        color: Colors.white,
                                      )
                                    ]),
                                Text(
                                  'Global step ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Card(
                          elevation: 0,
                          color: Constants.darkPrimary,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: defaultheaderstyle,
                                  text: "12",
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'th',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Location Rank',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   right: 25,
              //   top: 20,
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: ClipOval(
              //         child: CircleAvatar(
              //             radius: 20,
              //             backgroundColor: Colors.orange.shade400,
              //             child: Icon(
              //               CustomIcons.close,
              //               color: Colors.grey.shade300,
              //               size: 14,
              //             ))),
              //   ),
              // )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ChoiceChip(
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: width * 0.015),
                    labelPadding:
                        EdgeInsets.symmetric(vertical: height * 0.006),
                    label: Text('ALL'),
                    backgroundColor: Color(0xFFF2F2F2),
                    selected: selectedchip == 0,
                    labelStyle: (selectedchip == 0)
                        ? selectedchipstyle
                        : defaultchipstyle,
                    selectedColor: Constants.darkPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onSelected: (value) {
                      setState(() {
                        selectedchip = 0;
                      });
                    },
                    pressElevation: 0,
                  ),
                  ChoiceChip(
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: width * 0.02),
                    labelStyle: (selectedchip == 1)
                        ? selectedchipstyle
                        : defaultchipstyle,
                    labelPadding:
                        EdgeInsets.symmetric(vertical: height * 0.006),
                    label: Text('GLOBAL'),
                    backgroundColor: Color(0xFFF2F2F2),
                    selected: selectedchip == 1,
                    selectedColor: Constants.darkPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onSelected: (value) {
                      setState(() {
                        selectedchip = 1;
                      });
                    },
                    pressElevation: 0,
                  ),
                  ChoiceChip(
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: width * 0.02),
                    labelPadding:
                        EdgeInsets.symmetric(vertical: height * 0.006),
                    labelStyle: (selectedchip == 2)
                        ? selectedchipstyle
                        : defaultchipstyle,
                    label: Text('LOCAL LOCATION'),
                    backgroundColor: Color(0xFFF2F2F2),
                    selected: selectedchip == 2,
                    selectedColor: Constants.darkPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onSelected: (value) {
                      setState(() {
                        selectedchip = 2;
                      });
                    },
                    pressElevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(child: _buildList(context)),
      ],
    );
  }
}
