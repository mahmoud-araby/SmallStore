import 'package:flutter/material.dart';
import 'package:flutterapp/screens/Loginscreen.dart';
import 'package:flutterapp/screens/ProductAdmin.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:flutterapp/screens/ProductVisualizer.dart';
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
      child: MaterialApp(
        title: 'Store',
        theme: ThemeData(
          accentColor: Colors.deepPurple,
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: Login.id,
        routes: {
          Login.id: (BuildContext context) => Login(),
          ProductManager.id: (BuildContext context) => ProductManager(),
          ProductAdmin.id: (BuildContext context) => ProductAdmin(),
        },
        onUnknownRoute: (RouteSettings setting) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductManager());
        },
        onGenerateRoute: (RouteSettings setting) {
          dynamic page;
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
    );
  }
}
