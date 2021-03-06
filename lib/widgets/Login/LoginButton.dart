import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel.of<ProductModel>(context, rebuildOnChange: true).isBusy
        ? CircularProgressIndicator()
        : RaisedButton(
            child: Text(
                ScopedModel.of<ProductModel>(context, rebuildOnChange: true)
                            .oAuthType ==
                        OAuthType.login
                    ? 'LogIn'
                    : 'Register'),
            color: Theme.of(context).accentColor,
            onPressed: () {
              ScopedModel.of<ProductModel>(context)
                  .oAuthenticate(context)
                  .then((Map<String, dynamic> value) {
                if (value['success'] == true) {
                  Navigator.pushReplacementNamed(context, ProductManager.id);
                } else {
                  ScopedModel.of<ProductModel>(context)
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
