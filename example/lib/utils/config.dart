import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final String configBaseURL = "http://fitnesstracker.westindia.cloudapp.azure.com:8443/api/";
final String configAuthEndPoint = "auth";
final String configRegistrationEndPoint = "user/create";
final Map<String,String> configHeaders = {'Content-Type':'application/json'};

final String secret = "c20407cc1406cca41bcbe6f17b17fb41f97ef0f4";
final String clientId = "40444";

void clearAllStorage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
}
