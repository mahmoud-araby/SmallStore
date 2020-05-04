import 'package:flutter/material.dart';
import 'package:flutterapp/screens/ProductAdmin.dart';
import 'package:flutterapp/screens/ProductManager.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('Manage Products'),
            leading: Icon(Icons.edit),
            onTap: () {
              Navigator.pushNamed(context, ProductAdmin.id);
            },
          ),
          ListTile(
            title: Text('All Products'),
            leading: Icon(Icons.map),
            onTap: () {
              Navigator.pushNamed(context, ProductManager.id);
            },
          ),
        ],
      ),
    );
  }
}
