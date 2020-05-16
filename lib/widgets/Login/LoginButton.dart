import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel.of<OAuthModel>(context, rebuildOnChange: true).isBusy
        ? CircularProgressIndicator()
        : RaisedButton(
            child: Text(
                ScopedModel.of<OAuthModel>(context, rebuildOnChange: true)
                            .oAuthType ==
                        OAuthType.login
                    ? 'LogIn'
                    : 'Register'),
            color: Theme.of(context).accentColor,
            onPressed: () {
              ScopedModel.of<OAuthModel>(context)
                  .oAuthenticate()
                  .then((Map<String, dynamic> value) {
                if (value['success'] == true) {
                  Navigator.pushReplacementNamed(context, ProductManager.id);
                } else {
                  ScopedModel.of<OAuthModel>(context)
                      .scaffoldKey
                      .currentState
                      .showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(value['message']),
                      ));
                }
              });
            },
          );
  }
}
