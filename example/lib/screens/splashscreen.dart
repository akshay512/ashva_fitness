import 'package:ashva_fitness_example/screens/bottom_navigator.dart';
import 'package:ashva_fitness_example/screens/individual/bottom_navigatorIndividual.dart';
import 'package:ashva_fitness_example/screens/login_page.dart';
import 'package:ashva_fitness_example/screens/selectionPage.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Widget screen = SelectionPage();
  @override
  void initState() { 
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) {
      print("prefs !");
      prefs = value;
      print("corporateLogin" + value.getBool('corporate_login').toString());
      print("corporate_dashboard" +
          value.getBool('corporate_dashboard').toString());

      if (value.getBool('corporate_login')) {
        print("corporate login");
        setState(() {
          screen = BottomNavigation();
          prefs.setBool('corporate_dashboard', true);
        });
      }
      if (value.getBool('individual_login')) {
        print("corporate individual_login");
        setState(() {
          screen = BottomNavigationIndividual();
          prefs.setBool('individual_dashboard', true);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen.navigate(
          name: 'assets/flare/ashva_logo.flr',
          next: (context) => screen,
          until: () => Future.delayed(Duration(seconds: 3)),
          startAnimation: 'splash',
        ),
      // Splash(
      //     seconds: 4,
      //     imageBackground: AssetImage('assets/Images/ashvasplash.png'),
      //     navigateAfterSeconds: screen,
      //     loaderColor: Colors.red),
    );
  }

  // Widget getNextSceen() {
  //   print("called getNextScreen"+prefs.toString());
  //   Widget screen=Scaffold();
  //   if (prefs != null) {
  //     print(prefs.getBool('corporate_login').toString());
  //     screen = SelectionPage();
  //   }
  //   return screen;
  // }
}
