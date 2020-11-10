import 'package:flutter/material.dart';
// To remove # at the end of redirect url when in web mode (not mobile)
// This is a web only package
// import 'dart:html' as html;

import 'package:ashva_fitness_example/utils/examples.dart';

import 'package:ashva_fitness_example/utils/secret.dart';

import 'package:strava_flutter/strava.dart';

// Used by example

import 'package:strava_flutter/Models/activity.dart';
import 'package:strava_flutter/Models/club.dart';
import 'package:strava_flutter/Models/detailedAthlete.dart';
import 'package:strava_flutter/Models/gear.dart';
import 'package:strava_flutter/Models/runningRace.dart';
import 'package:strava_flutter/Models/stats.dart';
import 'package:strava_flutter/Models/summaryAthlete.dart';
import 'package:strava_flutter/Models/zone.dart';
import 'package:strava_flutter/Models/fault.dart';


final _formKey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

void connectStrava() {
  print('connectStrava');
  example(secret);
}

void exampleSeg() {
  exampleSegment(secret);
}

void _showSuccessSnackBar(String firstName, String lastName) {
  final snackBar = SnackBar(
    content: Text(
      "$firstName $lastName connected to Starva",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
  _scaffoldKey.currentState.showSnackBar(snackBar);
}



///
/// Example of dart code to use Strava API
///
/// set isInDebug to true in strava init to see the debug info
void example(String secret) async {
  bool isAuthOk = false;

  final strava = Strava(true, secret);
  final prompt = 'auto';



  isAuthOk = await strava.oauth(
      clientId,
      'activity:write,activity:read_all,profile:read_all,profile:write',
      secret,
      prompt);

  if (isAuthOk) {
    // Get the zones related to the logged athlete
    Zone _zone = await strava.getLoggedInAthleteZones();
    if (_zone.fault.statusCode != 200) {
      print(
          'Error in getLoggedInAthleteZones  ${_zone.fault.statusCode}  ${_zone.fault.message}');
    } else {
      _zone.infoZones.zones.forEach(
              (zone) => print('getLoggedInAthleteZones ${zone.min} ${zone.max}'));
    }

    // Create an new activity
    String _startDate = '2019-02-18 10:02:13';

    DetailedActivity _newActivity = await strava.createActivity(
        'Test_Strava_Flutter', 'ride', _startDate, 3600,
        distance: 1555, description: 'This is a strava_flutter test');

    print('********** 1_newActivity.fault.statusCode ${_newActivity.fault.statusCode}');
    if (_newActivity.fault.statusCode != 201) {
      print(
          'Error in createActivity ${_newActivity.fault.statusCode}  ${_newActivity.fault.message}');
    } else {
      print('createActivity  ${_newActivity.name}');
    }

    // Type of expected answer:
    // {"id":25707617,"username":"patrick_ff","resource_state":3,"firstname":"Patrick","lastname":"FF",
    // "city":"Le Beausset","state":"Provence-Alpes-Côte d'Azur","country":"France","sex":null,"premium"
    DetailedAthlete _athlete = await strava.getLoggedInAthlete();
    print('********** 2 _newActivity.fault.statusCode ${_newActivity.fault.statusCode}');
    if (_athlete.fault.statusCode != 200) {
      print(
          'Error in getloggedInAthlete ${_athlete.fault.statusCode}  ${_athlete.fault.message}');
    } else {
     // print('getLoggedInAthlete _athlete ${_athlete.toJson()}');
      //_showSuccessSnackBar(_athlete.firstname, _athlete.lastname);
      print('getLoggedInAthlete ${_athlete.firstname}  ${_athlete.lastname}');

//      String id = _athlete.id.toString();
//      print('ID -- $id');
//      DetailedActivity _activity = await strava.getActivityById(id);
//
//      print('********** 3 _newActivity.fault.statusCode ${_activity.fault.statusCode}');
//
//      if (_activity.fault.statusCode != 200) {
//        print('Error in getActivityById: ${_activity.fault.statusCode}');
//      } else {
//        print('Mallikarjun getActivityById ${_activity.toJson()}');
//      }

    }

    // Type of expected answer
    //  {"biggest_ride_distance":156733.0,"biggest_climb_elevation_gain":null,"recent_ride_totals":{"count":2,"distance":111427.7001953125,
    // "moving_time":17726,"elapsed_time":23181,"elevation_gain":1354.5838375091553,"achievement_count":0},"recent_run_to
    Stats _stats = await strava.getStats(_athlete.id);
    if (_stats.fault.statusCode != 200) {
      print(
          'Error in getStats ${_stats.fault.statusCode}    ${_stats.fault.message}');
    } else {
      print('stats -- ${_stats.toJson()}');
      print(
          'getStats ${_stats.ytdRideTotals.distance} ${_stats.ytdRideTotals.elevationGain}   ${_stats.allSwimTotals.distance}');
    }

    // A long list of races per city
    // Starting by Walt Disney World Marathon
    List<RunningRace> _listRunningRaces =
    await strava.getRunningRaces('2019');
    if ((_listRunningRaces == null) ||
        (_listRunningRaces[0].fault.statusCode != 200)) {
      print(
          'Error in getRunningRaces: ${_listRunningRaces[0].fault.statusCode}    ${_listRunningRaces[0].fault.message}');
    } else {
      print('getRunningRaces ${_listRunningRaces[0].name}');
    }

    // id corresponding to BMW Berlin Marathon 29th Sept 2019
    RunningRace _race = await strava.getRunningRaceById('2724');
    if (_race.fault.statusCode != 200) {
      print(
          'Error in getRunningRaceById  ${_race.fault.statusCode}    ${_race.fault.message}');
    } else {
      print('getRunningRaceById $_race');
    }

    // Change weight of the loggedAthlete in profile (in kg)
    DetailedAthlete _athlete2 = await strava.updateLoggedInAthlete(80);
    if (_athlete2.fault.statusCode != 200) {
      print(
          'Error in updateLoggedInAthlete ${_athlete2.fault.statusCode}  ${_athlete2.fault.message}');
    } else {
      print('getRunningRaceById $_athlete2');
    }

    /// Gear should be owned by the loggedIn Athleted
    /// Type of expected answer:
    /// {"id":"b4366285","primary":true,"name":"Roubaix Specialized","resource_state":3,"distance":461692.0,
    /// "brand_name":"Specialized","model_name":"Roubaix Expert","frame_type":3,"description":"So comfortable!"}
    Gear _gear = await strava.getGearById("b4366285");
    if (_gear.fault.statusCode != 200) {
      print(
          'error code getGearById  ${_gear.fault.statusCode}  ${_gear.fault.message}');
    } else {
      print('getGearById $_gear');
    }

    // IMPORTANT ------
    //  You have to join this club to do the test
    final clubStravaMarseille = '226910';

    /// Answer expected:
    /// {"id":226910,"resource_state":3,"name":"STRAVA Marseille ",
    /// "profile_medium":"https://dgalywyr863hv.cloudfront.net/pictures/clubs/226910/5003423/3/medium.jpg","profile":"https://dgalywyr863hv.cloudfront.net/pictures/clubs/226910/5003423/3/larg
    Club _club = await strava.getClubById(clubStravaMarseille);
    if (_club.fault.statusCode != 200) {
      print(
          'error code getClubById  ${_club.fault.statusCode}  ${_club.fault.message}');
    } else {
      print('getClubById $_club');
    }

    /// List the member of Strava club
    /// Expected answer (should start like this):
    ///  [{"resource_state":2,"firstname":"Adam","lastname":"Š.","membership":"member",
    /// "admin":false,"owner":false},{"resource_state":2,"firstname":"Alex","lastname":"M.","membership"
    List<SummaryAthlete> _listMembers = await strava.getClubMembersById('1');
    if (_listMembers[0].fault.statusCode != 200) {
      print(
          'error code getClubById  ${_club.fault.statusCode}  ${_club.fault.message}');
    } else {
      print('getClubMembersById ');
      _listMembers.forEach((member) => print(
          '${member.firstname}   ${member.lastname}  ${member.membership}'));
    }

    List<SummaryActivity> _listSumm =
    await strava.getClubActivitiesById(clubStravaMarseille);
    if (_listSumm[0].fault.statusCode != 200) {
      print(
          'error code getClubById  ${_club.fault.statusCode}  ${_club.fault.message}');
    } else {
      print('getClubActivitiesById ');
      _listSumm.forEach((activity) =>
          print('${activity.name}   ${activity.totalElevationGain}'));
    }

    /// You have to put an id of one activity of the logged Athlete
    /// You can find the id of one activity looking at your web page
    /// https://www.strava.com/activities/2130215349


    DetailedActivity _activity = await strava.getActivityById('2130215349');

    print('********** 3 _newActivity.fault.statusCode ${_newActivity.fault.statusCode}');

    if (_activity.fault.statusCode != 200) {
      print('Error in getActivityById: ${_activity.fault.statusCode}');
    } else {
      print('getActivityById ${_activity.name}');
    }
  }
}

