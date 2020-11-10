import 'dart:math';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:upi_pay/upi_pay.dart';

class UpiWidget extends StatefulWidget {
  final amount;

  const UpiWidget({Key key, this.amount}) : super(key: key);
  @override
  _UpiWidgetState createState() => _UpiWidgetState();
}

class _UpiWidgetState extends State<UpiWidget> {
  String _upiAddrError;
  double width, height;
  bool islengthzero = false;
  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isUpiEditable = false;
  Future<List<ApplicationMeta>> _appsFuture;
  UpiTransactionResponse upiTransactionResponse;
  @override
  void initState() {
    super.initState();

    _amountController.text =
        (Random.secure().nextDouble() * 10).toStringAsFixed(2);
    _appsFuture = UpiPay.getInstalledUpiApplications();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _upiAddressController.dispose();
    super.dispose();
  }

  void _generateAmount() {
    setState(() {
      _amountController.text =
          (Random.secure().nextDouble() * 10).toStringAsFixed(2);
    });
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final err = _validateUpiAddress(_upiAddressController.text);
    if (err != null) {
      setState(() {
        _upiAddrError = err;
      });
      return;
    }
    setState(() {
      _upiAddrError = null;
    });

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    print("Starting transaction with id $transactionRef");

    final a = await UpiPay.initiateTransaction(
      amount: _amountController.text,
      app: app.upiApplication,
      receiverName: 'Sharad',
      receiverUpiAddress: _upiAddressController.text,
      transactionRef: transactionRef,
      merchantCode: '7372',
    );

    print(a);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "Total amount to be paid Rs " + widget.amount.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // if (_upiAddrError != null)
          //   Container(
          //     margin: EdgeInsets.only(top: 4, left: 12),
          //     child: Text(
          //       _upiAddrError,
          //       style: TextStyle(color: Colors.red),
          //     ),
          //   ),
          // Container(
          //   margin: EdgeInsets.only(top: 32),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: TextField(
          //           controller: _amountController,
          //           readOnly: true,
          //           enabled: false,
          //           decoration: InputDecoration(
          //             border: OutlineInputBorder(),
          //             labelText: 'Amount',
          //           ),
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.only(left: 8),
          //         child: IconButton(
          //           icon: Icon(Icons.loop),
          //           onPressed: _generateAmount,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 128, bottom: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: (islengthzero)
                      ? Text('')
                      : Text(
                          'Pay Using',
                          style: Theme.of(context).textTheme.caption,
                        ),
                ),
                FutureBuilder<List<ApplicationMeta>>(
                  future: _appsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container();
                    }
                    if (snapshot.data.length == 0) {
                      SchedulerBinding.instance
                          .addPostFrameCallback((_) => setState(() {
                                islengthzero = true;
                              }));
                    }

                    return snapshot.data.length == 0
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.2,
                              ),
                              Center(
                                  child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    "please install any of the upi payment apps",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              )),
                            ],
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1.6,
                            physics: NeverScrollableScrollPhysics(),
                            children: snapshot.data
                                .map((it) => Material(
                                      key: ObjectKey(it.upiApplication),
                                      color: Colors.grey[200],
                                      child: InkWell(
                                        onTap: () async {
                                          UpiPay.initiateTransaction(

                                                  /// must be a string value of two decimal digits
                                                  amount: "1.00",

                                                  /// UpiApplication class has all the supported applications
                                                  /// only accepts a value from the UpiApplication class
                                                  app: it.upiApplication,

                                                  /// Name of the person / merchant receiving the payment
                                                  receiverName: "shashan",

                                                  /// UPI VPA of the person / merchant receiving the payment
                                                  receiverUpiAddress:
                                                      "shashanmave-1@okaxis",

                                                  /// unique ID for the transaction
                                                  /// use your business / use case specific ID generation logic here
                                                  transactionRef: 'ORD1215236',

                                                  /// there are some other optional parameters like
                                                  /// [url], [merchantCode] and [transactionNode]

                                                  /// url can be used share some additional data related to the transaction like invoice copy, etc.
                                                  url:
                                                      'www.johnshop.com/order/ORD1215236',

                                                  /// this is code that identifies the type of the merchant
                                                  /// if you have a merchant UPI VPA as the receiver address
                                                  /// add the relevant merchant code for seamless payment experience
                                                  /// some application may reject payment intent if merchant code is missing
                                                  /// when making a P2M (payment to merchant VPA) transaction
                                                  // merchantCode: 1032,

                                                  /// anything that provides some desription of the transaction
                                                  transactionNote:
                                                      'Test transaction')
                                              .then((response) {
                                            print("raw response-->" +
                                                response.rawResponse +
                                                "\n payment status-->" +
                                                response.status.toString() +
                                                "\n aproval ref --->" +
                                                response.approvalRefNo
                                                    .toString());
                                            //rout if payment successful and post payment details
                                            if (response.status ==
                                                UpiTransactionStatus.failure) {
                                              print(
                                                  "Transaction falied please try again");
                                            }
                                            Navigator.of(context)
                                                .pushNamed('/selectlevel');
                                          });
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.memory(
                                              it.icon,
                                              width: 64,
                                              height: 64,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 4),
                                              child: Text(
                                                it.upiApplication.getAppName(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String _validateUpiAddress(String value) {
  if (value.isEmpty) {
    return 'UPI Address is required.';
  }

  if (!UpiPay.checkIfUpiAddressIsValid(value)) {
    return 'UPI Address is invalid.';
  }

  return null;
}
