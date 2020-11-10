import 'dart:convert';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/widgets/dottedtext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/staticText.dart';
import '../state/agreebtnstate.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AgreeCheckboxState>.value(
            value: AgreeCheckboxState())
      ],
      child: LoginPageBody(),
    );
  }
}

class LoginPageBody extends StatefulWidget {
  LoginPageBody({Key key}) : super(key: key);

  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    // String patttern = r'(^[a-zA-Z]*$)';
    // RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "password is Required";
    }
    // else if (!regExp.hasMatch(value)) {
    //   return "Location is not valid";
    // }
    return null;
  }

  List<String> termsandcondtn = [
    'Contribute to 2 million steps target worldwide.',
    'Become fit and get recognition for your contributions',
    'Get trained by a professional trainer',
    'Rewards are just some plans away for you'
  ];

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _email;
  TextEditingController _emailFam;

  TextEditingController _firstname;
  TextEditingController _firstnameFam;

  TextEditingController _lname;
  TextEditingController _lnameFam;

  TextEditingController _loc;
  double width, height;

  FocusNode _focusemail;
  FocusNode _focusfname;
  FocusNode _focuslname;
  FocusNode _focusloc;

  bool isLoading = false;

  bool isYesorNo;
  bool autovalidate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autovalidate = false;
    _email = TextEditingController();
    _emailFam = TextEditingController();

    _firstname = TextEditingController();
    _firstnameFam = TextEditingController();

    _lname = TextEditingController();

    _lnameFam = TextEditingController();
    _loc = TextEditingController();
    _focusemail = FocusNode();
    _focusfname = FocusNode();
    _focuslname = FocusNode();
    _focusloc = FocusNode();
    isYesorNo = true;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  showtermsbottomsheet(BuildContext context, AgreeCheckboxState state) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // SizedBox(height: 10,),
                  // Container(width: width*0.25,
                  // height: 10,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(40),
                  //   color: Colors.orange[200]
                  // ),),
                  // SizedBox(height: height*.08,),
                  Container(
                    height: height * 0.1,
                    width: width,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(0, 0),
                          child: Container(
                            width: width * 0.25,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.orange[200]),
                          ),
                        ),
                        Align(
                          alignment: Alignment(.9, 1),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: ClipOval(
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Color(0xFFEFEFEF),
                                    child: Icon(
                                      CustomIcons.close,
                                      color: Colors.orange.shade400,
                                      size: 14,
                                    ))),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .09,
                  ),
                  Text(
                    'The Terms & conditions',
                    style: TextStyle(color: Colors.orange[800], fontSize: 17),
                  ),
                  SizedBox(
                    height: height * .06,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                    height: height * 0.3,
                    child: ListView.builder(
                        itemCount: termsandcondtn.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DottedText(
                              termsandcondtn[index],
                              style: TextStyle(
                                color: Constants.darkPrimary,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: height * .1),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                        value: state.checkboxValue,
                        onChanged: (value) {
                          setState(() {
                            state.checked(value);
                          });
                        },
                        activeColor: Colors.orange[700],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'I agree to the Terms & condions',
                        style: TextStyle(color: Colors.orange, fontSize: 14),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                  )
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AgreeCheckboxState>(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Ashva',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:
            EdgeInsets.only(top: 80, left: width * 0.05, right: width * 0.05),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Constants.darkPrimary, Constants.lightPrimary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Form(
          autovalidate: autovalidate,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Center(
                //     child: Text(
                //   'Hello!',
                //   style: TextStyle(fontSize: 22, color: Colors.white),
                // )),
                // Center(
                //   child: Text(
                //     'Are you a member',
                //     style: TextStyle(fontSize: 22, color: Colors.white),
                //   ),
                // ),
                Container(
                  height: MediaQuery.of(context).size.height * .23,
                  width: MediaQuery.of(context).size.width * .23,
                  child: Image.asset('assets/Images/carrot.png'),
                ),
                SizedBox(
                  height: 25,
                ),

                //employee form
                Column(
                  children: <Widget>[
                    TextFormField(
                      focusNode: _focusemail,
                      controller: _email,
                      validator: validateEmail,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        labelText: 'Your Email ID/AshvaID ',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _focusemail, _focusfname);
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: height * .0,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      validator: validatePassword,
                      focusNode: _focusloc,
                      controller: _loc,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white70),
                        suffixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      onFieldSubmitted: (term) {
                        _focusloc.unfocus();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('forgot password tapped');
                      },
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                          onTap: () async {
                            // Navigator.pushNamed(context, '/loginPage');
                            // prefs = await SharedPreferences.getInstance();
                            // await prefs.setBool('corporate_login', true);
                            // print("corporate login state set" +
                            //     prefs.get('corporate_login'));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Forgot password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Icon(
                                Icons.help,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),

                RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.3, vertical: height * 0.02),
                  onPressed: !isLoading
                      ? () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await postLogin({
                              "password": _loc.text,
                              "username": _email.text
                            });

                            // Navigator.pushReplacementNamed(context, '/bottomNav');
                          }
                        }
                      : () {},
                  color: Constants.darkPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: !isLoading
                      ? Text(
                          StaticText.buttontext["logininButton"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )
                      : CircularProgressIndicator(),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.3, vertical: height * 0.02),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signUpPage');
                  },
                  color: Constants.darkPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postLogin(Map<String, dynamic> requestBody) async {
    try {
      Response response =
          await newHttpPost(uri: uriList['employeeAuth'], body: requestBody);
      Map<String, dynamic> responseBody = json.decode(response.body);

      prefs.setBool('corporate_login', true);
      prefs.setString('auth_token', responseBody['token']);
      print("corporate login state set" +
          prefs.get('corporate_login').toString());
      print("auth token set" + prefs.get('auth_token'));

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacementNamed(context, '/bottomNav');
        Fluttertoast.showToast(msg: "Login sucessful");
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: responseBody['errorDesc']);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "login up failed");
      setState(() {
        isLoading = false;
      });
    }
    print("loading done for login up");
  }
}
