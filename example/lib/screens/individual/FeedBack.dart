import 'dart:io';
import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

import 'package:timer_count_down/timer_count_down.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

//edit InkWell
class _FeedBackState extends State<FeedBack> {
  bool isLoading = false;
  double mRating = 3;
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

  final TextEditingController _desc = new TextEditingController();
  final TextEditingController _phone = new TextEditingController();
  final TextEditingController _email = new TextEditingController();

  final FocusNode _descFocus = FocusNode();
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(formattedDate, style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
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
                              ShapeOfView(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                shape: StarShape(noOfPoints: 5),
                                child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU"),
                                // child: Container(
                                //   width: width*0.2,
                                //   height: height*0.2,
                                //   child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU")),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width * .9,
                                child: Column(
                                  children: <Widget>[
                                    Text("How was your training today ?",
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
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: RatingBar(
                                  initialRating: 3,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    switch (index) {
                                      case 0:
                                        return Icon(
                                          Icons.sentiment_satisfied,
                                          color: Colors.red,
                                        );
                                      case 1:
                                        return Icon(
                                          Icons.sentiment_neutral,
                                          color: Colors.redAccent,
                                        );
                                      case 2:
                                        return Icon(
                                          Icons.sentiment_dissatisfied,
                                          color: Colors.amber,
                                        );
                                    }
                                  },
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      mRating = rating;
                                    });
                                    if (rating == 1) {
                                      setState(() {
                                        feedText = "It was easy";
                                        goodFeed = true;
                                      });
                                    }
                                    if (rating == 2) {
                                      setState(() {
                                        feedText = "It was hard";
                                        goodFeed = false;
                                      });
                                    }
                                    if (rating == 3) {
                                      setState(() {
                                        feedText = "It was very hard";
                                        goodFeed = false;
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
                                              Text("You are awesome",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                MdiIcons.fire,
                                                color: Colors.orangeAccent,
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
                                        controller: _desc,
                                        maxLines: 5,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Where did you feel difficulty ?',
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
          onPressed: !isLoading
              ? () async {
                  await postFeedback({
                    "description": "${_desc.text}",
                    "feedback": "${mRating.toString()}"
                  });
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "feedback uploaded succesfully");
                }
              : () {},
          padding: EdgeInsets.all(11),
          color: Constants.darkPrimary,
          child: Container(
            width: MediaQuery.of(context).size.width * .61,
            child: Center(
              child: !isLoading
                  ? Text('SUBMIT FEEDBACK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold))
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ),
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

  Future<void> postFeedback(Map<String, dynamic> req) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestBody = {};
    Response response =
        await newHttpPostAuth(uri: uriList['sendFeedDailyBack'], body: req);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
