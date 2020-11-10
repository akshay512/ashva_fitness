import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:launch_review/launch_review.dart';
import 'package:open_appstore/open_appstore.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

void showCloseAlert(context) {
  Alert(
    context: context,
    type: AlertType.error,
    style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
        titleStyle: TextStyle(
            color: Colors.pink[600],
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 24)),
    title: "Ashva Fitness",
    desc: "Google Fit app not installed",
    buttons: [
      DialogButton(
        color: Colors.red,
        child: Text(
          "Exit",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => exitApp(),
        width: 120,
      )
    ],
  ).show();
}



void launchApp(context) {
  print('launchApp');
  LaunchReview.launch(
      androidAppId: "com.google.android.apps.fitness&hl=en_IN",
      iOSAppId: "284882215");
  //OpenAppstore.launch(androidAppId: "com.google.android.apps.fitness&hl=en_IN", iOSAppId: "284882215");
  Navigator.of(context).pop();
}

void exitApp() {
  exit(0);
}

void showGoogleFitAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Ashva Fitness",
    style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: false,
        titleStyle: TextStyle(
            color: Colors.pink[600],
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 24)),
    desc: "Google Fit app is not installed, please install before proceeding",
    buttons: [
      DialogButton(
        child: Text(
          "Install",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => launchApp(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        color: Colors.red,
        child: Text(
          "Exit",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => exitApp(),
//        gradient: LinearGradient(colors: [
//          Color.fromRGBO(116, 116, 191, 1.0),
//          Color.fromRGBO(52, 138, 199, 1.0)
//        ]),
      )
    ],
  ).show();

  /*Future.delayed(Duration.zero, () {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'Ashva Fitness',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Colors.pink[600]),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    "Google Fit not installed, please install before proceeding",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                          child: Text('Proceed'),
                          onPressed: () {
                            LaunchReview.launch(
                                androidAppId:
                                    "com.google.android.apps.fitness&hl=en_IN",
                                iOSAppId: "284882215");
                            //OpenAppstore.launch(androidAppId: "com.google.android.apps.fitness&hl=en_IN", iOSAppId: "284882215");
                            Navigator.of(context).pop();
                            //exit(0);
                          }),
                      FlatButton(
                          child: Text('Exit'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            exit(0);
                          })
                    ])
              ],
            ),
          );
        });
  });*/
}

void showExitModal(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Center(
            child: Text(
          'Ashva Fitness',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.pink[600]),
        )),
        content: new Text("Google Fit app not installed"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Exit"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
