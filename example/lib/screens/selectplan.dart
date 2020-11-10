import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/import/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class SelectPlan extends StatefulWidget {
  static const String routeName = "/selectplan";

  SelectPlan({Key key}) : super(key: key);

  @override
  _SelectPlanState createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  double width, height;

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

  Widget _buildPlanCard(
    String distance,
    String duration,
    String peopletaken,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.orange[200], borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                  text: distance,
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
                      text: duration,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$peopletaken people have taken',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Icon(
            CustomIcons.shoe,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Constants.lightPrimary, Constants.darkPrimary],
        begin: Alignment.bottomCenter,
      )),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ashva',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'Select Plan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              // Positioned(
              //   left: width,
              //   child: Text(
              //     'Select Plan',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
            ],
          ),
          // ListTile(
          //   leading: IconButton(icon: Icon(Icons.arrow_back),

          //   onPressed: () {}),
          //   title: Text('Select Plan',style: TextStyle(color: Colors.white),),
          // ),

          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                      onTap: () {},
                      child: _buildPlanCard('3k', '4 weeks', '200')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                      onTap: () {},
                      child: _buildPlanCard('5k', '4-5 weeks', '200')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                      onTap: () {},
                      child: _buildPlanCard('10k', '4-5 weeks', '200')),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                color: Constants.lightPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          SizedBox(
            height: height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Trending Videos',
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
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(top: 20),
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
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                color: Constants.lightPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Show more',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
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
