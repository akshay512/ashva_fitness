import 'dart:io';
import 'package:ashva_fitness_example/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

import 'package:timer_count_down/timer_count_down.dart';

class LiveTrainingFeedBackPage extends StatefulWidget {
  @override
  _LiveTrainingFeedBackPageState createState() =>
      _LiveTrainingFeedBackPageState();
}

//edit InkWell
class _LiveTrainingFeedBackPageState extends State<LiveTrainingFeedBackPage> {
  String validatePhone(String value) {
    Pattern pattern = r'^[0][1-9]\d{9}$|^[1-9]\d{9}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    if (!regex.hasMatch(value))
      return 'Enter Valid phone num';
    else
      return null;
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _phone = new TextEditingController();
  final TextEditingController _email = new TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  File _image;
  bool isImageCaptured = false;
  bool showResend = false;
  bool goodFeed = true;
  bool autovalidate;
  String otp;
  String feedText = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autovalidate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Constants.darkPrimary,
          // title: Center(
          //   child: Text("Sign Up", style: TextStyle(color: Colors.white)),
          // )
        ),
        // extendBodyBehindAppBar: true,
        body: Stack(children: [
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Constants.darkPrimary,
                  Constants.lightPrimary,
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              )),
            ),
            Container(
              // padding: EdgeInsets.only(top: 70,bottom: 70),

              child: ListView(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, top: 0),
                      child: Align(
                          child: Column(children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width * .8,
                                child: Column(
                                  children: <Widget>[
                                    Text("Krishna kumar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              // name code
                              RatingBar(
                                initialRating: 3,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  if (rating == 1) {
                                    setState(() {
                                      feedText = "Normal";
                                      goodFeed = false;
                                    });
                                  }
                                  if (rating == 2) {
                                    setState(() {
                                      feedText = "Good";
                                      goodFeed = true;
                                    });
                                  }
                                  if (rating == 3) {
                                    setState(() {
                                      feedText = "Very Good";
                                      goodFeed = true;
                                    });
                                  }
                                  if (rating == 4) {
                                    setState(() {
                                      feedText = "Great";
                                      goodFeed = true;
                                    });
                                  }
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(feedText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )),
                              //email code
                              SizedBox(height: 30.0),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .04,
                              ),
                              goodFeed
                                  ? Column(
                                      children: <Widget>[
                                        Text("",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Thak you",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.thumb_up,
                                                color: Colors.white,
                                              )
                                            ]),
                                      ],
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          .95,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .2,
                                      child: TextField(
                                        maxLines: 5,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter you feed',
                                          labelStyle:
                                              TextStyle(color: Colors.white70),
                                          hintStyle:
                                              TextStyle(color: Colors.white70),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                              _buildMoreButton(context)
                            ]),
                      ])),
                    )
                  ]),
            ),
          ]),
        ]));
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 16.0),
      child: InkWell(
        splashColor: Colors.orange,
        onTap: () {
          // Navigator.pop(context);
          // autovalidate = true;
        },
        child: Container(
          height: 46.0,
          width: MediaQuery.of(context).size.width * .7,
          decoration: BoxDecoration(
            color: Constants.lightPrimary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Text(
              "SEND OTP",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                //  fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
      child: InkWell(
        splashColor: Colors.orange,
        onTap: () {
          // Navigator.pop(context);
        },
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {},
          padding: EdgeInsets.all(11),
          color: Constants.darkPrimary,
          child: Container(
            width: MediaQuery.of(context).size.width * .61,
            child: Center(
              child: Text('SUBMIT FEEDBACK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        // Container(
        //   height: 46.0,
        //   width: MediaQuery.of(context).size.width * .7,
        //   decoration: BoxDecoration(
        //     color: Constants.lightPrimary,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey,
        //         offset: Offset(0.0, 1.0), //(x,y)
        //         blurRadius: 2.0,
        //       ),
        //     ],
        //     borderRadius: new BorderRadius.circular(30.0),
        //   ),
        //   child: Center(
        //     child: Text(
        //       "CHECK WHAT’S GOING ON",
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 16,
        //         //  fontFamily: 'Montserrat',
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Column formTwoBuilder(BuildContext context) {
    TextEditingController _otp = TextEditingController();
    bool _showTimer = true;
    int _seconds = 20;
    //otp code here
    return Column(
      children: <Widget>[
        Text(
          'Enter OTP here:',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
// name code
        SizedBox(height: 5.0),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
          child: PinCodeTextField(
            controller: _otp,
            backgroundColor: Colors.transparent,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            length: 4,
            textInputType: TextInputType.number,
            activeColor: Colors.white,
            // inactiveColor: Colors.yellow,
            textStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            selectedColor: Colors.yellow,
            obsecureText: false,
            animationType: AnimationType.slide,
            shape: PinCodeFieldShape.underline,
            animationDuration: Duration(milliseconds: 300),
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 45,
            fieldWidth: 45,
            onChanged: (value) {
              setState(() {
                otp = value;
              });
            },
          ),
        ),
        SizedBox(height: 15.0),
        Text(
          'OTP expires in :',
          style: TextStyle(color: Colors.white),
        ),
        if (_showTimer)
          CountDown(
            style: TextStyle(color: Colors.white),
            seconds: _seconds,
            onTimer: () {
              setState(() {
                setState(() {
                  showResend = true;
                });
                _showTimer = false;
              });
            },
          ),
// next button code
        SizedBox(height: 20.0),
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {},
                padding: EdgeInsets.all(11),
                color: Constants.darkPrimary,
                child: Text('Verify OTP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ),
              showResend == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          //resend otp
                          // Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(11),
                        color: Constants.darkPrimary,
                        child: Text('Resend OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              setState(() {
                goodFeed = false;
                showResend = false;
              });
            },
            padding: EdgeInsets.all(11),
            color: Constants.darkPrimary,
            child: Text('Change mobile number',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) async {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
