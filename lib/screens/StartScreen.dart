import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:flutterapp/screens/Loginscreen.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:scoped_model/scoped_model.dart';

class StartScreen extends StatefulWidget {
  static String id = "/start";
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    goto();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Hello_%28yellow%29.svg/579px-Hello_%28yellow%29.svg.png"),
        ),
      ),
    );
  }

  goto() async {
    await Future.delayed(Duration(seconds: 2));
    ScopedModel.of<OAuthModel>(context, rebuildOnChange: true).isUserLogged
        ? Navigator.pushReplacementNamed(context, ProductManager.id)
        : Navigator.pushReplacementNamed(context, Login.id);
  }
}
