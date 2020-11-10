import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/constants/staticText.dart';
import 'package:flutter/material.dart';

import '../constants/staticText.dart';
import '../constants/staticText.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  double width, height;
  bool shouldShow = false;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text("About Us"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // padding:
        //     EdgeInsets.only(top: 80, left: width * 0.05, right: width * 0.05),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Constants.darkPrimary, Constants.lightPrimary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20,bottom: 20),
            child: Container(
              height: height * .58,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StaticText.aboutUs,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      shouldShow
                          ? Text(
                              StaticText.forMembers,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          : Container(),
                    ]),
              ),
            ),
          ),
          !shouldShow
              ? RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.3, vertical: height * 0.02),
                  onPressed: () {
                    //get in as corporate
                    // Navigator.pushNamed(context, '/moreAboutUs');
                    setState(() {
                      shouldShow = true;
                    });
                  },
                  color: Constants.darkPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    StaticText.buttontext["continueButton"],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(children: [
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.2, vertical: height * 0.02),
                      onPressed: () {
                        //get in as corporate
                        Navigator.pushNamed(context, '/registerpage');
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'JOIN AS A MEMBER',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.22, vertical: height * 0.02),
                      onPressed: () {
                        //get in as corporate
                        Navigator.pushNamed(context, '/bottomNavIndividual');
                      },
                      color: Constants.darkPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'JOIN AS A GUEST',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
        ]),
      ),
    );
  }
}
