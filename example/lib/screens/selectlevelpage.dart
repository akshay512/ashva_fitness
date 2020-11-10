import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/screens/leveldetailspage.dart';
import 'package:flutter/material.dart';

class SelectLevel extends StatefulWidget {
  static const String routeName = "/selectlevel";
  SelectLevel({Key key}) : super(key: key);

  @override
  _SelectLevelState createState() => _SelectLevelState();
}

class _SelectLevelState extends State<SelectLevel> {
  List<String> challengesList = [
    "Beginner",
    "Intermediate",
    "Advance",
    "Personal Training",
  ];
  double width, height;

  Widget _buildLevel({String level}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.2, vertical: height * 0.03),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white))),
      child: Row(
        children: <Widget>[
          Text(
            level,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Constants.lightPrimary, Constants.darkPrimary],
          begin: Alignment.bottomCenter,
        )),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.orange.withOpacity(0.15),
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                // title: Text('Choose Level of workout'),
                background: Image.asset(
                  'assets/Images/dumbell.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 10),
            ),
            SliverFixedExtentList(
              itemExtent: 60,
              delegate: SliverChildBuilderDelegate(
                (context, index) => SingleItem(challengesList[index], index),
                childCount: challengesList.length,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 20),
            )
          ],
        ),
      ),
    );
  }
}

class SingleItem extends StatelessWidget {
  String title;
  int index;

  SingleItem(String title, int index) {
    this.title = title;
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LevelDetails(
                          title: title,
                        )));
          } else if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LevelDetails(
                          title: title,
                        )));
          } else if (index == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LevelDetails(
                          title: title,
                        )));
          } else if (index == 3) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LevelDetails(
                          title: title,
                        )));
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 3,
          color: Colors.orange[700],
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
