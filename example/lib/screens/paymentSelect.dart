import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/screens/upiScreen.dart';
import 'package:ashva_fitness_example/widgets/Facts.dart';
import 'package:ashva_fitness_example/widgets/taxDialog.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/agreebtnstate.dart';

class PaymentSelect extends StatelessWidget {
  static const String routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AgreeCheckboxState>.value(
            value: AgreeCheckboxState())
      ],
      child: PaymentSelectBody(),
    );
  }
}

class PaymentSelectBody extends StatefulWidget {
  PaymentSelectBody({Key key}) : super(key: key);

  @override
  _PaymentSelectBodyState createState() => _PaymentSelectBodyState();
}

class _PaymentSelectBodyState extends State<PaymentSelectBody> {
  double width, height;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AgreeCheckboxState>(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text("Payment"),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Choose Membership",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * .5,
                          child: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RaisedButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.02),
                                      onPressed: () {
                                        //get in as corporate
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm"),
                                              content: Text(
                                                  "Are you sure you want to continue?"),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("Confirm"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpiScreen(
                                                                amount: 2000,
                                                              )),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      color: Constants.darkPrimary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        width: width * 0.7,
                                        child: Center(
                                          child: Text(
                                            '6 Month - 2K',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.info,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          //set tax info dialog

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                TaxDialog(
                                              description: "Professor",
                                              buttonText: "Okay",
                                            ),
                                          );
                                        })
                                  ]),
                              SizedBox(
                                height: height * .05,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RaisedButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.02),
                                      onPressed: () {
                                        //get in as corporate
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => UpiScreen(
                                                    amount: 2000,
                                                  )),
                                        );
                                      },
                                      color: Constants.darkPrimary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        width: width * 0.7,
                                        child: Center(
                                          child: Text(
                                            '1 Year - 4K',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.info,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          //set tax info dialog

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                TaxDialog(
                                              description: "Professor",
                                              buttonText: "Okay",
                                            ),
                                          );
                                        })
                                  ]),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
