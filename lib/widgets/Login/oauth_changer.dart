import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:scoped_model/scoped_model.dart';

class OAuthChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: <InlineSpan>[
      TextSpan(
          text: (ScopedModel.of<OAuthModel>(context, rebuildOnChange: true)
                          .oAuthType ==
                      OAuthType.login
                  ? 'New User'
                  : 'Existing User') +
              " ? "),
      WidgetSpan(
          child: InkWell(
        onTap: ScopedModel.of<OAuthModel>(context, rebuildOnChange: true)
            .changeOAuthType,
        child: Text(
          ScopedModel.of<OAuthModel>(context, rebuildOnChange: true)
                      .oAuthType ==
                  OAuthType.login
              ? 'Register'
              : 'Login',
          style: TextStyle(
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      )),
    ]));
  }
}
