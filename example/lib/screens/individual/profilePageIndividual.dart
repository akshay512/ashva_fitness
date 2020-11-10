import 'package:flutter/material.dart';
import 'package:ashva_fitness_example/constants/const.dart';

//Start of Added by Mallikarjun
import 'package:ashva_fitness/ashva_fitness.dart';
//End of Added by Mallikarjun

class ProfilePageIndividual extends StatefulWidget {
  static const String routeName = "/profilePageIndividual";
  @override
  _ProfilePageIndividualState createState() => _ProfilePageIndividualState();
}

//edit InkWell
class _ProfilePageIndividualState extends State<ProfilePageIndividual> {

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
    var running = await AshvaFitness.getWalkingAndRunningDistance;
    var cycle = await AshvaFitness.geCyclingDistance;
    var flights = await AshvaFitness.getFlights;
    setState(() {
      _totalStepCount = steps.toInt();
    });
  }
//End of Added by Mallikarjun

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              const Color(0xFFFFFFFF),
              const Color(0xFFD8D8D8),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Align(
              child: Column(
            children: <Widget>[
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Center(
                    child: Text("Ashvya",
                        style: TextStyle(color: Constants.darkPrimary))),
                actions: <Widget>[
                  // IconButton(
                  //     icon: Icon(
                  //       Icons.edit,
                  //       color: Constants.darkPrimary,
                  //     ),
                  //     onPressed: () {
                  //       print("go to profile edit");
                  //       Navigator.pushNamed(context, '/editProfile');
                  //     }),
                  IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Constants.darkPrimary,
                      ),
                      onPressed: () {
                        print("pop profile");
                        Navigator.pop(context);
                      })
                ],
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .85,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0.0, 3.0),
                              blurRadius: 15.0)
                        ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white,
                                height:
                                    (MediaQuery.of(context).size.height * .85) /
                                        2,
                                width: MediaQuery.of(context).size.width * .9,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Container(
                                        width: 140.0,
                                        height: 140.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          border: Border.all(
                                            color: Colors.white30,
                                            width: 5.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "JHON WICK",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Constants.darkPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "#pro",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.orange[200]),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                //graditent
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Constants.darkPrimary,
                                    Constants.lightPrimary,
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                )),
                                height:
                                    (MediaQuery.of(context).size.height * .85) /
                                        2,
                                width: MediaQuery.of(context).size.width * .9,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  "World Step Counter",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 50,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'assets/Images/earth.png'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          40.0)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 35,
                                                                top: 10),
                                                        child: Container(
                                                          width: 20,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/Images/small_feet.png'),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 40.0),
                                                        child: Container(
                                                          height: 20,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orange[600],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0.0,
                                                                    1.0), //(x,y)
                                                                blurRadius: 6.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "10,00,000",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  "Your Step Count",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          40.0)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                top: 10),
                                                        child: Container(
                                                          width: 20,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/Images/small_feet.png'),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 40.0),
                                                        child: Container(
                                                          height: 20,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orange[600],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0.0,
                                                                    1.0), //(x,y)
                                                                blurRadius: 6.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            _totalStepCount.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Achivements",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ]),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Column(children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orange[300],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        40.0)),
                                                          ),
                                                          child: Stack(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        top:
                                                                            12),
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/Images/medal1.png'),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2.0),
                                                          child: Text(
                                                            "25m",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 25.0,
                                                                right: 25),
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .orange[
                                                                      300],
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              40.0)),
                                                                ),
                                                                child: Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              15,
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            27,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage('assets/Images/medal2.png'),
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 2.0),
                                                                  child: Text(
                                                                    "25km",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ]),
                                                      ),
                                                      Column(children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orange[300],
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        40.0)),
                                                          ),
                                                          child: Stack(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            14,
                                                                        top:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  width: 25,
                                                                  height: 25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/Images/clap.png'),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2.0),
                                                          child: Text(
                                                            "178",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ]),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ]),
                  ),
                  //
                ],
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: Container(
              height: 80,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "1",
                            style: TextStyle(
                                fontSize: 23, color: Constants.darkPrimary),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              "st",
                              style: TextStyle(color: Constants.darkPrimary),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "rank world wide",
                        style: TextStyle(color: Colors.orange[200]),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "12",
                            style: TextStyle(
                                fontSize: 23, color: Constants.darkPrimary),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              "th",
                              style: TextStyle(color: Constants.darkPrimary),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "in banglore",
                        style: TextStyle(color: Colors.orange[200]),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Constants.lightPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 12, top: 13),
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        )
      ]),
    );
  }
}
