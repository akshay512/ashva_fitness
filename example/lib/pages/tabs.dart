import 'package:ashva_fitness_example/pages/new_dashboard.dart';
import 'package:ashva_fitness_example/pages/history_page.dart';
import 'package:ashva_fitness_example/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _page = 0;
  int currentIndex = 0;
  int selectedIndex = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();
  final _pageOptions = [DashboardPage(), HistoryPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, color: currentIndex == 0 ?  Colors.grey[200] : Colors.black, size: 30),
          Icon(Icons.history, color: currentIndex == 1 ?  Colors.grey[200] : Colors.black, size: 30),
          Icon(Icons.person, color: currentIndex == 2 ?  Colors.grey[200] : Colors.black, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.pink[600], //Theme.of(context).accentColor,
        backgroundColor: Colors.pink[600],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        height: 50,
        onTap: (index) {
          setState(() {
            _page = index;
            currentIndex = _page;
          });
        },
      ),
      body: _pageOptions[_page],
    );
  }
}
