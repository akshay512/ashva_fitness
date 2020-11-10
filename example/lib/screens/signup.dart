import 'dart:convert';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/widgets/dottedtext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../constants/staticText.dart';
import '../constants/staticText.dart';
import '../state/agreebtnstate.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AgreeCheckboxState>.value(
            value: AgreeCheckboxState())
      ],
      child: SignUpPageBody(),
    );
  }
}

class SignUpPageBody extends StatefulWidget {
  SignUpPageBody({Key key}) : super(key: key);

  @override
  _SignUpPageBodyState createState() => _SignUpPageBodyState();
}

class _SignUpPageBodyState extends State<SignUpPageBody> {
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name is not valid";
    }
    return null;
  }

  String validateLocation(String value) {
    String patttern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Location is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Location is not valid";
    }
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

  String validateConform(String value) {
    // String patttern = r'(^[a-zA-Z]*$)';
    // RegExp regExp = new RegExp(patttern);
    if (_password.text != _conform.text) {
      return "password does not match";
    }
    //  else if (!regExp.hasMatch(value)) {
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

  TextEditingController _password;
  TextEditingController _passwordEmp;

  TextEditingController _lname;
  TextEditingController _lnameFam;

  TextEditingController _conform;
  TextEditingController _conformEmp;

  TextEditingController _loc;
  double width, height;

  FocusNode _focusemail;
  FocusNode _focusfname;
  FocusNode _focuslname;
  FocusNode _focusloc;
  FocusNode _focuspassword;
  FocusNode _focuscon;

  FocusNode _focuspasswordEmp;
  FocusNode _focusconEmp;
  bool isYesorNo;
  bool autovalidate;

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autovalidate = false;
    _email = TextEditingController();
    _emailFam = TextEditingController();

    _firstname = TextEditingController();
    _firstnameFam = TextEditingController();

    _password = TextEditingController();

    _passwordEmp = TextEditingController();

    _lname = TextEditingController();
    _lnameFam = TextEditingController();

    _conform = TextEditingController();

    _conformEmp = TextEditingController();
    _loc = TextEditingController();
    _focusemail = FocusNode();
    _focusfname = FocusNode();
    _focuslname = FocusNode();
    _focusloc = FocusNode();
    isYesorNo = true;

    _focuspassword = FocusNode();
    _focuscon = FocusNode();

    _focuspasswordEmp = FocusNode();
    _focusconEmp = FocusNode();
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
                Hero(
                  tag: 'main-logo',
                  child: ShapeOfView(
                    width: width * 0.25,
                    height: height * 0.2,
                    shape: CircleShape(),
                    child: Image.asset('assets/Images/carrot.png'),
                    // child: Container(
                    //   width: width*0.2,
                    //   height: height*0.2,
                    //   child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU")),
                  ),
                ),

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
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white30),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Colors.white70))),
                          child: Row(
                            children: <Widget>[
                              Radio(
                                activeColor: Colors.white,
                                value: true,
                                onChanged: (val) {
                                  setState(() {
                                    isYesorNo = val;
                                  });
                                },
                                groupValue: isYesorNo,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.work,
                                      size: height * 0.1,
                                      color: (isYesorNo)
                                          ? Colors.white
                                          : Colors.white30),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Employee',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Colors.white70))),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: false,
                                activeColor: Colors.white,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {
                                    isYesorNo = val;
                                  });
                                },
                                groupValue: isYesorNo,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.person,
                                      size: height * 0.1,
                                      color: (!isYesorNo)
                                          ? Colors.white
                                          : Colors.white30),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Associate',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .015,
                ),
                isYesorNo
                    ?
                    //employee form
                    Column(
                        children: <Widget>[
                          TextFormField(
                            focusNode: _focusemail,
                            controller: _email,
                            validator: validateEmail,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
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
                              _fieldFocusChange(
                                  context, _focusemail, _focusfname);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: width * 0.4,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  validator: validateName,
                                  focusNode: _focusfname,
                                  controller: _firstname,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, _focusfname, _focuslname);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: width * 0.38,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  validator: validateName,
                                  focusNode: _focuslname,
                                  controller: _lname,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, _focuslname, _focusloc);
                                  },
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            validator: validatePassword,
                            focusNode: _focuspasswordEmp,
                            controller: _passwordEmp,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'password',
                              labelStyle: TextStyle(color: Colors.white70),
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
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            validator: validateConform,
                            focusNode: _focusconEmp,
                            controller: _conformEmp,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'conform password',
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
                          SizedBox(
                            height: height * .04,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            validator: validateLocation,
                            focusNode: _focusloc,
                            controller: _loc,
                            decoration: InputDecoration(
                              labelText: 'Select your Location',
                              labelStyle: TextStyle(color: Colors.white70),
                              suffixIcon: Icon(
                                CustomIcons.globe,
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
                      )
                    :
                    //employees family form
                    Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: width * 0.4,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  validator: validateName,
                                  focusNode: _focusfname,
                                  controller: _firstnameFam,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, _focusfname, _focuslname);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: width * 0.38,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  validator: validateName,
                                  focusNode: _focuslname,
                                  controller: _lnameFam,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white38),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, _focuslname, _focusloc);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            focusNode: _focusemail,
                            controller: _emailFam,
                            validator: validateEmail,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              labelText: 'Your Email',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, _focusemail, _focusfname);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            validator: validatePassword,
                            focusNode: _focuspassword,
                            controller: _password,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'password',
                              labelStyle: TextStyle(color: Colors.white70),
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
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            validator: validateConform,
                            focusNode: _focuscon,
                            controller: _conform,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'conform password',
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
                          SizedBox(
                            height: height * .04,
                          ),
                        ],
                      ),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  children: <Widget>[
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white30),
                      child: Checkbox(
                        value: state.checkboxValue,
                        onChanged: (value) {
                          state.checked(value);
                        },
                        activeColor: Colors.orange[700],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'I agree to the Terms & condions',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showtermsbottomsheet(context, state);
                        })
                  ],
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.3, vertical: height * 0.02),
                  onPressed: !isLoading
                      ? () async {
                          // setState(() {
                          //   autovalidate = true;
                          // Navigator.pushNamed(context, '/otpPage');
                          // });

                          if (_formKey.currentState.validate()) {
                            if (state.checkboxValue) {
                              setState(() {
                                isLoading = true;
                              });
                              Map<String, dynamic> reqBody = isYesorNo
                                  ? {
                                      "email": _email.text,
                                      "firstName": _firstname.text,
                                      "lastName": _lname.text,
                                      "location": _loc.text,
                                      "password": _passwordEmp.text
                                    }
                                  : {
                                      "email": _emailFam.text,
                                      "firstName": _firstnameFam.text,
                                      "lastName": _lnameFam.text,
                                      "password": _password.text
                                    };
                              await postSignUp(reqBody);

                              //handle api post here
                              // Navigator.pushNamed(context, '/otpPage');
                            } else {
                              // Scaffold.of(context).showSnackBar(SnackBar(
                              //     content: Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: <Widget>[
                              //     Text('Please agree for terms and condition')
                              //   ],
                              // )));
                              Fluttertoast.showToast(
                                  msg: "Please agree for terms and condition");
                            }
                          }
                        }
                      : () {},
                  color: Constants.darkPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: !isLoading
                      ? Text(
                          StaticText.buttontext["signupButton"],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('Already a user tapped');
                      },
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/loginPage');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                StaticText.buttontext["alreadyUser"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postSignUp(Map<String, dynamic> requestBody) async {
    try {
      Response response = await newHttpPost(
          uri: isYesorNo
              ? uriList['employeeSignup']
              : uriList['associateSignup'],
          body: requestBody);
      print(response);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacementNamed(context, '/loginPage');
        Fluttertoast.showToast(msg: "sign up sucessful");
      } else {
        Fluttertoast.showToast(
            msg: "sign up failed " + jsonDecode(response.body)['errorDesc']);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "sign up failed ");
      setState(() {
        isLoading = false;
      });
    }
    print("loading done for sign up");
  }
}
