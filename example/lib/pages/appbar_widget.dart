import 'package:flutter/material.dart';

Widget showAppBarWidget() {
  return AppBar(
    elevation: 0,
    //backgroundColor: Colors.white,
    title: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'Accenture',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            width: 40.0,
            height: 40.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("assets/img/profile_pic.png")))),
      ),
    ],
  );
}
