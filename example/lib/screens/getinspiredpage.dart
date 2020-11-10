import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ashva_fitness_example/constants/const.dart';
import 'dart:ui';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:ashva_fitness_example/screens/videoPlayer.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class GetInspiredPage extends StatefulWidget {
  GetInspiredPage({Key key}) : super(key: key);

  @override
  _GetInspiredPageState createState() => _GetInspiredPageState();
}

class _GetInspiredPageState extends State<GetInspiredPage> {
  var category = [
    'Running',
    'Cardio',
    'Yoga',
    'Sports',
    'Running',
    'Cardio',
    'Yoga',
    'Sports',
  ];
  List<dynamic> categoryList;
  var list = [
    {
      "vid": "https://www.youtube.com/watch?v=qV9pqHWxYgI",
      "steps": "7k",
      "views": "452",
      "days": "6",
      "share": "34",
      "desc":
          "Lorem ipsum dolor sit amet, liqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "vid": "https://www.youtube.com/watch?v=Oj18EikZMuU",
      "steps": "7k",
      "views": "876",
      "days": "3",
      "share": "67",
      "desc":
          "Lorem ipsum dolor sit amet, liqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "vid": "https://www.youtube.com/watch?v=PTpoj4f25dk",
      "steps": "5k",
      "views": "452",
      "days": "2",
      "share": "34",
      "desc":
          "Lorem ipsum dolor sit amet, liqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "vid": "https://www.youtube.com/watch?v=_qyw6LC5pnE",
      "steps": "2k",
      "views": "876",
      "days": "4",
      "share": "67",
      "desc":
          "Lorem ipsum dolor sit amet, liqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "vid": "https://www.youtube.com/watch?v=Oj18EikZMuU",
      "steps": "7k",
      "views": "876",
      "days": "3",
      "share": "67",
      "desc":
          "Lorem ipsum dolor sit amet, liqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "vid": "https://www.youtube.com/watch?v=PTpoj4f25dk",
      "steps": "5k",
      "views": "452",
      "days": "2",
      "share": "34",
      "desc":
          "Lorem ipsum dolor sit amet, liqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
  ];

  double width;
  double height;
  int i = 0;
  int selected = -1;
  int tag = -1;
  String desc =
      "Lorem ipsum dolor sit amet, liqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  bool isLoading = false;

  Widget _buildChipList(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      child: categoryList != null
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 30),
              itemCount: categoryList.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildNavItem(categoryList[index].toString(), index);
              },
            )
          : SizedBox(
              height: 5,
              width: 5,
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    strokeWidth: 5.0),
              )),
    );
  }

  Widget buildNavItem(
    String msg,
    value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            selected = value;
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: 70,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              color: (value == selected) ? Colors.grey : Colors.transparent,
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            msg,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Constants.lightPrimary, Constants.darkPrimary],
        begin: Alignment.bottomCenter,
      )),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Recent updates',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 24),
              ),
              SizedBox(
                width: width * .1,
              ),
              ClipOval(
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFD35268).withOpacity(0.2),
                      child: Icon(
                        CustomIcons.filter,
                        size: 18,
                        color: Colors.white,
                      ))),
            ],
          ),
          SizedBox(
            height: height * .02,
          ),
          _buildChipList(context),
          SizedBox(
            height: height * .02,
          ),
          // SizedBox(
          //   height: 30,
          // ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayerPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        _getThumbnail(list[index]["vid"])),
                                    fit: BoxFit.fill)),
                            // child: ClipRRect(
                            //   borderRadius: BorderRadius.circular(15),
                            //   child: Image.network(
                            //     _getThumbnail(
                            //         "https://www.youtube.com/watch?v=qV9pqHWxYgI"),
                            //   ),
                            // ),
                            width: width * 0.3,
                            height: height * 0.15,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                      text: list[index]["steps"],
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Run',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: ' | ',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: list[index]["days"],
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: ' days ago',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              Container(
                                  width: width * 0.4,
                                  child: ReadMoreText(
                                    list[index]["desc"],
                                    trimLines: 2,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '...Read more',
                                    trimExpandedText: ' show less',
                                    colorClickableText: Colors.orange[900],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )),
                              SizedBox(
                                height: height * .01,
                              ),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: width * .02,
                                    ),
                                    Text(
                                      list[index]["views"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: width * .1,
                                    ),
                                    Icon(
                                      Icons.share,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: width * .02,
                                    ),
                                    Text(
                                      list[index]["share"],
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<void> getCategory() async {
    try {
      Response response = await newHttpGetAuth(uri: uriList['getCategories']);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          print(response.body);
          categoryList = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
    print("loading done for sign up");
  }
}

String _getThumbnail(String url) {
  int lindex = url.lastIndexOf('=');
  int len = url.length;
  String vid = url.substring(lindex + 1);
  String res = "http://img.youtube.com/vi/$vid/maxresdefault.jpg";
  print("Thumbnail link = " + res);
  return res;
}
