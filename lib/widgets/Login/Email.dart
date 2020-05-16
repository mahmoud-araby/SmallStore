import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        labelText: 'UserName',
      ),
      onSaved: (value) {
        ScopedModel.of<OAuthModel>(context).user.email = value;
      },
      validator: ScopedModel.of<OAuthModel>(context).emailValidator,
    );
  }
}
