import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

Map<String, String> uriList = {
  "employeeSignup": "http://104.197.184.236:8443/api/employeeSignup",
  "associateSignup": "http://104.197.184.236:8443/api/associateSignup",
  "employeeAuth": "http://104.197.184.236:8443/api/auth",
  "getCategories": "http://104.197.184.236:8443/api/getInspiredCategories",
  "getDashBoardDetails": "http://104.197.184.236:8443/api/getDashboardDetails",
  "getUserDetalis": "http://104.197.184.236:8443/api/user",
  "getAllChallenges": "http://104.197.184.236:8443/api/getAllChallenges",
  "postStepData": "http://104.197.184.236:8443/api/stepsdata",
  "updateUserChallenge": "http://104.197.184.236:8443/api/updateUserChallenge",
  "getLiveSessions": "http://104.197.184.236:8443/api/getAllTrainingSession/",
  "postEditProfile": "http://104.197.184.236:8443/api/editProfile",
  "sendFeedDailyBack": "http://104.197.184.236:8443/api/feedback",
  "uploadImage": "http://104.197.184.236:8443/api/imageupload",
  "getAllImages": "http://104.197.184.236:8443/api/getAllUploads",
  "jsonLiveSession": "http://104.197.184.236:8443/api/joinSession",
  "getAllFacts":
      "http://104.197.184.236:8443/api/getTodayFacts?factDate=22-04-2020"
};

Future<Response> newHttpPost({String uri, Map<String, dynamic> body}) async {
  print("-->called httpPost PubilcHttpMeth");

  final headers = {'Content-Type': 'application/json'};

  String jsonBody = jsonEncode(body);
  print(jsonBody.toString() + "" + uri.toString());
  final encoding = Encoding.getByName('utf-8');

  Response response =
      await post(uri, headers: headers, body: jsonBody, encoding: encoding);
  print(response.body);

  int statusCode = response.statusCode; //yet to handle http exception
  String responseBody = response.body;
  return response;
}

Future<Response> newHttpPostAuth(
    {String uri, Map<String, dynamic> body}) async {
  print("-->called httpPost PubilcHttpMeth");

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': prefs.get('auth_token').toString()
  };

  String jsonBody = jsonEncode(body);
  print(jsonBody.toString() + "" + uri.toString());
  final encoding = Encoding.getByName('utf-8');

  Response response =
      await post(uri, headers: headers, body: jsonBody, encoding: encoding);

  int statusCode = response.statusCode; //yet to handle http exception
  String responseBody = response.body;
  print(response.body);
  return response;
}

Future<Response> newHttpGetAuth({String uri, Map<String, dynamic> body}) async {
  print("-->called httpGetAuth PubilcHttpMeth");

  Map<String, dynamic> headers = {
    'Authorization': prefs.get('auth_token').toString()
  };

  String jsonBody = jsonEncode(body);
  print(jsonBody.toString() + "" + uri.toString());
  final encoding = Encoding.getByName('utf-8');
  print(uri);
  print({'Authorization': prefs.get('auth_token').toString()});
  Response response = await get(uri,
      headers: {'Authorization': prefs.get('auth_token').toString()});

  int statusCode = response.statusCode; //yet to handle http exception
  String responseBody = response.body;
  print(response.body);
  return response;
}
