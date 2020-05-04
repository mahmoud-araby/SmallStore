import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('LogIn'),
      color: Theme.of(context).accentColor,
      onPressed: () {
        ScopedModel.of<OAuthModel>(context).oAuthenticate();
        Navigator.pushReplacementNamed(context, ProductManager.id);
      },
    );
  }
}
