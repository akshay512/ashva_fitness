import 'dart:io';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/screens/dashboard.dart';
import 'package:ashva_fitness_example/screens/getinspiredpage.dart';
import 'package:ashva_fitness_example/screens/individual/NewWorkOutsPage.dart';
import 'package:ashva_fitness_example/screens/individual/certificateandreceipt.dart';
import 'package:ashva_fitness_example/screens/individual/dailyChallanges.dart';
import 'package:ashva_fitness_example/screens/individual/dailychallenge.dart';
import 'package:ashva_fitness_example/screens/individual/dashboardIndividual.dart';
import 'package:ashva_fitness_example/screens/individual/getinspiredpageIndividual.dart';
import 'package:ashva_fitness_example/screens/individual/successPrediction.dart';
import 'package:ashva_fitness_example/screens/individual/workoutpageIndividual.dart';
import 'package:ashva_fitness_example/screens/manualupload.dart';
import 'package:ashva_fitness_example/screens/selectplan.dart';
import 'package:ashva_fitness_example/screens/timeslotpage.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:ashva_fitness_example/screens/workoutpage.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/widgets/Facts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './manualuploadindividual.dart';

class BottomNavigationIndividual extends StatefulWidget {
  static const String routeName = "/bottomNavIndividual";
  final int page;

  BottomNavigationIndividual({Key key, this.page}) : super(key: key);

  @override
  _BottomNavigationIndividualState createState() =>
      _BottomNavigationIndividualState();
}

class _BottomNavigationIndividualState extends State<BottomNavigationIndividual>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _page;
  GlobalKey _bottomNavigationKey = GlobalKey();
  FancyDrawerController _controller;
  DateTime currentBackPressTime;
  bool _isOn = false;
  File _image;
  bool isImageCaptured = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      _controller = FancyDrawerController(
          vsync: this, duration: Duration(milliseconds: 250))
        ..addListener(() {
          setState(() {}); // Must call setState
        });
    }
  }

  Future getImage() async {
    var image = null;

    image = await showDialog<File>(
        context: this.context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Constants.darkPrimary),
                  ),
                  onPressed: () async {
                    image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    Navigator.pop(context, image);
                  },
                ),
                FlatButton(
                  child: Text("Gallery"),
                  onPressed: () async {
                    image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    Navigator.pop(context, image);
                  },
                )
              ],
            ));

    //var image = await ImagePicker.pickImage(source: imageSource);

    if (image == null) return;

    File croppedfile = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxWidth: 512,
        maxHeight: 512,
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Constants.darkPrimary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _image = croppedfile;
    });
    setState(() {
      isImageCaptured = true;
      Fluttertoast.showToast(
          msg: "Image Uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Constants.darkPrimary,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    if (_image == null) return;
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
          builder: (BuildContext context) => BottomNavigationIndividual(
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
            controller: _controller,
            itemGap: 0,
            backgroundColor: Colors.white,
            drawerItems: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
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
              // ListTile(
              //   leading: Icon(
              //     Icons.accessibility_new,
              //     color: Constants.darkPrimary,
              //   ),
              //   title: Text(
              //     "Invite now",
              //     style: TextStyle(
              //         color: Constants.darkPrimary,
              //         fontWeight: FontWeight.bold),
              //   ),
              //   onTap: () async {
              //     Navigator.pushNamed(context, '/invitePage');
              //   },
              // ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Constants.darkPrimary,
                ),
                title: Row(mainAxisSize: MainAxisSize.min, children: [
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
                      builder: (ctx) => ManualUploadIndividual()));
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
                onTap: () {
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
              // ListTile(
              //   leading: Icon(
              //     Icons.group,
              //     color: Constants.darkPrimary,
              //   ),
              //   title: Text(
              //     "Create group",
              //     style: TextStyle(
              //         color: Constants.darkPrimary, fontWeight: FontWeight.bold),
              //   ),
              //   onTap: () async {},
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.info,
              //     color: Constants.darkPrimary,
              //   ),
              //   title: Text(
              //     "Request Info",
              //     style: TextStyle(
              //         color: Constants.darkPrimary, fontWeight: FontWeight.bold),
              //   ),
              //   onTap: () async {},
              // ),
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
                onTap: () async {},
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Upload activity",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  getImage().then((image) {
                    //call upload image api
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.more,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "My summary",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  // Navigator.pushNamed(context, '/summary');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CertificateAndReceipt()));
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
                  Icons.info,
                  color: Constants.darkPrimary,
                ),
                title: Text(
                  "Success Prediction",
                  style: TextStyle(
                      color: Constants.darkPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  _controller.close();
                  // Navigator.pushNamed(context, '/userManual');

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SuccessPrediction()));
                },
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
                onTap: () {
                  //clear login from sharedPrefs

                  print("individual_login" +
                      prefs.getBool('individual_login').toString());
                  print("individual_dashboard" +
                      prefs.getBool('individual_dashboard').toString());

                  if (prefs.getBool('individual_dashboard') != null) {
                    if (prefs.getBool('individual_dashboard')) {
                      Navigator.pushReplacementNamed(context, '/selectionpage');
                    } else {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/aboutUs'));
                      //after akshys undo
                      //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
                    }
                  } else {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/aboutUs'));
                    //after akshys undo
                    //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
                  }
                  prefs.setBool('individual_login', false);
                  prefs.setBool('individual_dashboard', false);
                },
              ),
            ],
            child: Scaffold(
                appBar: (false)
                    ? PreferredSize(
                        preferredSize: Size(0.0, 0.0),
                        child: Container(),
                      )
                    : AppBar(
                        leading: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _controller.toggle();
                          },
                        ),
                        title: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Ashva',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
                                  Navigator.pushNamed(
                                      context, '/editProfileIndividual');
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
                    DashBoardScreenIndividual(),
                    GetInspiredPageIndividual(),
                    // WorkoutPageIndividual(
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
                      CustomIcons.group,
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
        leading: Icon(
          Icons.notifications,
          color: Constants.darkPrimary,
        ),
        title: Row(children: [
          Text(
            "Notifications",
            style: TextStyle(
                color: Constants.darkPrimary, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Constants.darkPrimary,
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
              child: Center(
                  child: Text(
                "10",
                style: TextStyle(color: Colors.white, fontSize: 10),
              )),
            ),
          ),
          InkWell(
            child: CupertinoSwitch(
              activeColor: Constants.darkPrimary,
              value: _isOn,
              onChanged: (bool value) {
                setState(() {
                  _isOn = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                _isOn = !_isOn;
              });
            },
          ),
        ]),
        onTap: () async {},
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
        onTap: () {
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
      // ListTile(
      //   leading: Icon(
      //     Icons.group,
      //     color: Constants.darkPrimary,
      //   ),
      //   title: Text(
      //     "Create group",
      //     style: TextStyle(
      //         color: Constants.darkPrimary, fontWeight: FontWeight.bold),
      //   ),
      //   onTap: () async {},
      // ),
      // ListTile(
      //   leading: Icon(
      //     Icons.info,
      //     color: Constants.darkPrimary,
      //   ),
      //   title: Text(
      //     "Request Info",
      //     style: TextStyle(
      //         color: Constants.darkPrimary, fontWeight: FontWeight.bold),
      //   ),
      //   onTap: () async {},
      // ),
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
        onTap: () async {},
      ),
      ListTile(
        leading: Icon(
          Icons.camera_alt,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "Upload activity",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          getImage().then((image) {});
        },
      ),
      ListTile(
        leading: Icon(
          Icons.more,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "My summary",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          Navigator.pushNamed(context, '/summary');
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
          Icons.info,
          color: Constants.darkPrimary,
        ),
        title: Text(
          "User manual",
          style: TextStyle(
              color: Constants.darkPrimary, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          Navigator.pushNamed(context, '/userManual');
        },
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
        onTap: () {
          //clear login from sharedPrefs

          print("individual_login" +
              prefs.getBool('individual_login').toString());
          print("individual_dashboard" +
              prefs.getBool('individual_dashboard').toString());

          if (prefs.getBool('individual_dashboard') != null) {
            if (prefs.getBool('individual_dashboard')) {
              Navigator.pushReplacementNamed(context, '/selectionpage');
            } else {
              Navigator.popUntil(context, ModalRoute.withName('/aboutUs'));
              //after akshys undo
              //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
            }
          } else {
            Navigator.popUntil(context, ModalRoute.withName('/aboutUs'));
            //after akshys undo
            //Navigator.popUntil(context, ModalRoute.withName('/')); where / is initial route selection page
          }
          prefs.setBool('individual_login', false);
          prefs.setBool('individual_dashboard', false);
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

  Future<void> uploadImage(Map<String, dynamic> req) async {
    setState(() {
      // isLoading = true;
    });
    Map<String, dynamic> requestBody = {};
    Response response =
        await newHttpPostAuth(uri: uriList['uploadImage'], body: req);
    if (response.statusCode == 200) {
      setState(() {
        // isLoading = false;
        Fluttertoast.showToast(msg: "Image Uploaded succesfully");
      });
    }
  }
}
