import 'dart:async';
import 'package:ashva_fitness_example/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:ashva_fitness_example/pages/login_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

// This is the Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _loginStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkLoginStatus().then((value) {
      print("SplashScreen _checkLoginStatus $value");
      setState(() {
        _loginStatus = value;
        if (_loginStatus) {
          Timer(Duration(seconds: 5), () {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => DashboardPage()));

            //Navigator.pushReplacementNamed(context, '/dashboard');

            Navigator.pushReplacementNamed(context, '/tabspage');
          });
        } else {
          Timer(Duration(seconds: 5), () {
            Navigator.pushReplacementNamed(context, '/landingpage');
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => LoginPage()));
          });
        }
      });
    });
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('loginStatus');
    String username = prefs.getString('username');
    String token = prefs.getString('token');
    print('_checkLoginStatus boolValue ${boolValue}');
    print('_checkLoginStatus username ${username}');
    if (boolValue != null) {
      if (boolValue) {
        print('_checkLoginStatus Already logged in');
        return true;
      } else {
        print('_checkLoginStatus Not logged in');
        return false;
      }
    } else {
      print('_checkLoginStatus First time user');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: new Image.asset(
                    'assets/img/powered_by.png',
                    height: 100.0,
                    fit: BoxFit.scaleDown,
                  ))
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/img/source.gif',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
