import 'package:ashva_fitness_example/import/badge_icons_icons.dart';
import 'package:ashva_fitness_example/screens/individual/FeedBack.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shape_of_view/shape_of_view.dart';

import '../../certificatepage.dart';
import 'package:ashva_fitness_example/Invoice.dart';
import 'package:ashva_fitness_example/constants/const.dart';
import 'package:flutter/material.dart';

class CertificateAndReceipt extends StatefulWidget {
  @override
  _CertificateAndReceiptState createState() => _CertificateAndReceiptState();
}

class _CertificateAndReceiptState extends State<CertificateAndReceipt> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ashva',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 80, left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Constants.darkPrimary, Constants.lightPrimary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(
                width: 120,
                height: 90,
                child: LiquidCircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  value: 0.3,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  borderColor: Colors.blue,
                  borderWidth: 2.0,
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
                          '30%',
                          //                 (((_totalStepCount / globalsteps) * 100).toInt())
                          //                     .toString()+'%',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12))
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12))
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12))
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12))
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
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Km',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Steps',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Time',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            '12-04-2020',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataCell(
                          Text(
                            '19',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataCell(
                          Text(
                            '2030',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataCell(
                          Text(
                            '10H',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            '13-04-2020',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataCell(
                          Text(
                            '23',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataCell(
                          Text(
                            '3030',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataCell(
                          Text(
                            '20H',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              RaisedButton(
                  color: Constants.darkPrimary,
                  child: Text(
                    'Certificate',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CertificatePage()));
                  }),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  color: Constants.darkPrimary,
                  child: Text(
                    'Feedback',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FeedBack()));
                  }),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  color: Constants.darkPrimary,
                  child: Text(
                    'Receipt',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Invoice()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
