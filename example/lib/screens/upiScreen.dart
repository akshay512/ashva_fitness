import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/constants/staticText.dart';
import 'package:ashva_fitness_example/widgets/paymentpage.dart';
import 'package:flutter/material.dart';

class UpiScreen extends StatefulWidget {
  final amount;

  const UpiScreen({Key key, this.amount}) : super(key: key);
  @override
  _UpiScreenState createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen> {
  double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text("Payment"),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding:
              EdgeInsets.only(top: 0, left: width * 0.05, right: width * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Constants.darkPrimary, Constants.lightPrimary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: UpiWidget(
            amount: widget.amount,
          )),
      // body: Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   // padding:
      //   //     EdgeInsets.only(top: 80, left: width * 0.05, right: width * 0.05),
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [Constants.darkPrimary, Constants.lightPrimary],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter),
      //   ),
      //   child: Column(children: [
      //     Padding(
      //       padding: const EdgeInsets.only(top: 20.0),
      //       child: Text(
      //         "Total amount to be paid Rs " + widget.amount.toString(),
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     RaisedButton(
      //       padding: EdgeInsets.symmetric(vertical: height * 0.02),
      //       onPressed: () {
      //         //go to begginer intermediate screen
      //         Navigator.of(context).pushNamed('/selectlevel');
      //       },
      //       color: Constants.darkPrimary,
      //       shape:
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //       child: Container(
      //         width: width * 0.8,
      //         child: Center(
      //           child: Text(
      //             'PAY ${widget.amount}',
      //             style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 17,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ]),
      // ),
    );
  }
}
