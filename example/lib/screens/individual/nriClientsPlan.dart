import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/screens/upiScreen.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

class NriClientsPlan extends StatefulWidget {
  @override
  _NriClientsPlanState createState() => _NriClientsPlanState();
}

class _NriClientsPlanState extends State<NriClientsPlan> {
  double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkPrimary,
          title: Text("NRI PAYMENT"),
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ShapeOfView(
                  width: width * 0.25,
                  height: height * 0.2,
                  shape: CircleShape(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * .2,
                    child: Image.asset('assets/Images/carrot.png'),
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  onPressed: () {
                    //get in as corporate
                    Navigator.pop(context);
                  },
                  color: Constants.darkPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: width * 0.7,
                    child: Center(
                      child: Text(
                        'Change To US',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 2,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      onPressed: () {
                        customDialog(context);
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: width * 0.7,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: Text(
                              'Only Fitness 3 days a week',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      onPressed: () {
                        customDialog(context);
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: width * 0.7,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: Text(
                              'Only Running 3 days a week',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      onPressed: () {
                        customDialog(context);
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: width * 0.7,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: Text(
                              'Running + Fitness 6 days a week',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      onPressed: () {
                        customDialog(context);
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: width * 0.7,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: Text(
                              'Family Fitness 5-10 members',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      onPressed: () {
                        customDialog(context);
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: width * 0.7,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: Text(
                              'One 2 One Fitness',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      onPressed: () {
                        customDialog(context);
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: width * 0.7,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: Text(
                              'Single Session Fitness',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  customDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure you want to continue?"),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpiScreen(
                            amount: 2000,
                          )),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
