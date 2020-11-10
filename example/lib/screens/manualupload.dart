import 'dart:io';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rounded_flutter_datetime_picker/rounded_flutter_datetime_picker.dart';
import 'package:dio/dio.dart';
import '../services/httpRequestBody.dart';

class ManualUpload extends StatefulWidget {
  ManualUpload({Key key}) : super(key: key);

  @override
  _ManualUploadState createState() => _ManualUploadState();
}

class _ManualUploadState extends State<ManualUpload> {
  double width, height;
  Response response;
  Dio dio = new Dio();

  TextEditingController _distance = new TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime seldate;

  DateTime selTime;

  File _image;

  String tandc =
      "I promise that with my own wish I am taking part in this organization initiative, respecting and abiding by the rules set by organization in my true spirit of sportsmanship and data provided by me is correct";

  bool _checkBoxValue = false;

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
    if (_image == null) return;
  }

  void _agreedTermsConditions(bool value) {
    print('_agreedTermsConditions value $value');
    setState(() {
      _checkBoxValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Manual Upload',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
        child: Column(
          children: <Widget>[
            Center(
              child: AspectRatio(
                  aspectRatio: 2.5,
                  child: Image.asset('assets/Images/carrot.png')),
            ),
            SizedBox(
              height: height * .05,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Constants.darkPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              // child: Padding(
              // padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  // gradient: LinearGradient(
                  //     begin: Alignment.centerLeft,
                  //     end: Alignment.centerRight,
                  //     stops: [
                  //       0.2,
                  //       0.4,
                  //       0.6,
                  //       0.8
                  //     ],
                  //     colors: [
                  //       Constants.lightPrimary,
                  //       Constants.darkPrimary
                  //     ]),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(width * .05),
                      child:
                          // Center(
                          //   child: Column(
                          //     children: <Widget>[
                          Text(
                        'Enter Info'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      // Text(
                      //   'Available Cash',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       color: _iconColor, fontSize: 16),
                      // ),
                      //     ],
                      //   ),
                      // ),
                    ),
                    Divider(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 0.5),
                      ),
                      children: [
                        TableRow(children: [
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true, onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  setState(() {
                                    seldate = date;
                                  });
                                  print('confirm $date');
                                },
                                    maxTime: DateTime.now(),
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Text(
                                (seldate != null)
                                    ? DateFormat('dd/MM/yyyy').format(seldate)
                                    : 'Select Date',
                                style: TextStyle(
                                    color: (seldate != null)
                                        ? Colors.white70
                                        : Colors.white),
                              )),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * .07),
                            child: TextField(
                              controller: _distance,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  hintText: 'Distance',
                                  hintStyle: TextStyle(color: Colors.white),
                                  suffix: Text(
                                    'K.M',
                                    style: TextStyle(color: Colors.white54),
                                  )),
                            ),
                          )
                          // FlatButton(
                          //   onPressed: () {
                          //     DatePicker.showDatePicker(context,
                          //         showTitleActions: true,
                          //         onChanged: (date) {
                          //       print('change $date');
                          //     }, onConfirm: (date) {
                          //       print('confirm $date');
                          //     },
                          //         currentTime: DateTime.now(),
                          //         locale: LocaleType.en);
                          //   },
                          //   child: Text(
                          //     'show date time',
                          //     style: TextStyle(color: Colors.blue),
                          //   ),
                          // ),
                        ]),
                        TableRow(children: [
                          FlatButton(
                              onPressed: () {
                                DatePicker.showTime12hPicker(context,
                                    showTitleActions: true, onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                }, onConfirm: (date) {
                                  setState(() {
                                    selTime = date;
                                  });
                                  print('confirm $date');
                                }, currentTime: DateTime.now());
                              },
                              child: Text(
                                (selTime != null)
                                    ? DateFormat('HH:mm').format(selTime)
                                    : 'Select Time',
                                style: TextStyle(
                                    color: (selTime != null)
                                        ? Colors.white70
                                        : Colors.white),
                              )),
                          // LayoutBuilder(builder: (context, constraints) {
                          //   print(
                          //       "max width ${constraints.maxWidth} max Height ${constraints.maxHeight}");
                          //   return Container(
                          //     child: Text("Hello"),
                          //   );
                          // })
                          Container(
                            height: 50,
                            child: Center(
                              child: (_image == null)
                                  ? InkWell(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.camera,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Upload Screenshot',
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        showDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                  child: PhotoView(
                                                    backgroundDecoration:
                                                        BoxDecoration(
                                                      color: Colors.transparent,
                                                    ),
                                                    imageProvider:
                                                        FileImage(_image),
                                                  ),
                                                ));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Preview',
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ),

                          // FlatButton(
                          //     onPressed: () {
                          //       DatePicker.showTime12hPicker(context,
                          //           showTitleActions: true,
                          //           onChanged: (date) {
                          //         print('change $date in time zone ' +
                          //             date.timeZoneOffset.inHours
                          //                 .toString());
                          //       }, onConfirm: (date) {
                          //         print('confirm $date');
                          //       }, currentTime: DateTime.now());
                          //     },
                          //     child: Text(
                          //       'show 12H time picker with AM/PM',
                          //       style: TextStyle(color: Colors.blue),
                          //     )),
                        ])
                      ],
                    ),
                  ],
                ),
              ),
              // )
            ),
            SizedBox(
              height: height * .05,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: _checkBoxValue,
                  activeColor: Colors.pink[600],
                  onChanged: _agreedTermsConditions,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: width * .7,
                  child: Text(
                    tandc,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.grey[300], fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              height: height * .05,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.3, vertical: height * 0.02),
              onPressed: () {
                if (_checkBoxValue &&
                    seldate != null &&
                    selTime != null &&
                    _image != null) {
                  //handle api post here

                  //test uploadImage

                  uploadImage(_image);
                } else if (_checkBoxValue == false) {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Please agree for terms and conditions')
                    ],
                  )));
                } else {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[Text('Fill all the details')],
                  )));
                }
              },
              color: Constants.darkPrimary,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "SUBMIT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadImage(File file) async {
    try {
      print(_image.lengthSync());
      String fileName = _image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(_image.path,
            filename: fileName, contentType: MediaType("image", "jpeg")),
      });
      dio.options.headers = {
        'Content-type': 'multipart/form-data',
        'Authorization': prefs.get('auth_token').toString(),
      };
      response = await dio.post(uriList["uploadImage"], data: formData);
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
