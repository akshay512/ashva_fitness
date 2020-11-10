import 'dart:convert';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/model/dashBoardModel.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:ashva_fitness_example/state/editbtnstate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';

// class DailyChallengeState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<EditButtonState>.value(value: EditButtonState())
//       ],
//       child: DailyChallenge(),
//     );
//   }
// }

class DailyChallenge extends StatefulWidget {
  @override
  _DailyChallengeState createState() => _DailyChallengeState();
}

class _DailyChallengeState extends State<DailyChallenge> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double width, height;
  bool isedit;
  bool ischallengeadded;
  bool edit;
  DashBoardModel dashBoardModel;
  // TextEditingController _skping;
  // TextEditingController _jmpjk;
  // TextEditingController _squats;

  // TextEditingController _lunges;
  // TextEditingController _pushups;
  bool isLoading = false;
  List<DataColumn> columnlist = List();
  List<DataCell> datacells = List();
  List<DataCell> datacellsholder = List();
  Map<String, String> txtflds = new Map();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDashBoard();
    // .whenComplete(() => {
    //       dashBoardModel.challengeDetails
    //         ..forEach((element) {
    //           columnlist.add(DataColumn(
    //               label: Text(
    //             element.challengeName,
    //             style: TextStyle(color: Colors.white),
    //           )));
    //         })
    //     });
    // _skping = TextEditingController(text: '0');
    // _jmpjk = TextEditingController(text: '0');
    // _squats = TextEditingController(text: '0');
    // _lunges = TextEditingController(text: '0');
    // _pushups = TextEditingController(text: '0');
    isedit = false;
    ischallengeadded = false;
    edit = false;
  }

  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<EditButtonState>(context);

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Daily Challenge',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            dashBoardModel != null
                ? CircleAvatar(
                    backgroundColor: (edit)
                        ? Colors.blue.withOpacity(0.3)
                        : Colors.blue.withOpacity(0.2),
                    radius: 20,
                    child: IconButton(
                      icon: (edit)
                          ? Icon(Icons.done_outline)
                          : Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                          print(edit);
                        });
                      },
                    ),
                  )
                : Container(),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Constants.darkPrimary, Constants.lightPrimary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: (dashBoardModel != null &&
                    dashBoardModel.challengeDetails != null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ShapeOfView(
                        width: width * 0.35,
                        height: height * 0.2,
                        shape: StarShape(noOfPoints: 5),
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTy4H_j1cvmHMrISVyzSsaZkvsremhf2lBmqa8NzJmF2lxEsHh6&usqp=CAU"),
                      ),
                      Text(
                        'User Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DataTable(
                        columnSpacing: width * .05,
                        columns: columnlist,
                        // dashBoardModel.challengeDetails.map((e) {
                        //   return DataColumn(
                        //       label: Text(
                        //     e.challengeName,
                        //     style: TextStyle(color: Colors.white),
                        //   ));
                        // }),
                        // [
                        //   DataColumn(
                        //       label: Text(
                        //     "Skipping",
                        //     style: TextStyle(color: Colors.white),
                        //   )),
                        //   DataColumn(
                        //       label: Container(
                        //           width: 48,
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: <Widget>[
                        //               Text(
                        //                 "Jumping",
                        //                 style: TextStyle(color: Colors.white),
                        //               ),
                        //               Text(
                        //                 'Jacks',
                        //                 style: TextStyle(color: Colors.white),
                        //               )
                        //             ],
                        //           ))),
                        //   DataColumn(
                        //       label: Text(
                        //     "Squats",
                        //     style: TextStyle(color: Colors.white),
                        //   )),
                        //   DataColumn(
                        //       label: Text(
                        //     "Lunges",
                        //     style: TextStyle(color: Colors.white),
                        //   )),
                        //   DataColumn(
                        //       label: Text(
                        //     "Pushups",
                        //     style: TextStyle(color: Colors.white),
                        //   )),
                        // ],
                        rows: [
                          DataRow(
                            cells: (edit) ? datacells : datacellsholder,
                            // [
                            //   DataCell(Container(
                            //       child: (edit)
                            //           ? Container(
                            //               width: width * 0.1,
                            //               child: TextFormField(
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.w600),
                            //                 // validator: validateName,
                            //                 // focusNode: _fnamefocus,
                            //                 controller: _skping,
                            //                 keyboardType: TextInputType.number,
                            //                 decoration: InputDecoration(
                            //                   // labelText: 'skiping val',
                            //                   // labelStyle:
                            //                   //     TextStyle(color: Colors.white70),
                            //                   enabledBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white38),
                            //                   ),
                            //                   focusedBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white),
                            //                   ),
                            //                 ),
                            //                 // onFieldSubmitted: (term) {
                            //                 //   _fieldFocusChange(
                            //                 //       context, _fnamefocus, _lnamefocus);
                            //                 // },
                            //                 textAlign: TextAlign.center,
                            //               ),
                            //             )
                            //           : Center(
                            //               child: Text(
                            //               _skping.text,
                            //               style:
                            //                   TextStyle(color: Colors.white54),
                            //             )))),
                            //   DataCell(Container(
                            //       child: (edit)
                            //           ? Container(
                            //               width: width * 0.1,
                            //               child: TextFormField(
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.w600),
                            //                 // validator: validateName,
                            //                 // focusNode: _fnamefocus,
                            //                 controller: _jmpjk,
                            //                 keyboardType: TextInputType.number,
                            //                 decoration: InputDecoration(
                            //                   // labelText: 'skiping val',
                            //                   // labelStyle:
                            //                   //     TextStyle(color: Colors.white70),
                            //                   enabledBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white38),
                            //                   ),
                            //                   focusedBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white),
                            //                   ),
                            //                 ),
                            //                 // onFieldSubmitted: (term) {
                            //                 //   _fieldFocusChange(
                            //                 //       context, _fnamefocus, _lnamefocus);
                            //                 // },
                            //                 textAlign: TextAlign.center,
                            //               ),
                            //             )
                            //           : Center(
                            //               child: Text(
                            //               _jmpjk.text,
                            //               style:
                            //                   TextStyle(color: Colors.white54),
                            //             )))),
                            //   DataCell(Container(
                            //       child: (edit)
                            //           ? Container(
                            //               width: width * 0.1,
                            //               child: TextFormField(
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.w600),
                            //                 // validator: validateName,
                            //                 // focusNode: _fnamefocus,
                            //                 controller: _squats,
                            //                 keyboardType: TextInputType.number,
                            //                 decoration: InputDecoration(
                            //                   // labelText: 'skiping val',
                            //                   // labelStyle:
                            //                   //     TextStyle(color: Colors.white70),
                            //                   enabledBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white38),
                            //                   ),
                            //                   focusedBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white),
                            //                   ),
                            //                 ),
                            //                 // onFieldSubmitted: (term) {
                            //                 //   _fieldFocusChange(
                            //                 //       context, _fnamefocus, _lnamefocus);
                            //                 // },
                            //                 textAlign: TextAlign.center,
                            //               ),
                            //             )
                            //           : Center(
                            //               child: Text(
                            //               _squats.text,
                            //               style:
                            //                   TextStyle(color: Colors.white54),
                            //             )))),
                            //   DataCell(Container(
                            //       child: (edit)
                            //           ? Container(
                            //               width: width * 0.1,
                            //               child: TextFormField(
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.w600),
                            //                 // validator: validateName,
                            //                 // focusNode: _fnamefocus,
                            //                 controller: _lunges,
                            //                 keyboardType: TextInputType.number,
                            //                 decoration: InputDecoration(
                            //                   // labelText: 'skiping val',
                            //                   // labelStyle:
                            //                   //     TextStyle(color: Colors.white70),
                            //                   enabledBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white38),
                            //                   ),
                            //                   focusedBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white),
                            //                   ),
                            //                 ),
                            //                 // onFieldSubmitted: (term) {
                            //                 //   _fieldFocusChange(
                            //                 //       context, _fnamefocus, _lnamefocus);
                            //                 // },
                            //                 textAlign: TextAlign.center,
                            //               ),
                            //             )
                            //           : Center(
                            //               child: Text(
                            //               _lunges.text,
                            //               style:
                            //                   TextStyle(color: Colors.white54),
                            //             )))),
                            //   DataCell(Container(
                            //       child: (edit)
                            //           ? Container(
                            //               width: width * 0.1,
                            //               child: TextFormField(
                            //                 style: TextStyle(
                            //                     color: Colors.white,
                            //                     fontWeight: FontWeight.w600),
                            //                 // validator: validateName,
                            //                 // focusNode: _fnamefocus,
                            //                 controller: _pushups,
                            //                 keyboardType: TextInputType.number,
                            //                 decoration: InputDecoration(
                            //                   // labelText: 'skiping val',
                            //                   // labelStyle:
                            //                   //     TextStyle(color: Colors.white70),
                            //                   enabledBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white38),
                            //                   ),
                            //                   focusedBorder:
                            //                       UnderlineInputBorder(
                            //                     borderSide: BorderSide(
                            //                         color: Colors.white),
                            //                   ),
                            //                 ),
                            //                 // onFieldSubmitted: (term) {
                            //                 //   _fieldFocusChange(
                            //                 //       context, _fnamefocus, _lnamefocus);
                            //                 // },
                            //                 textAlign: TextAlign.center,
                            //               ),
                            //             )
                            //           : Center(
                            //               child: Text(
                            //               _pushups.text,
                            //               style:
                            //                   TextStyle(color: Colors.white54),
                            //             )))),
                            // ],
                          ),
                          // DataRow(cells: [DataCell(Text("2")),
                          // DataCell(Text("asc-cell2"))
                          //   ,]),
                        ],
                        sortColumnIndex: 0,
                      ),
                      RaisedButton(
                        color: Constants.darkPrimary,
                        onPressed:
                            // (_pushups.text != "0" &&
                            //         _skping.text != "0" &&
                            //         _lunges.text != "0" &&
                            //         _jmpjk.text != "0" &&
                            //         _squats.text != "0")
                            //     ?
                            () async {
                          print(txtflds);
                          // await updateChallengeScore({

                          // });
                        },
                        // : null,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ));
  }

  Future<void> getAllChallenges() async {
    try {
      List challenges = [];
      Response response =
          await newHttpGetAuth(uri: uriList['getAllChallenges']);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          print(response.body);
          challenges = jsonDecode(response.body);
          print(challenges);
        });
      }
    } catch (e) {
      print(e);
    }
    print("loading done for sign up");
  }

  Future<void> getDashBoard() async {
    Map<String, dynamic> requestBody = {};
    Response response =
        await newHttpPostAuth(uri: uriList['getDashBoardDetails'], body: {});
    setState(() {
      dashBoardModel = DashBoardModel.fromJson(json.decode(response.body));
    });

    //akshay check this out
    //challengeDetails objects has challenge id ,name,score
    print("list of challengeDetails objects for akshays ui---->" +
        dashBoardModel.challengeDetails.toString());

    dashBoardModel.challengeDetails
      ..forEach((element) {
        txtflds[element.challengeName.toString()] =
            element.challengeScore.toString();
        columnlist.add(DataColumn(
            label: Text(
          element.challengeName.toString(),
          style: TextStyle(color: Colors.white),
        )));
      });

    dashBoardModel.challengeDetails.forEach((element) async {
      datacells.add(
        DataCell(Container(
            child: Container(
          width: width * 0.1,
          child: TextFormField(
            initialValue: element.challengeScore.toString(),
            // enabled: edit ? true : false,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            // validator: validateName,
            // focusNode: _fnamefocus,
            // controller: _skping,

            onChanged: (val) {
              txtflds[element.challengeName.toString()] = val;
              print(txtflds[element.challengeName.toString()]);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              // labelText: 'skiping val',
              // labelStyle:
              //     TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            // onFieldSubmitted: (term) {
            //   _fieldFocusChange(
            //       context, _fnamefocus, _lnamefocus);
            // },
            textAlign: TextAlign.center,
          ),
        ))),
      );
    });

    dashBoardModel.challengeDetails.forEach((element) async {
      datacellsholder.add(
        DataCell(Container(
            child: Center(
                child: Text(
          element.challengeScore.toString(),
          style: TextStyle(color: Colors.white54),
        )))),
      );
    });
  }

  Future<void> updateChallengeScore(Map<String, dynamic> reqBody) async {
    Map<String, dynamic> requestBody = {};
    Response response = await newHttpPostAuth(
        uri: uriList['updateUserChallenge'], body: reqBody);

    print("loading done ! inside getDashBoard");
  }
}
