import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/screens/dashboard.dart';
import 'package:ashva_fitness_example/screens/getinspiredpage.dart';
import 'package:ashva_fitness_example/screens/imggallerypage.dart';
import 'package:ashva_fitness_example/screens/individual/NewWorkOutsPage.dart';
import 'package:ashva_fitness_example/screens/individual/dailyChallanges.dart';
import 'package:ashva_fitness_example/screens/individual/dailychallenge.dart';
import 'package:ashva_fitness_example/screens/manualupload.dart';
import 'package:ashva_fitness_example/screens/selectplan.dart';
import 'package:ashva_fitness_example/screens/timeslotpage.dart';
import 'package:ashva_fitness_example/screens/workoutpage.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/widgets/Facts.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Added by Mallikarjun
import 'package:ashva_fitness_example/utils/starva_config.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavigation extends StatefulWidget {
  final int page;

  BottomNavigation({Key key, this.page}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  FancyDrawerController _controller;
  PageController _pageController;
  int _page;
  GlobalKey _bottomNavigationKey = GlobalKey();
  DateTime currentBackPressTime;
  bool _isOn = false;
  bool isDrawerOpen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDrawerOpen = false;
    if (widget.page != null) {
      _page = widget.page;
      _pageController = PageController(
        initialPage: widget.page,
        keepPage: true,
      );
    } else {
      _page = 0;
      _pageController = PageController(
        initialPage: _page,
        keepPage: true,
      );
    }
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
  }

  void loadpage() {
    _pageController.jumpToPage(2);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (_page == 0) {
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: "Press Back Again to Exit");
        return Future.value(false);
      }
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(false);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => BottomNavigation(
                page: 0,
              )));
      // setState(() {
      //   _page = 0;
      //   _pageController.jumpToPage(
      //     0,
      //   );
      // });

      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Material(
          child: FancyDrawerWrapper(
            backgroundColor: Colors.white,
            itemGap: 0,
            controller: _controller,
            drawerItems: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Images/mask.jpg'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'John Wick',
                    style: TextStyle(
                        color: Constants.darkPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.accessibility_new,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Invite now",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  Navigator.pushNamed(context, '/invitePage');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Constants.darkPrimary,
                ),
                title: Row(children: [
                  Text(
                    "Manual Upload",
                    style: TextStyle(
                        color: Constants.darkPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Container(
                  //     height: 20,
                  //     width: 20,
                  //     decoration: BoxDecoration(
                  //       color: Constants.darkPrimary,
                  //       borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  //     ),
                  //     child: Center(
                  //         child: Text(
                  //       "10",
                  //       style: TextStyle(color: Colors.white, fontSize: 10),
                  //     )),
                  //   ),
                  // ),
                ]),
                // trailing: InkWell(
                //   child: CupertinoSwitch(
                //     activeColor: Constants.darkPrimary,
                //     value: _isOn,
                //     onChanged: (bool value) {
                //       setState(() {
                //         _isOn = value;
                //       });
                //     },
                //   ),
                //   onTap: () {
                //     setState(() {
                //       _isOn = !_isOn;
                //     });
                //   },
                // ),
                onTap: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => ManualUpload()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.live_help,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Todays facts",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  _controller.close();
                  setState(() {
                    isDrawerOpen = false;
                  });
                  // Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog( 
                      
                      description: "Professor",
                      buttonText: "Okay",
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Gallary",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GalleryPage()));
                },
              ),
              ListTile(
                leading: Icon(
                  MdiIcons.runFast,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Daily Challenges",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  // Navigator.pushNamed(context, '/summary');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DailyChallenge()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.public,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Connect to starva",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  connectStrava();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Delete Account",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {},
              ),
              ListTile(
                leading: Icon(
                  Icons.lock_outline,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  print("corporateLogin" +
                      prefs.getBool('corporate_login').toString());
                  print("corporate_dashboard" +
                      prefs.getBool('corporate_dashboard').toString());
                  if (prefs.getBool('corporate_dashboard') != null) {
                    if (prefs.getBool('corporate_dashboard')) {
                      Navigator.pushReplacementNamed(context, '/selectionpage');
                    } else {
                      Navigator.pushReplacementNamed(context, ('/signUpPage'));
                      //after akshys undo
                      //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
                    }
                  } else {
                    Navigator.pushReplacementNamed(context, ('/signUpPage'));
                    //after akshys undo
                    //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
                  }
                  prefs.setBool('corporate_login', false);
                  prefs.setBool('corporate_dashboard', false);

                  //clear login from sharedPrefs
                },
              ),
            ],
            child: Scaffold(
                appBar:
                    // (_page == 2)
                    //     ? PreferredSize(
                    //         preferredSize: Size(0.0, 0.0),
                    //         child: Container(),
                    //       )
                    // :
                    AppBar(
                  leading: IconButton(
                    icon: (isDrawerOpen)
                        ? Icon(
                            Icons.close,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      if (isDrawerOpen) {
                        _controller.close();
                        setState(() {
                          isDrawerOpen = false;
                        });
                      } else {
                        _controller.toggle();
                        setState(() {
                          isDrawerOpen = true;
                        });
                      }
                    },
                  ),
                  title: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Ashva',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Constants.lightPrimary,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/editProfile');
                          },
                          child: Hero(
                            tag: "profile-image",
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  "https://image.shutterstock.com/image-photo/portrait-smiling-red-haired-millennial-260nw-1194497251.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                extendBodyBehindAppBar: true,
                // drawer: getNavDrawer(context),
                body: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: onPageChanged,
                  children: <Widget>[
                    DashBoardScreen(),
                    GetInspiredPage(),
                    // WorkoutPage(
                    //   weeks: 3,
                    // ),
                    NewWorkOutsPage(),
                    TimeSlotPage(),
                    DailyChallangesMainPage()
                  ],
                ),
                bottomNavigationBar: bmnav.BottomNav(
                  index: (widget.page != null) ? widget.page : _page,
                  labelStyle: bmnav.LabelStyle(
                      textStyle: TextStyle(color: Color(0xFFCCCCCC)),
                      onSelectTextStyle:
                          TextStyle(color: Constants.darkPrimary)),
                  iconStyle: bmnav.IconStyle(
                      color: Color(0xFFCCCCCC),
                      onSelectColor: Constants.darkPrimary),
                  items: [
                    bmnav.BottomNavItem(CustomIcons.dashboard,
                        label: 'Dashboard'),
                    bmnav.BottomNavItem(CustomIcons.play,
                        label: 'Get inspired'),
                    bmnav.BottomNavItem(Icons.fitness_center,
                        label: 'Workouts'),
                    bmnav.BottomNavItem(
                      MdiIcons.video,
                      label: 'Live Training',
                    ),
                    bmnav.BottomNavItem(
                      MdiIcons.runFast,
                      label: 'Challanges',
                    )
                  ],
                  color: Color(0xFFEFEFEF),
                  onTap: (index) {
                    setState(() {
                      _page = index;
                      print(index);
                      _pageController.jumpToPage(
                        index,
                      );
                    });
                  },
                )),
          ),
        ));
  }

  Drawer getNavDrawer(BuildContext context) {
    //drawer function
    var headerChild = DrawerHeader(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(2.0, 4.0),
                      blurRadius: 15),
                ],
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Profile()));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Images/mask.jpg')),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
              flex: 1,
              child: Text(
                'Jhon Wick',
                style: TextStyle(color: Constants.darkPrimary),
              ))
        ],
      ),
    );

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () async {
          if (s == "Logout") {
          } else {
            setState(() {
              // pop closes the drawer
              Navigator.of(context).pop();
              // navigate to the route

              //Navigator.of(context).pushNamed(routeName);
            });
          }
        },
      );
    }

    var myNavChildren = [
      headerChild,
      // getNavItem(Icons.home, "Home", "/pageselect"),
      // getNavItem(Icons.person, "Customers", "/managecustomer"),
      // getNavItem(Icons.account_balance, "Property", "/property"),
      // getNavItem(Icons.exit_to_app, "Checkout", "/exitpage"),
      // getNavItem(Icons.account_balance_wallet, "Expenses", "/expenselist"),
      // getNavItem(Icons.record_voice_over, "Complaints", "/complaintslistpage"),
      // getNavItem(Icons.help, "Help & Support", "/helpandsupport"),
      // getNavItem(Icons.power_settings_new, "Logout", "/loginpage")
      ListTile(
        leading: Icon(
          Icons.accessibility_new,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Invite now",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          Navigator.pushNamed(context, '/invitePage');
        },
      ),
      ListTile(
        // leading: Icon(
        //   Icons.notifications,
        //   color: Constants.darkPrimary,
        // ),
        title: Row(children: [
          Text(
            "Manual Upload",
            style: TextStyle(
                color: Constants.darkPrimary, fontWeight: FontWeight.bold),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Container(
          //     height: 20,
          //     width: 20,
          //     decoration: BoxDecoration(
          //       color: Constants.darkPrimary,
          //       borderRadius: BorderRadius.all(Radius.circular(40.0)),
          //     ),
          //     child: Center(
          //         child: Text(
          //       "10",
          //       style: TextStyle(color: Colors.white, fontSize: 10),
          //     )),
          //   ),
          // ),
          // InkWell(
          //   child: CupertinoSwitch(
          //     activeColor: Constants.darkPrimary,
          //     value: _isOn,
          //     onChanged: (bool value) {
          //       setState(() {
          //         _isOn = value;
          //       });
          //     },
          //   ),
          //   onTap: () {
          //     setState(() {
          //       _isOn = !_isOn;
          //     });
          //   },
          // ),
        ]),
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contetxt) => ManualUpload()));
        },
      ),
      ListTile(
        leading: Icon(
          Icons.live_help,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Todays facts",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              description: "Professor",
              buttonText: "Okay",
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(
          Icons.group,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Create group",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {},
      ),
      ListTile(
        leading: Icon(
          Icons.info,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Request Info",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {},
      ),
      ListTile(
        leading: Icon(
          Icons.public,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Connect to starva",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          connectStrava();
        },
      ),
      ListTile(
        leading: Icon(
          Icons.more,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Daily Challenges",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          // Navigator.pushNamed(context, '/summary');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DailyChallenge()));
        },
      ),
      ListTile(
        leading: Icon(
          Icons.delete,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Delete Account",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {},
      ),
      ListTile(
        leading: Icon(
          Icons.lock_outline,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Sign Out",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          print("corporateLogin" + prefs.getBool('corporate_login').toString());
          print("corporate_dashboard" +
              prefs.getBool('corporate_dashboard').toString());
          if (prefs.getBool('corporate_dashboard') != null) {
            if (prefs.getBool('corporate_dashboard')) {
              Navigator.pushReplacementNamed(context, '/selectionpage');
            } else {
              Navigator.pushReplacementNamed(context, ('/signUpPage'));
              //after akshys undo
              //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
            }
          } else {
            Navigator.pushReplacementNamed(context, ('/signUpPage'));
            //after akshys undo
            //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
          }
          prefs.setBool('corporate_login', false);
          prefs.setBool('corporate_dashboard', false);

          //clear login from sharedPrefs
        },
      ),
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  
}
