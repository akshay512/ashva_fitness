import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/widgets/leaderboardsheet.dart';
import 'package:flutter/material.dart';

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Constants.darkPrimary,
          Constants.lightPrimary,
        ],
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
      )),
      child: LeaderBoardSheet(),
      )
    );
  }
}