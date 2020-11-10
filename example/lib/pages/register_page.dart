import 'package:ashva_fitness_example/utils/config.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _radioValue = 0;
  bool _checkBoxValue = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _corporateName,
      _firstName,
      _lastName,
      _emailAddress,
      _password,
      _confirmPassword,
      _mobileNumber;
  bool _obsureextPwd = true, _obsureextCnf = true, _isRegistering;

  bool isOffline = false;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';
  ConnectivityResult result;

  @override
  initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    result = hasConnection;
    //print('Called on connection change hasConnection $result');
    setState(() {
      if (result == ConnectivityResult.none) {
        isOffline = true;
      } else {
        isOffline = false;
      }
      print('Called on connection change isOffline $isOffline');
    });
  }

  void _handleRadioValueChange(int value) {
    print('handleRadioValueChange value $value');
    setState(() {
      _radioValue = value;
    });
  }

  void _agreedTermsConditions(bool value) {
    print('_agreedTermsConditions value $value');
    setState(() {
      _checkBoxValue = value;
    });
  }

  Widget _showRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: 0,
          activeColor: Colors.pink[600],
          groupValue: _radioValue,
          onChanged: _handleRadioValueChange,
        ),
        new Text(
          'Corporate',
          style: new TextStyle(fontSize: 16.0, color: Colors.pink[600]),
        ),
        new Radio(
          activeColor: Colors.pink[600],
          value: 1,
          groupValue: _radioValue,
          onChanged: _handleRadioValueChange,
        ),
        new Text(
          'Individual',
          style: new TextStyle(fontSize: 16.0, color: Colors.pink[600]),
        ),
      ],
    );
  }

  Widget _showPageTitle() {
    return Center(
        child: Text("Register",
            style: TextStyle(
                fontSize: 24,
                color: Colors.pink[600],
                fontWeight: FontWeight.normal)));
  }

  Widget _showCorporateInput() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: TextFormField(
        onSaved: (val) => _corporateName = val,
        validator: (val) =>
            !val.contains("Mindtree") ? 'Corporate does not registered' : null,
        decoration: InputDecoration(
          labelText: "Corporate Name",
          hintText: "Enter corporate name",
          icon: Icon(Icons.account_balance, color: Colors.grey),
        ),
      ),
    );
  }

  List<String> _colors = <String>[
    '',
    'Company',
    'Accenture',
    'Microsoft',
    'Google'
  ];
  String _color = '';

  Widget _showCorporateList() {
    return FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.account_balance),
            labelText: 'Corporate Name',
          ),
          isEmpty: _color == '',
          child: Container(
            width: 150.0,
            child: new DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: new DropdownButton(
                  isExpanded: true,
                  value: _color,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _corporateName = newValue;
                      _color = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _colors.map((String value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _showFirstNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: TextFormField(
        onSaved: (val) => _firstName = val,
        validator: (val) =>
            val.length == 0 ? "Please enter valid first name" : null,
        decoration: InputDecoration(
          labelText: "First Name",
          hintText: "Enter first name",
          icon: Icon(Icons.perm_identity, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _showLastNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: TextFormField(
        onSaved: (val) => _lastName = val,
        validator: (val) =>
            val.length == 0 ? "Please enter valid last name" : null,
        decoration: InputDecoration(
          labelText: "Last Name",
          hintText: "Enter last name",
          icon: Icon(Icons.person, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _showEmailAddressInput() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: TextFormField(
        onSaved: (val) => _emailAddress = val,
        validator: (val) =>
            !val.contains('@') ? "Please enter valid email" : null,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email Address",
          hintText: "Enter a valid email",
          icon: Icon(Icons.email, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _showMobileNumber() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: TextFormField(
        onSaved: (val) => _mobileNumber = val,
        validator: (val) =>
            val.length != 10 ? "Please enter valid mobile number" : null,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          labelText: "Mobile",
          hintText: "Enter valid mobile number",
          icon: Icon(Icons.phone, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: TextFormField(
        onSaved: (val) => _password = val,
        validator: (val) =>
            val.length < 6 ? "Please enter min 6 character password" : null,
        obscureText: _obsureextPwd,
        decoration: InputDecoration(
          suffix: GestureDetector(
            child:
                Icon(_obsureextPwd ? Icons.visibility : Icons.visibility_off),
            onTap: () {
              setState(() {
                _obsureextPwd = !_obsureextPwd;
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

  Widget _showConfirmPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: TextFormField(
        onSaved: (val) => _confirmPassword = val,
        // validator: (val) => val != _password ? "Password not matched" : null,
        obscureText: _obsureextCnf,
        decoration: InputDecoration(
          suffix: GestureDetector(
            child:
                Icon(_obsureextCnf ? Icons.visibility : Icons.visibility_off),
            onTap: () {
              setState(() {
                _obsureextCnf = !_obsureextCnf;
              });
            },
          ),
          labelText: "Confirm Password",
          hintText: "Enter confirm password",
          icon: Icon(Icons.lock, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _showContinueButon() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _isRegistering == true
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pink[600]),
                )
              : RaisedButton(
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Theme.of(context).primaryColor,
                  onPressed: _continueRegistration,
                )
        ],
      ),
    );
  }

  Widget _showTermsConditionsTexts() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _checkBoxValue,
          activeColor: Colors.pink[600],
          onChanged: _agreedTermsConditions,
        ),
        GestureDetector(
          onTap: () => print("open terms and conditions page"),
          child: Text.rich(
            TextSpan(
              text: 'I agree to the ',
              style: TextStyle(fontSize: 13),
              children: <TextSpan>[
                TextSpan(
                    text: 'Terms & Conditions \n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    )),
                TextSpan(
                    text: '& Privacy Policies',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    )),
                // can add more TextSpans here...
              ],
            ),
          ),
        )
      ],
    );
  }

  void _continueRegistration() {
    print("_continueRegistration");

    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      //!isOffline ? _registerUser()  : _showErrorSnackBar("Please check the network connectivity");

      _registerUser();
      print(
          "Corporate name $_corporateName, First name $_firstName, Last name $_lastName, Email address $_emailAddress, Passeord $_password, Confirm password $_confirmPassword");
    }
  }

  void _registerUser() async {
    if (_checkBoxValue == true) {
      if (!isOffline) {
        setState(() {
          _isRegistering = true;
        });

        Map data = {
          "associateType": "string",
          "contact": "string",
          "corporateName": _corporateName,
          "emailAddress": _emailAddress,
          "firstName": _firstName,
          "lastName": _lastName,
          "loginAccountStatus": "string",
          "mobileNumber": _mobileNumber,
          "password": _password,
          "role": "string",
          "roleId": "string",
          "status": "string",
          "tenantId": 0,
          "tenantName": "string",
          "userId": "string"
        };
        //encode Map to JSON
        var body = json.encode(data);
        http.Response response = await http.post(
            configBaseURL + configRegistrationEndPoint,
            headers: configHeaders,
            body: body);

        setState(() {
          _isRegistering = false;
        });

        final resposneData = json.decode(response.body);
        if (response.statusCode == 200) {
          print("responseData $resposneData");
          _showSuccessSnackBar();
          _redirectUserToDashboard();
        } else {
          setState(() {
            _isRegistering = false;
          });
          final String errorMsg = resposneData['message'];
          _showErrorSnackBar(errorMsg);
          //_showErrorSnackBar();
        }
      } else {


        final String errorMsg = "Please check the network connectivity";
        _showErrorSnackBar(errorMsg);


      }
    } else {
      final String errorMsg = "Please read & accept Terms and Conditions";
      _showErrorSnackBar(errorMsg);
    }
  }

  void _showSuccessSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        "User $_firstName successfully created",
        style: TextStyle(color: Colors.green, fontSize: 18),
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
  }

  void _redirectUserToDashboard() {
    Navigator.pushReplacementNamed(context, '/login');
  }


  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text("Register"),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          )),
      body:

      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child:

        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _showRadioButtons(),
                _radioValue == 0 ? _showCorporateInput() : SizedBox.shrink(),
                _showFirstNameInput(),
                _showLastNameInput(),
                _showEmailAddressInput(),
                _showMobileNumber(),
                _showPasswordInput(),
                _showConfirmPasswordInput(),
                _showContinueButon(),
                SizedBox(
                  height: 10,
                ),
                _showTermsConditionsTexts()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
