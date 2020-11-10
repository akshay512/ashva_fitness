import 'package:ashva_fitness_example/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });


  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              _username,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/road-running.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.cloud_queue),
            title: Text('Connect to Starva'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Manual'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Upload Photos'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Invite Friends'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              print('Clicked on logout');
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/login');
              clearAllStorage();

            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App Version'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}