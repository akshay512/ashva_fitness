import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/constants/padding.dart';
import 'package:flutter/material.dart';

class TaxDialog extends StatelessWidget {
  final String description, buttonText;
  final Image image;

  TaxDialog({
    @required this.description,
    @required this.buttonText,
    this.image,
  });

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
            Center(
              child: dialogContent(context),
            )
          ]),
        ));
  }

  dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: MediaQuery.of(context).size.height * .5,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Payment Info",
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
                        "5500Rs +3% CGST+5% SGST = 6K",
                        style: TextStyle(
                            fontSize: 18,
                            color: Constants.darkPrimary
                          ),
                      ),
                    ),
                  ),
                  // Spacer(flex: 2,),

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
                            // InkWell(
                            //   onTap: () {},
                            //   child: Text(
                            //     "Know more",
                            //     style: TextStyle(
                            //         fontSize: 15,
                            //         color: Constants.darkPrimary,
                            //         fontStyle: FontStyle.italic),
                            //   ),
                            // ),
                             Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Text(
                                    "OK",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Constants.darkPrimary,
                                        fontStyle: FontStyle.italic),
                                  ),
                                                                    ],
                                                                  ),
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
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
