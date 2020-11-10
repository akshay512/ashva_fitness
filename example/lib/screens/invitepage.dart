import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share/share.dart';

class InvitePage extends StatefulWidget {
  static const String routeName = "/invitepage";

  InvitePage({Key key}) : super(key: key);

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  double width, height;
  int count = 1;
  bool autovalidate;
  List<Widget> list = new List();
  Map<int, String> txtflds = new Map();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autovalidate = false;
    list.add(
      TextFormField(
        validator: validateEmail,
        onChanged: (val) {
          int temp = count;
          txtflds[temp] = val;
          print(txtflds[temp]);
        },
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          labelText: 'Enter Email ID',
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Ashva',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: height,
        padding: EdgeInsets.only(left: 20, right: 20, top: 70),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Constants.lightPrimary, Constants.darkPrimary],
          begin: Alignment.bottomCenter,
        )),
        child: SingleChildScrollView(
          child: Form(
            autovalidate: autovalidate,
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                    child: Text(
                  'Start inviting people..',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                )),
                SizedBox(
                  height: height * 0.02,
                ),
                Icon(
                  CustomIcons.add_user,
                  color: Colors.white38,
                  size: height * 0.1,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.4,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Widget widget = list.elementAt(index);
                      return widget;
                    },
                    itemCount: list.length,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.2, vertical: height * 0.02),
                  onPressed: () async {
                    print(txtflds);
                    setState(() {
                      autovalidate = true;
                    });
                    if (_formKey.currentState.validate()) {
                      final Email email = Email(
                        body: 'Welcome to the awesome Ashva app',
                        subject: 'The Ashva Fitness App',
                        recipients: txtflds.values.toList(),
                      );

                      await FlutterEmailSender.send(email);
                    }
                  },
                  color: Constants.lightPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'SEND INVITES',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .015,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.2, vertical: height * 0.02),
                  onPressed: () {},
                  color: Constants.lightPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Not now, maybe later',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange[700],
          child: Icon(Icons.add),
          onPressed: () {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
            int temp = ++count;
            setState(() {
              //val.add('txt${++count}');
              int index = list.length;
              list.add(
                TextFormField(
                  validator: validateEmail,
                  onChanged: (val) {
                    txtflds[temp] = val;
                    print(txtflds[temp]);
                  },
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: 'Enter Email ID',
                    labelStyle: TextStyle(color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print(count - 1);
                        print(list.length);
                        setState(() {
                          (list.length != 2)
                              ? list.removeAt(index)
                              : list.removeAt(1);
                        });
                      },
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              );
            });
          }),
    );
  }
}
