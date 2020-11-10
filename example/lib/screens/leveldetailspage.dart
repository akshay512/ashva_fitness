import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/screens/registerpage.dart';
import 'package:flutter/material.dart';

class LevelDetails extends StatefulWidget {
  static const String routeName = "/leveldetails";
  final String title;
  LevelDetails({Key key, this.title}) : super(key: key);

  @override
  _LevelDetailsState createState() => _LevelDetailsState();
}

class _LevelDetailsState extends State<LevelDetails> {
  int selectedplan = 0;
  double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Hero(tag: widget.title, child: Text(widget.title)),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Constants.lightPrimary, Constants.darkPrimary],
          begin: Alignment.bottomCenter,
        )),
        child: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white30),
          child: Column(
            children: <Widget>[
              Text(
                'Choose a package',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: height * .1,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    RadioListTile(
                      activeColor: Colors.white,
                      value: 0,
                      title: Text(
                        '5 K - 12 Weeks',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      groupValue: selectedplan,
                      onChanged: (val) {
                        setState(() {
                          selectedplan = val;
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: Colors.white,
                      value: 1,
                      title: Text(
                        '10 K - 15 Weeks',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      groupValue: selectedplan,
                      onChanged: (val) {
                        setState(() {
                          selectedplan = val;
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: Colors.white,
                      value: 2,
                      title: Text(
                        '15 K - 20 Weeks',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      groupValue: selectedplan,
                      onChanged: (val) {
                        setState(() {
                          selectedplan = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.3,
              ),
              RaisedButton(
                color: Constants.darkPrimary,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.3, vertical: height * 0.02),
                onPressed: () {
                  Navigator.of(context).pushNamed('/bottomNavIndividual');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Choose',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
