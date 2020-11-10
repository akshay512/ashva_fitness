import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/constants/staticText.dart';
import 'package:flutter/material.dart';

class MoreAboutUs extends StatefulWidget {
  @override
  _MoreAboutUsState createState() => _MoreAboutUsState();
}

class _MoreAboutUsState extends State<MoreAboutUs> {
  double width, height;

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
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                    color: Constants.lightAccent,
                    borderRadius: BorderRadius.circular(5)),
                height: height * .3,
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 2.0,
                          ),
                        ],
                        color: Constants.lightAccent,
                        borderRadius: BorderRadius.circular(5)),
                    height: height * .3,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          StaticText.moreAboutUs,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
                        ),
                      ],
                      color: Constants.lightAccent,
                      borderRadius: BorderRadius.circular(5)),
                  height: height * .3,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        StaticText.moreAboutUs,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )),
            ]),
          ),
          RaisedButton(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.2, vertical: height * 0.02),
            onPressed: () {
              //get in as corporate
              Navigator.pushNamed(context, '/registerpage');
            },
            color: Constants.darkPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              'JOIN AS A MEMBER',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }
}
