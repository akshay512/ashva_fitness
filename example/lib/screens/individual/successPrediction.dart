import 'package:ashva_fitness_example/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class SuccessPrediction extends StatefulWidget {
  @override
  _SuccessPredictionState createState() => _SuccessPredictionState();
}

class _SuccessPredictionState extends State<SuccessPrediction> {
  double width, height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SUCCESS PREDECTION',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(
            top: 80,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Constants.darkPrimary, Constants.lightPrimary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            width: width,
            child: Column(
              children: <Widget>[
                Container(
                  height: 140,
                  width: 140,
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
                            '40%',
                            //                 (((_totalStepCount / globalsteps) * 100).toInt())
                            //                     .toString()+'%',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  Container(
                    width: width,
                    height: height * .2,
                    child: Image.asset(
                      'assets/img/motivation.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       height: 70,
                  //       width: 70,
                  //       child: LiquidCircularProgressIndicator(
                  //         backgroundColor: Colors.transparent,
                  //         value: 0.4,
                  //         valueColor:
                  //             AlwaysStoppedAnimation(Colors.blue),
                  //         borderColor: Colors.blue,
                  //         borderWidth: 4.0,
                  //         center: Container(
                  //           padding: EdgeInsets.symmetric(horizontal: 8),
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: <Widget>[
                  //               Text(
                  //                 "Progress",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 10.0,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 '40%',
                  //                 //                 (((_totalStepCount / globalsteps) * 100).toInt())
                  //                 //                     .toString()+'%',
                  //                 style: TextStyle(
                  //                     color: Colors.white, fontSize: 12.0),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Text("10% - 20% Something not Right",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text("21% - 40% Get to work hard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text("41% - 70% Good Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text("71% - 90% You are closer to target",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text("91% - 100% Success",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
