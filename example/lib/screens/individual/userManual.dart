import 'package:ashva_fitness_example/constants/const.dart';
import 'package:flutter/material.dart';

class UserManual extends StatefulWidget {
  @override
  _UserManualState createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPrimary,
        title: Text("User manual"),
      ),
    );
  }
}
