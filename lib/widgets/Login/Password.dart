import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:scoped_model/scoped_model.dart';

class PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'PassWord',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onSaved: (value) {
        ScopedModel.of<OAuthModel>(context, rebuildOnChange: false)
            .user
            .password = value;
      },
      validator: ScopedModel.of<OAuthModel>(context).passwordValidator,
    );
  }
}
