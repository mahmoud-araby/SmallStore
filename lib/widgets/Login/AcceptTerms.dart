import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AcceptTerms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel.of<OAuthModel>(context, rebuildOnChange: true)
                .oAuthType ==
            OAuthType.signUp
        ? SwitchListTile(
            title: Text(
              'Accept Agreement',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            value: (ScopedModel.of<OAuthModel>(context, rebuildOnChange: true)
                .user
                .acceptTerms),
            onChanged: ScopedModel.of<OAuthModel>(context).changeTerms,
          )
        : Container();
  }
}
