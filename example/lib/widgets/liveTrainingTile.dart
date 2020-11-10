import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/model/liveSEssionModel.dart';
import 'package:ashva_fitness_example/pages/liveTrainingLinkPage.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LiveTrainingTile extends StatefulWidget {
  final AllItems element;
  final selectedDate;
  final events;

  const LiveTrainingTile(
      {Key key, this.element, this.selectedDate, this.events})
      : super(key: key);
  @override
  _LiveTrainingTileState createState() => _LiveTrainingTileState();
}

class _LiveTrainingTileState extends State<LiveTrainingTile> {
  double height, width;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Constants.lightAccent,
                  borderRadius: BorderRadius.circular(13)),
              child: Column(
                children: <Widget>[
                  Text(
                    DateFormat('EEE').format(widget.selectedDate),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    widget.selectedDate.day.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(widget.element.startTime[0] > 11
                      ? (widget.element.startTime[0] - 11).toString() +
                          ":${widget.element.startTime[1]}" +
                          "PM"
                      : (widget.element.startTime[0] + 1).toString() +
                          ":${widget.element.startTime[1]}" +
                          "AM"),
                  SizedBox(
                    height: 8,
                  ),
                  Text('to'),
                  SizedBox(
                    height: 8,
                  ),
                  Text(widget.element.endTime[0] > 11
                      ? (widget.element.endTime[0] - 11).toString() +
                          ":${widget.element.endTime[1]}" +
                          "PM"
                      : (widget.element.endTime[0] + 1).toString() +
                          ":${widget.element.endTime[1]}" +
                          "AM"),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    widget.element.title.toString(),
                    style: TextStyle(
                      color: Constants.darkPrimary,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${widget.element.currentSize}/${widget.element.totalSize}',
                        style: TextStyle(fontSize: 10),
                      ),
                      LinearPercentIndicator(
                        width: width * 0.3,
                        lineHeight: 8.0,
                        percent: widget.element.currentSize *
                            widget.element.totalSize /
                            100,
                        progressColor: Constants.lightAccent,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      width: width * 0.3,
                      child: Text(widget.element.description.toString(),
                          style: TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text('Join '),
                !isLoading
                    ? IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Constants.darkPrimary,
                          size: 30,
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          // if (!widget.events.containsKey(widget.selectedDate)) {
                          //   setState(() {
                          //     widget.events.putIfAbsent(
                          //         widget.selectedDate,
                          //         () => [
                          //               widget.element.title.toString(),
                          //             ]);
                          //   });
                          // } else {
                          //   setState(() {
                          //     widget.events[widget.selectedDate].add(
                          //       widget.element.title.toString(),
                          //     );
                          //   });
                          // }

                          //call join api
                          await joinSession();

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LiveTrainingLinkPage(
                          //               selectedDate: widget.selectedDate,
                          //             )));
                        })
                    : Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0, top: 10, left: 10, bottom: 20),
                        child: Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> joinSession() async {
    Response response = await newHttpPostAuth(
        uri: uriList['jsonLiveSession'] +
            "?sessionId=${widget.element.trainingSessionId}",
        body: null);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Joined session successfully");
      setState(() {
        isLoading = false;
      });
    }
    print(response.body.toString());
  }
}
