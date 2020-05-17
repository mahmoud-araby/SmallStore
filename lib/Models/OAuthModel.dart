import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/Models/securedToken.dart';
import 'package:flutterapp/Models/validators.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'OAuth.dart';

enum OAuthType { login, signUp }

class OAuthModel extends SecuredToken with Validators {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBusy = false;

  OAuth user = OAuth(email: '', password: '', acceptTerms: false);
  OAuthType oAuthType = OAuthType.signUp;

  changeOAuthType() {
    print('hello');
    if (oAuthType == OAuthType.signUp) {
      oAuthType = OAuthType.login;
      notifyListeners();
    } else {
      oAuthType = OAuthType.signUp;
      notifyListeners();
    }
  }

  logout() {
    deleteToken();
    user = OAuth(email: '', password: '', acceptTerms: false);
  }

  Future<Map<String, dynamic>> oAuthenticate(BuildContext context) async {
    isBusy = true;
    notifyListeners();
    var result = {"success": false, "message": "Enter a Valid Email"};
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (oAuthType == OAuthType.login) {
        result = await login(user);
      } else {
        if (user.acceptTerms == true) {
          result = await signUp(user);
        } else {
          result = {"success": false, "message": "Accept our terms please"};
        }
      }
    }
    isBusy = false;
    notifyListeners();
    return result;
  }

  changeTerms(bool value) {
    user.acceptTerms = value;
    notifyListeners();
  }

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
      ret = _decodeMessage(
        data,
      );
    } catch (E) {
      print(E);
      ret = {"success": false, "message": "Something went wrong"};
    }
    return ret;
  }

  Map<String, dynamic> _decodeMessage(Map<String, dynamic> data) {
    bool hasErorr = data.containsKey('idToken') ? true : false;
    String message = data.containsKey('idToken')
        ? "Succeeded"
        : data['error']['errors'][0]['message'];
    if (hasErorr) {
      updateToken(data);
    }
    return {"success": hasErorr, "message": message};
  }
}
