import 'dart:convert';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/constants/padding.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CustomDialog extends StatefulWidget {
  final String description, buttonText;
  final Image image;

  CustomDialog({
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool isLoading = false;
  List<dynamic> allFacts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFacts();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: Stack(children: [
            allFacts != null
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: allFacts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => dialogContent(
                        context, allFacts[index]["factDescription"]),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ]),
        ));
  }

  dialogContent(BuildContext context, String desc) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: MediaQuery.of(context).size.height * .45,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 50, right: 5),
            child: Container(
              width: MediaQuery.of(context).size.width * .95,
              height: MediaQuery.of(context).size.height * .6,
              padding: EdgeInsets.only(),
              margin: EdgeInsets.only(top: Consts.avatarRadius),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Consts.padding),
                                topRight: Radius.circular(Consts.padding)),
                            gradient: LinearGradient(
                              colors: [
                                Constants.darkPrimary,
                                Constants.lightPrimary,
                              ],
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                            )),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .20,
                          width: MediaQuery.of(context).size.width * .20,
                          child: Image.asset('assets/Images/carrot.png'),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Do you know?",
                      style: TextStyle(
                          fontSize: 20,
                          color: Constants.darkPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .55,
                      child: Text(
                        desc,
                        style: TextStyle(
                            fontSize: 15, color: Constants.darkPrimary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                      height: .5,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFFCCCCCC),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        //url launch
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Know more",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Constants.darkPrimary,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Constants.darkPrimary,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAllFacts() async {
    try {
      setState(() {
        isLoading = true;
      });
      Response response = await newHttpGetAuth(uri: uriList['getAllFacts']);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          allFacts = jsonDecode(response.body);

          // isLoading = false;
          print(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
    print("loading done for live session up");
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
