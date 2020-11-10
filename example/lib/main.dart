import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/constants/padding.dart';
import 'package:ashva_fitness_example/pages/googlefit_test_page.dart';
import 'package:ashva_fitness_example/pages/test_strava.dart';
import 'package:ashva_fitness_example/screens/aboutUs.dart';
import 'package:ashva_fitness_example/screens/bottom_navigator.dart';
import 'package:ashva_fitness_example/screens/dashboard.dart';
import 'package:ashva_fitness_example/screens/individual/EditProfileIndividual.dart';
import 'package:ashva_fitness_example/screens/individual/bottom_navigatorIndividual.dart';
import 'package:ashva_fitness_example/screens/individual/dashboardIndividual.dart';
import 'package:ashva_fitness_example/screens/individual/loginIndividual.dart';
import 'package:ashva_fitness_example/screens/individual/nriClientsPlan.dart';
import 'package:ashva_fitness_example/screens/individual/profilePageIndividual.dart';
import 'package:ashva_fitness_example/screens/individual/summaryPage.dart';
import 'package:ashva_fitness_example/screens/individual/usCLientsPlan.dart';
import 'package:ashva_fitness_example/screens/individual/userManual.dart';
import 'package:ashva_fitness_example/screens/invitepage.dart';
import 'package:ashva_fitness_example/screens/login_page.dart';
import 'package:ashva_fitness_example/screens/moreAboutUs.dart';
import 'package:ashva_fitness_example/screens/otpPage.dart';
import 'package:ashva_fitness_example/screens/paymentSelect.dart';
import 'package:ashva_fitness_example/screens/registerpage.dart';
import 'package:ashva_fitness_example/screens/selectionPage.dart';
import 'package:ashva_fitness_example/screens/selectlevelpage.dart';
import 'package:ashva_fitness_example/screens/selectplan.dart';
import 'package:ashva_fitness_example/screens/signup.dart';
import 'package:ashva_fitness_example/screens/splashscreen.dart';
import 'package:ashva_fitness_example/screens/upiScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:page_transition/page_transition.dart';
import 'screens/otpPage.dart';
import 'screens/EditProfile.dart';
import 'screens/profilePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Ashva',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        routes: {
          '/': (context) =>
              SplashScreenPage(), //StravaFlutterPage(title: 'strava_flutter demo'), //,
          '/selectionpage': (context) => SelectionPage(),
          '/bottomNav': (context) => BottomNavigation(),
          '/bottomNavIndividual': (context) => BottomNavigationIndividual(),
          '/profilePage': (context) => ProfilePage(),
          '/editProfile': (context) => EditProfile(),
          '/dashboard': (context) => DashBoardScreen(),
          '/profilePageIndividual': (context) => ProfilePageIndividual(),
          '/editProfileIndividual': (context) => EditProfileIndividual(),
          '/dashboardIndividual': (context) => DashBoardScreenIndividual(),
          '/otpPage': (context) => OtpPage(),
          '/signUpPage': (context) => SignUpPage(),
          '/loginPage': (context) => LoginPage(),
          '/selectPlan': (context) => SelectPlan(),
          '/invitePage': (context) => InvitePage(),
          '/aboutUs': (context) => AboutUs(),
          '/moreAboutUs': (context) => MoreAboutUs(),
          '/paymentSelect': (context) => PaymentSelect(),
          '/upiScreen': (context) => UpiScreen(),
          '/selectlevel': (context) => SelectLevel(),
          '/registerpage': (context) => RegisterPage(),
          '/loginIndividual': (context) => LoginPageIndividual(),
          '/summary': (context) => Summary(),
          '/userManual': (context) => UserManual(),
          '/nri': (context) => NriClientsPlan(),
          '/us': (context) => UsCLientsPlan(),
        });
  }
}

// import 'package:ashva_fitness_example/pages/new_dashboard.dart';
// import 'package:ashva_fitness_example/pages/googlefit_test_page.dart';
// import 'package:ashva_fitness_example/pages/landing_page.dart';
// import 'package:ashva_fitness_example/pages/login_page.dart';
// import 'package:ashva_fitness_example/pages/register_page.dart';
// import 'package:ashva_fitness_example/pages/splashScreen.dart';
// import 'package:ashva_fitness_example/pages/tabs.dart';
// import 'package:ashva_fitness_example/pages/test_strava.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:ashva_fitness/ashva_fitness.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:async';
// import 'dart:io';

// void main() async => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     print('MAIN initState ');
//   }

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: 'Ashva Fitness',
//       routes: {
//         '/login': (BuildContext context) => LoginPage(),
//         '/register': (BuildContext context) => RegisterPage(),
//         '/dashboard': (BuildContext context) => DashboardPage(),
//         '/landingpage': (BuildContext context) => LandingPage(),
//         '/tabspage': (BuildContext context) => Tabs()
//       },
//       theme: ThemeData(
//           brightness: Brightness.light,
//           primaryColor: Colors.pink[600],
//           accentColor: Colors.deepOrange[200],
//           fontFamily: 'Poppins',
//           backgroundColor: Colors.grey,
//           textTheme: TextTheme(
//               headline: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
//               title: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
//               body1: TextStyle(fontSize: 18.0))),
//       home: SplashScreen(), //StravaFlutterPage(title: 'strava_flutter demo'),//SplashScreen(),
//       //DashboardPage(), //GoogleFitTest(),//
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
