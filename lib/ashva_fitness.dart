import 'dart:async';

import 'package:flutter/services.dart';

// Current day's accumulated values
enum _ActivityType { steps, cycling, walkRun, heartRate, flights }

class AshvaFitness {
  static const MethodChannel _channel =
      const MethodChannel('flutter_health_fit');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> get authorize async {
    return await _channel.invokeMethod('requestAuthorization');
  }

  static Future<double> get getBasicHealthData async {
    var result;

    try {
      result = await _channel.invokeMethod('getBasicHealthData');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (result == null || result.isEmpty) {
      return null;
    }
    return result['move'];
    //return await _channel.invokeMethod('getBasicHealthData');
  }

  static Future<double> get getMoveInMinData async {
    var result;

    try {
      result = await _channel.invokeMethod('getMoveInMinData');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (result == null || result.isEmpty) {
      return null;
    }
    return result['move'];
    //return await _channel.invokeMethod('getBasicHealthData');
  }

  static Future<double> get getCaloriesData async {
    var result;

    try {
      result = await _channel.invokeMethod('getCaloriesData');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (result == null || result.isEmpty) {
      return null;
    }
    return result['calories'];
    //return await _channel.invokeMethod('getBasicHealthData');
  }

  static Future<double> get getDistanceData async {
    var result;

    try {
      result = await _channel.invokeMethod('getDistanceData');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (result == null || result.isEmpty) {
      return null;
    }
    return result['distance'];
    //return await _channel.invokeMethod('getBasicHealthData');
  }

  static Future<double> get getHeartRateData async {
    var result;

    try {
      result = await _channel.invokeMethod('getHeartRateData');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (result == null || result.isEmpty) {
      return null;
    }
    return result['heartrate'];
    //return await _channel.invokeMethod('getBasicHealthData');
  }

  static Future<double> get getSteps async {
    return await _getActivityData(_ActivityType.steps, "count");
  }

  static Future<Map<dynamic, dynamic>> getStepsBeforeDays(int daysAgo) async {
    return await _channel.invokeMethod("startDateInDays", {"daysAgo": daysAgo});
  }

  static Future<double> get getWalkingAndRunningDistance async {
    return await _getActivityData(_ActivityType.walkRun, "m");
  }

  static Future<double> get geCyclingDistance async {
    return await _getActivityData(_ActivityType.cycling, "m");
  }

  static Future<double> get getFlights async {
    return await _getActivityData(_ActivityType.flights, "count");
  }
  static Future<String> get getStepsHistoryData async {
    //return await _getActivityData(_ActivityType.flights, "count");
    String batteryLevel;
    try {
      batteryLevel = await _channel.invokeMethod('getStepsHistoryData',{"startDate":"10-02-2020", "endDate": "12-02-2020"});
      //batteryLevel = 'Battery level at $result.';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    return batteryLevel;

  }


  static Future<Null> get _getBatteryLevel async {
    String batteryLevel;
    try {
      final String result = await _channel.invokeMethod('getBatteryLevel',{"startDate":"10-02-2020", "endDate": "12-02-2020"});
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    return batteryLevel;
  }

  static Future<String> getActivityHistoryData(
      String startDate, String endDate) async {
    var result;

    try {
      result = await _channel.invokeMethod('getActivityHistoryData',
          {"startDate": "10-02-2020", "endDate": "12-02-2020"});
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (result == null || result.isEmpty) {
      return null;
    }

    //print('result -- '+result);

    return result['history'];
  }

  static Future<double> _getActivityData(
      _ActivityType activityType, String units) async {
    var result;

    try {
      result = await _channel.invokeMethod('getActivity',
          {"name": activityType.toString().split(".").last, "units": units});
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (result == null || result.isEmpty) {
      return null;
    }

    //print('result -- '+result);

    return result['value'];
  }
}
