import 'dart:convert';

import 'package:flutter_application_1/model/destination.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

Future userRegister(UserClass user) async {
  var reqBody = {
    'name': user.name,
    'email': user.email,
    'password': user.password,
    "password_confirmation": user.passwordConfirmation,
    "user_lattitude": user.userLattitude,
    "user_longitude": user.userLongitude,
  };
  final http.Response response = await http.post(
    Uri.parse('https://visital.in/test/fluttertest/api/register'),
    body: reqBody,
  );

  if (response.statusCode == 201) {
    print('success!');
    return User.userFromJson(response.body);
  } else {
    // print(response.statusCode);
    // print(response.body);
    throw Exception('Couldn\'t Register');
  }
}

Future userLogin(String email, String pass) async {
  var reqbody = {"email": email, "password": pass};

  final http.Response response = await http.post(
      Uri.parse('https://visital.in/test/fluttertest/api/login'),
      body: reqbody);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print('success!');
    final data = UserLogin.userLoginFromJson(response.body);
    sp.setString('access_token', data.accessToken);
    return data;
  } else {
    //print(response.statusCode);
    //print(response.body);
    throw Exception('Couldn\'t Login');
  }
}

Future destination() async {
  final access_token = sp.getString('access_token');
  print(access_token);
  final uri = Uri.parse('https://visital.in/test/fluttertest/api/destination');
  try {
    final response = await http.get(
      uri,
      headers: <String, String>{'Authorization': 'Bearer $access_token'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      //print(response.body);
      return Destination.destinationFromJson(response.body);
    } else {
      print(response.body);
      throw Exception('Couldn\'t load data!');
    }
  } catch (e) {
    print(e);
  }
}

Future getTime(
    double lat, double lang, double latitude, double longitude) async {
  final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$latitude,$longitude&destinations=$lat,$lang&key=AIzaSyAwvtdDrNr8_W_C3PZuBSX-MkhcAO_DKH8'));
  print(response.body);
  return response.body;
}
