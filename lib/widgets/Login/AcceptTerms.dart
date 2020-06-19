import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:scoped_model/scoped_model.dart';

class AcceptTerms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel.of<ProductModel>(context, rebuildOnChange: true)
                .oAuthType ==
            OAuthType.signUp
        ? SwitchListTile(
            title: Text(
              'Accept Agreement',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            value: (ScopedModel.of<ProductModel>(context, rebuildOnChange: true)
                .user
                .acceptTerms),
            onChanged: ScopedModel.of<ProductModel>(context).changeTerms,
          )
        : Container();
  }
}
