import 'package:flutter/material.dart';
import 'package:flutterapp/Models/OAuthModel.dart';
import 'package:flutterapp/screens/Loginscreen.dart';
import 'package:flutterapp/screens/ProductAdmin.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:flutterapp/screens/ProductVisualizer.dart';
import 'package:flutterapp/screens/StartScreen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Models/ProductController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductModel>(
      model: ProductModel(),
      child: ScopedModel<OAuthModel>(
        model: OAuthModel(),
        child: MaterialApp(
          title: 'Store',
          theme: ThemeData(
            accentColor: Colors.deepPurple,
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
          ),
          initialRoute: StartScreen.id,
          routes: {
//            '/': (BuildContext context) => ScopedModelDescendant<OAuthModel>(
//                    builder:
//                        (BuildContext context, Widget child, OAuthModel model) {
//                  return model.isUserLogged ? ProductManager() : Login();
//                }),
            Login.id: (BuildContext context) => Login(),
            StartScreen.id: (BuildContext context) => StartScreen(),
            ProductManager.id: (BuildContext context) => ProductManager(),
            ProductAdmin.id: (BuildContext context) => ProductAdmin(),
          },
          onUnknownRoute: (RouteSettings setting) {
            return MaterialPageRoute(
                builder: (BuildContext context) => ProductManager());
          },
          onGenerateRoute: (RouteSettings setting) {
            var page;
            final List<String> route = setting.name.split('/');
            if (route[0] == '') {
              if (route[1] == ProductVisualizer.id) {
                page = MaterialPageRoute(
                  builder: (BuildContext context) => ProductVisualizer(
                    ScopedModel.of<ProductModel>(context).singleProductAquire(
                      int.parse(route[2]),
                    ),
                  ),
                );
              }
            }
            return page;
          },
        ),
      ),
    );
  }
}
