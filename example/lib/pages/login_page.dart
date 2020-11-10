import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:ashva_fitness_example/utils/connectionStatusSingleton.dart';
import 'package:ashva_fitness_example/utils/config.dart';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obsureext = true, _isLogingIn;
  String _emailAddress, _password;

  bool isOffline = false, _loginStatus = false;
  String _token, _username;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';
  ConnectivityResult result;




  @override
  initState() {
    super.initState();

    print('Called initState');

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(connectionChanged);
  }

  _addLoginStatusToSF(bool status, String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loginStatus', status);
    prefs.setString('token', token);
    prefs.setString('username', username);
  }

//  _addAppTokenToSF() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('token', _token);
//  }

  void connectionChanged(dynamic hasConnection) {
    result = hasConnection;
    //print('Called on connection change hasConnection $result');

    setState(() {
      if (result == ConnectivityResult.none) {
        isOffline = true;
      } else {
        isOffline = false;
      }
      //print('Called on connection change isOffline $isOffline');
    });
  }

/*  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }*/

  Widget _showLogoImage() {
    return Center(
      child: Image.asset(
        "assets/img/ashvalogo.png",
        width: 250,
        height: 100,
      ),
    );
  }

  Widget _showWelcmeText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          "Welcome Back!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _showContinueText() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Center(
        child: Text(
          'Login to continue',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _showEmailAdressInput() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: TextFormField(
          controller: userNameController,
          onSaved: (val) => () {
            _emailAddress = val;
          },
          validator: (val) =>
              val.length == 0 ? "Please enter valid email" : null,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email Address",
            hintText: "Enter a valid email",
            icon: Icon(Icons.email, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: TextFormField(
        controller: passwordController,
        onSaved: (val) => _password = val,
        validator: (val) =>
            val.length == 0 ? "Please enter valid password" : null,
        obscureText: _obsureext,
        decoration: InputDecoration(
          suffix: GestureDetector(
            child: Icon(_obsureext ? Icons.visibility : Icons.visibility_off),
            onTap: () {
              setState(() {
                _obsureext = !_obsureext;
              });
            },
          ),
          labelText: "Password",
          hintText: "Enter password",
          icon: Icon(Icons.lock, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _showForgotButton() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            "Forgot password?",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _showLoginButton() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Center(
        child: _isLogingIn == true
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.pink[600]),
              )
            : RaisedButton(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Theme.of(context).primaryColor,
                onPressed: _loginBtnClicked,
              ),
      ),
    );
  }

  Widget _showNewUserButton() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: FlatButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
        child: Text(
          "New user? Sign up",
          style: TextStyle(
              color: Colors.pink[600],
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _showTermsServicesText() {
    return Text.rich(
      TextSpan(
        text:
            'By signing up you indicate that you have read and agreed to the Patch ',
        style: TextStyle(fontSize: 16),
        children: <TextSpan>[
          TextSpan(
              text: 'Terms of Services',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              )),
          // can add more TextSpans here...
        ],
      ),
    );
  }

  void _loginBtnClicked() {


    final form = _formKey.currentState;
    print('${form.validate()}');
    if (form.validate()) {
      form.save();
     // _loginUser();

      !isOffline ? _loginUser() : _showErrorSnackBar("Please check the network connectivity");

      !isOffline ? Navigator.pushReplacementNamed(context, '/dashboard') : _showErrorSnackBar("Please check the network connectivity");
    }
  }

  void _loginUser() async {
    setState(() {
      _isLogingIn = true;
    });

    Map data = {
      "audience": "string",
      "password": passwordController.text,
      "username": userNameController.text
    };
    //encode Map to JSON
    var body = json.encode(data);
    http.Response response = await http.post(configBaseURL + configAuthEndPoint,
        headers: configHeaders, body: body);

    setState(() {
      _isLogingIn = false;
    });

    final resposneData = json.decode(response.body);

    print("responseData $resposneData");

    if (response.statusCode == 200) {
      print('ABOUT TO LOGIN');
      _showSuccessSnackBar();
      _redirectUserToDashboard();
      setState(() {
        _loginStatus = true;
        _username = resposneData['username'];
        _token = resposneData['token'];
      });
      _addLoginStatusToSF(true, resposneData['username'], resposneData['token']);
    } else {
      setState(() {
        _loginStatus = false;
      });
      print("Failed ${response.statusCode}");
      setState(() {
        _isLogingIn = false;
      });

      if(response.statusCode == 404){
        _showErrorSnackBar("Invalid credentials");
      }else if(response.statusCode == 408){
        _showErrorSnackBar("Account locked, please contact admin");
      }else{
        _showErrorSnackBar("Server error, please try after some time");
      }
      //final String errorMsg = resposneData['message'];

    }
  }

  void _showSuccessSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        "Login successfully",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    _formKey.currentState.reset();
  }

  void _showErrorSnackBar(String errorMsg) {
    final snackBar = SnackBar(
      content: Text(
        errorMsg,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    //throw Exception('Error in login $errorMsg');
  }

  void _redirectUserToDashboard() {
    Navigator.pushReplacementNamed(context, '/tabspage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _showLogoImage(),
                _showWelcmeText(),
                _showContinueText(),
                _showEmailAdressInput(),
                _showPasswordInput(),
                _showForgotButton(),
                _showLoginButton(),
                _showNewUserButton(),
                _showTermsServicesText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
