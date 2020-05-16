import 'dart:convert';

import 'package:flutterapp/Models/securedToken.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'OAuth.dart';

mixin Validators {
  Future<Map<String, dynamic>> login(OAuth user) async {
    Map<String, dynamic> oAuth = {
      'email': user.email,
      'password': user.password,
      'returnSecureToken': true
    };
    Map<String, dynamic> ret;
    try {
      print("object");
      http.Response response = await http.post(LoginLink,
          body: jsonEncode(oAuth),
          headers: {"Content-Type": 'application/json'});
      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      ret = _decodeMessage(data);
    } catch (E) {
      print(E);
      ret = {"success": false, "message": "Something went wrong"};
    }
    return ret;
  }

  // ignore: missing_return
  Future<Map<String, dynamic>> signUp(OAuth user) async {
    Map<String, dynamic> oAuth = {
      'email': user.email,
      'password': user.password,
      'returnSecureToken': true
    };
    Map<String, dynamic> ret;
    try {
      http.Response response = await http.post(OAuthLink,
          body: jsonEncode(oAuth),
          headers: {"Content-Type": 'application/json'});
      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      ret = _decodeMessage(data);
    } catch (E) {
      print(E);
      ret = {"success": false, "message": "Something went wrong"};
    }
    return ret;
  }

  String emailValidator(String value) {
    if (value.contains('@')) {
      return null;
    }
    return 'Enter valid Email';
  }

  String passwordValidator(String value) {
    if (value.length > 6) {
      return null;
    }
    return 'Password Should be 6 char long';
  }

  Map<String, dynamic> _decodeMessage(Map<String, dynamic> data) {
    bool hasErorr = data.containsKey('idToken') ? true : false;
    String message = data.containsKey('idToken')
        ? "Succeeded"
        : data['error']['errors'][0]['message'];
    if (hasErorr) {
      securedToken = SecuredToken.fromJson(data);
    }
    return {"success": hasErorr, "message": message};
  }
}
