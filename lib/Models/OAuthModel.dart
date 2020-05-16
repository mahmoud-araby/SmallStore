import 'package:flutter/material.dart';
import 'package:flutterapp/Models/validators.dart';
import 'package:scoped_model/scoped_model.dart';

import 'OAuth.dart';

enum OAuthType { login, signUp }

class OAuthModel extends Model with Validators {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBusy = false;

  OAuth user = OAuth(email: '', password: '', acceptTerms: false);
  OAuth authuser = OAuth(email: '', password: '', acceptTerms: false);
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

  Future<Map<String, dynamic>> oAuthenticate() async {
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
}
