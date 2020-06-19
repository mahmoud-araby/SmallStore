import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:flutterapp/widgets/Login/AcceptTerms.dart';
import 'package:flutterapp/widgets/Login/Email.dart';
import 'package:flutterapp/widgets/Login/LoginButton.dart';
import 'package:flutterapp/widgets/Login/Password.dart';
import 'package:flutterapp/widgets/Login/oauth_changer.dart';
import 'package:scoped_model/scoped_model.dart';

import '../constant.dart';

class Login extends StatefulWidget {
  static String id = '/id';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userName;
  String password;
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScopedModel.of<ProductModel>(context).scaffoldKey,
      appBar: AppBar(title: Text('User LogIN')),
      body: Container(
        decoration: loginDecration,
        child: Center(
          child: Container(
            width: varibleWidth(context),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: ScopedModel.of<ProductModel>(context).formKey,
                  child: Column(
                    children: <Widget>[
                      Email(),
                      SizedBox(
                        height: 15,
                      ),
                      PasswordField(),
                      AcceptTerms(),
                      LoginButton(),
                      OAuthChanger(),
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
