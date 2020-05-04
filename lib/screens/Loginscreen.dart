import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Login/AcceptTerms.dart';
import 'package:flutterapp/widgets/Login/Email.dart';
import 'package:flutterapp/widgets/Login/LoginButton.dart';
import 'package:flutterapp/widgets/Login/Password.dart';
import 'package:scoped_model/scoped_model.dart';

import '../Models/OAuthModel.dart';
import '../constant.dart';

class Login extends StatefulWidget {
  static String id = '/';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userName;
  String password;
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<OAuthModel>(
      model: OAuthModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('User LogIN')),
        body: Container(
          decoration: loginDecration,
          child: Center(
            child: Container(
              width: varibleWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Email(),
                      SizedBox(
                        height: 15,
                      ),
                      PasswordField(),
                      AcceptTerms(),
                      LoginButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
