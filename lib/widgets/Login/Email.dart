import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'UserName',
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (value) {
        ScopedModel.of<OAuthModel>(context).user.email = value;
      },
    );
  }
}
