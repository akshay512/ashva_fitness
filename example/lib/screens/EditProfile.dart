import 'dart:convert';
import 'dart:io';
import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/model/userDetailsModel.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

//edit InkWell
class _EditProfileState extends State<EditProfile> {
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _lName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  File _image;
  bool isImageCaptured = false;
  bool isLoading = false;
  UserDetailsModel userDetailsModel;
  bool isBtnLoading = false;

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
    });
    if (_image == null) return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Constants.darkPrimary,
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Text("Edit your profile",
                style: TextStyle(color: Colors.white)),
          )),
          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(
          //         Icons.cancel,
          //         color: Colors.white,
          //       ),
          //       onPressed: () {
          //         print("pop profile");
          //         Navigator.pop(context);
          //       })
          // ],
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

              child: !isLoading
                  ? ListView(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0, top: 0),
                            child: Align(
                                child: Column(children: <Widget>[
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 35.0),
                                      child: Theme(
                                        data: new ThemeData(
                                          primaryColor: Colors.white30,
                                          primaryColorDark: Colors.white10,
                                          accentColor: Colors.white10,
                                        ),
                                        child: Stack(children: [
                                          Hero(
                                            tag: "profile-image",
                                            child: Container(
                                              width: 140.0,
                                              height: 140.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: (isImageCaptured)
                                                      ? FileImage(_image)
                                                      : NetworkImage(
                                                          "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg"),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(80.0),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 5.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 5,
                                              left: 5,
                                              child: Stack(children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.0)),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 8,
                                                  top: 8,
                                                  child: InkWell(
                                                    onTap: () {
                                                      getImage();
                                                    },
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )
                                              ]))
                                        ]),
                                      ),
                                    ),
                                    // name code
                                    SizedBox(height: 25.0),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        controller: _name,
                                        textInputAction: TextInputAction.next,
                                        focusNode: _nameFocus,
                                        onFieldSubmitted: (term) {
                                          _fieldFocusChange(
                                              context, _nameFocus, _lNameFocus);
                                        },
                                        decoration: InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.white70),
                                          labelStyle:
                                              TextStyle(color: Colors.white70),

                                          // icon: Icon(Icons.person, color: Constants.darkPrimary),
                                          labelText: 'First Name',
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          // border: OutlineInputBorder(
                                          //   borderSide: BorderSide(color: Colors.white10),
                                          //   borderRadius: BorderRadius.circular(5),
                                          // ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //phone no. code
                                    SizedBox(height: 22.0),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        controller: _lName,
                                        textInputAction: TextInputAction.next,
                                        focusNode: _lNameFocus,
                                        onFieldSubmitted: (term) {
                                          _fieldFocusChange(context,
                                              _lNameFocus, _emailFocus);
                                        },
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                            labelStyle: TextStyle(
                                                color: Colors.white70),
                                            labelText: 'Last Name',
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    //email code
                                    SizedBox(height: 22.0),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        controller: _email,
                                        focusNode: _emailFocus,

                                        // onFieldSubmitted: (term){
                                        //   _fieldFocusChange(context, _nameFocus, _lNameFocus);
                                        // },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            // icon: Icon(Icons.location_city, color: Constants.darkPrimary),
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                            labelStyle: TextStyle(
                                                color: Colors.white70),
                                            labelText: 'email',
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    _buildButtons(context)
                                  ]),
                            ])),
                          )
                        ])
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ]),
        ]));
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 16.0),
      child: InkWell(
        splashColor: Colors.orange,
        onTap: !isBtnLoading
            ? () {
                // Navigator.pop(context);
                postEditData({
                  "email": _email.text,
                  "firstName": _name.text,
                  "lastName": _lName.text,
                  "profilePicture":
                      "https://t4.ftcdn.net/jpg/02/15/84/43/240_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg"
                });
              }
            : () {},
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
            child: !isBtnLoading
                ? Text(
                    "SAVE CHANGES",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      //  fontFamily: 'Montserrat',
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),

      // child: ClipRRect(
      //   borderRadius: new BorderRadius.circular(30.0),
      //   child: Container(
      //     decoration: BoxDecoration(
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey,
      //           offset: Offset(0.0, 1.0), //(x,y)
      //           blurRadius: 2.0,
      //         ),
      //       ],
      //     ),
      //     child: Material(
      //       shadowColor:Colors.grey,

      //       color: Constants.lightPrimary,
      //       child: InkWell(
      //         splashColor: Colors.orange,
      //         onTap: () {},
      //         child: Container(
      //           height: 46.0,
      //           width: MediaQuery.of(context).size.width * .7,
      //           child: Center(
      //             child: Text(
      //               "SAVE CHANGES",
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 16,
      //                 //  fontFamily: 'Montserrat',
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Future<void> getUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await newHttpGetAuth(uri: uriList['getUserDetalis']);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          print(response.body);
          userDetailsModel =
              UserDetailsModel.fromJson(jsonDecode(response.body));
          _name.text = userDetailsModel.firstName;
          _lName.text = userDetailsModel.lastName;
          _email.text = userDetailsModel.email;
        });
      }
    } catch (e) {
      print(e);
    }
    print("loading done for sign up");
  }

  Future<void> postEditData(Map<String, dynamic> reqBody) async {
    setState(() {
      isBtnLoading = true;
    });
    Map<String, dynamic> requestBody = {};
    Response response = 
        await newHttpPostAuth(uri: uriList['postEditProfile'], body: reqBody);

    if (response.statusCode == 200) {
      getUser();
      setState(() {
        isBtnLoading = false;
      });
    }

    print(response.body);

    print("post edit data");
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) async {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
