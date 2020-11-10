import 'dart:io';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/staticText.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "/registerpage";
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double width, height;
  bool passwordVisible = false;
  bool autovalidate = false;

  File _image;
  bool isImageCaptured = false;

  List<String> _bloodgroups = [
    'A+ve',
    'B+ve',
    'AB+ve',
    'O+ve',
    'A-ve',
    'B-ve',
    'AB-ve',
    'O-ve'
  ]; // Option 2
  String _selectedBloodgrp;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobno = TextEditingController();
  TextEditingController _emno = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _confrmpass = TextEditingController();
  TextEditingController _address = TextEditingController();

  FocusNode _fnamefocus = FocusNode();
  FocusNode _lnamefocus = FocusNode();
  FocusNode _emailfocus = FocusNode();
  FocusNode _mobnofocus = FocusNode();
  FocusNode _emnofocus = FocusNode();
  FocusNode _passfocus = FocusNode();
  FocusNode _confrmpassfocus = FocusNode();
  FocusNode _addressfocus = FocusNode();

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name is not valid";
    }
    return null;
  }

  String validateAddress(String value) {
    String patttern = r'(^[a-zA-Z0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Address is Required";
    }
    return null;
  }

  String validateLocation(String value) {
    String patttern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Location is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Location is not valid";
    }
    return null;
  }

  String validatePassword(String value) {
    // String patttern = r'(^[a-zA-Z]*$)';
    // RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "password is Required";
    }
    // else if (!regExp.hasMatch(value)) {
    //   return "Location is not valid";
    // }
    return null;
  }

  String validateConform(String value) {
    // String patttern = r'(^[a-zA-Z]*$)';
    // RegExp regExp = new RegExp(patttern);
    if (_pass.text != _confrmpass.text) {
      return "password does not match";
    }
    //  else if (!regExp.hasMatch(value)) {
    //   return "Location is not valid";
    // }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  Future getImage() async {
    var image = null;

    image = await showDialog<File>(
        context: this.context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Constants.darkPrimary),
                  ),
                  onPressed: () async {
                    image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    Navigator.pop(context, image);
                  },
                ),
                FlatButton(
                  child: Text("Gallery"),
                  onPressed: () async {
                    image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    Navigator.pop(context, image);
                  },
                )
              ],
            ));

    //var image = await ImagePicker.pickImage(source: imageSource);

    if (image == null) return;

    File croppedfile = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxWidth: 512,
        maxHeight: 512,
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Constants.darkPrimary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _image = croppedfile;
    });
    setState(() {
      isImageCaptured = true;
      Fluttertoast.showToast(
          msg: "Image Uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Constants.darkPrimary,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    if (_image == null) return;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text("Signup Page"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidate: autovalidate,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Constants.lightPrimary, Constants.darkPrimary],
                begin: Alignment.bottomCenter,
              ),
            ),
            child: Theme(
              data: ThemeData(canvasColor: Colors.orange),
              child: Column(
                children: <Widget>[
                  // TopContainer(
                  //   padding: EdgeInsets.fromLTRB(10, 10, 20, 40),
                  //   width: width,
                  //   child: Column(
                  //     children: <Widget>[
                  //       Hero(
                  //         tag: 'backButton',
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             Navigator.pop(context);
                  //           },
                  //           child: Align(
                  //             alignment: Alignment.centerLeft,
                  //             child: Icon(
                  //               Icons.arrow_back_ios,
                  //               size: 25,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 30,
                  //       ),
                  //       Container(
                  //         width: 250,
                  //         child: Text(
                  //           'WELCOME TO ASHVA CLUB',
                  //           style: TextStyle(
                  //               fontSize: 30.0,
                  //               fontWeight: FontWeight.w700,
                  //               color: Colors.white),
                  //         ),
                  //       ),
                  //       // SizedBox(height: 20),
                  //       // Container(
                  //       //     child: Column(
                  //       //   crossAxisAlignment: CrossAxisAlignment.start,
                  //       //   children: <Widget>[
                  //       //     MyTextField(label: 'Title'),
                  //       //     Row(
                  //       //       mainAxisAlignment: MainAxisAlignment.start,
                  //       //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       //       children: <Widget>[
                  //       //         Expanded(
                  //       //           child: MyTextField(
                  //       //             label: 'Date',
                  //       //             icon: downwardIcon,
                  //       //           ),
                  //       //         ),
                  //       //         CircleAvatar(
                  //       //           radius: 25.0,
                  //       //           backgroundColor: Colors.green,
                  //       //           child: Icon(
                  //       //             Icons.calendar_today,
                  //       //             size: 20.0,
                  //       //             color: Colors.white,
                  //       //           ),
                  //       //         ),
                  //       //       ],
                  //       //     )
                  //       //   ],
                  //       // ))
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: width * 0.35,
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      validator: validateName,
                                      focusNode: _fnamefocus,
                                      controller: _fname,
                                      decoration: InputDecoration(
                                        labelText: 'First Name',
                                        labelStyle:
                                            TextStyle(color: Colors.white70),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white38),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _fnamefocus, _lnamefocus);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: width * 0.35,
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      validator: validateName,
                                      focusNode: _lnamefocus,
                                      controller: _lname,
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        labelStyle:
                                            TextStyle(color: Colors.white70),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white38),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _lnamefocus, _emailfocus);
                                      },
                                    ),
                                  ),
                                  Center(
                                    child: IconButton(
                                        padding: EdgeInsets.only(top: 10),
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => getImage()),
                                  )
                                ],
                              ),
                              TextFormField(
                                focusNode: _emailfocus,
                                controller: _email,
                                validator: validateEmail,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  labelText: 'Your Email ID/AshvaID ',
                                  labelStyle: TextStyle(color: Colors.white70),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white38),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                onFieldSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _emailfocus, _mobnofocus);
                                },
                              ),
                              // Row(
                              //   children: <Widget>[
                              //     Text(
                              //       "Upload profile photo",
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.w600),
                              //     ),
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //   ],
                              // ),
                              TextFormField(
                                focusNode: _mobnofocus,
                                controller: _mobno,
                                keyboardType: TextInputType.number,
                                validator: validateMobile,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    labelText: 'Mobile No.',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    prefixText: '+91',
                                    prefixStyle:
                                        TextStyle(color: Colors.white)),
                                onFieldSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _mobnofocus, _emnofocus);
                                },
                              ),
                              TextFormField(
                                focusNode: _emnofocus,
                                controller: _emno,
                                keyboardType: TextInputType.number,
                                validator: validateMobile,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    labelText: 'Emergency No.',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    prefixText: '+91',
                                    prefixStyle:
                                        TextStyle(color: Colors.white)),
                                onFieldSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _emnofocus, _passfocus);
                                },
                              ),
                              TextFormField(
                                focusNode: _passfocus,
                                controller: _pass,
                                obscureText: (passwordVisible) ? false : true,
                                validator: validatePassword,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.shade300,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                    labelText: 'Password',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    prefixStyle:
                                        TextStyle(color: Colors.white)),
                                onFieldSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _passfocus, _confrmpassfocus);
                                },
                              ),
                              TextFormField(
                                focusNode: _confrmpassfocus,
                                controller: _confrmpass,
                                validator: validateConform,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    prefixStyle:
                                        TextStyle(color: Colors.white)),
                                onFieldSubmitted: (term) {
                                  _fieldFocusChange(
                                      context, _confrmpassfocus, _addressfocus);
                                },
                              ),
                              TextFormField(
                                focusNode: _addressfocus,
                                controller: _address,
                                validator: validateAddress,
                                maxLines: 3,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    prefixStyle:
                                        TextStyle(color: Colors.white)),
                                onFieldSubmitted: (term) {
                                  _addressfocus.unfocus();
                                },
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      // alignLabelWithHint: true,
                                      labelText: 'Blood Group',
                                      labelStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      // hintText: 'Please choose blood group',
                                      // hintStyle: TextStyle(
                                      //   color: Colors.white70,
                                      // ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white38),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      prefixStyle:
                                          TextStyle(color: Colors.white)),
                                  // hint: Text(
                                  //   'Please choose a Blood Group',
                                  //   style: TextStyle(color: Colors.white70),
                                  // ), // Not necessary for Option 1
                                  value: _selectedBloodgrp,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedBloodgrp = newValue;
                                    });
                                  },
                                  items: _bloodgroups.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(
                                        location,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    height: 80,
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/loginIndividual');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                StaticText.buttontext["alreadyUser"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              autovalidate = true;
                            });
                            if (_formKey.currentState.validate()) {
                              //handle signup here
                            }
                            prefs.setBool('individual_signUp', true);

                            Navigator.of(context).pushNamed('/us');

                            // Navigator.of(context).pushNamed('/paymentSelect');

                            // Navigator.of(context).pushNamed('/loginIndividual');
                          },
                          child: Container(
                            child: Text(
                              StaticText.buttontext["signupButton"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            width: width * .5,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                              color: Constants.darkPrimary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
