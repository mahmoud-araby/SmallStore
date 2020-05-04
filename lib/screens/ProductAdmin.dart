import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:flutterapp/widgets/SideDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

import '../component/ProductCreateTab.dart';
import '../component/ProductListTab.dart';

class ProductAdmin extends StatefulWidget {
  static String id = '/admin';
  @override
  _ProductAdminState createState() => _ProductAdminState();
}

class _ProductAdminState extends State<ProductAdmin> {
  @override
  Widget build(BuildContext context) {
    print(ScopedModel.of<ProductModel>(context).productsAquire().length);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Create',
              ),
              Tab(
                text: 'Manage',
              ),
            ],
          ),
          title: Text('fuck'),
        ),
        drawer: SideDrawer(),
        body: SafeArea(
            child: TabBarView(children: <Widget>[
          ProductCreateTab(),
          ProductLitTab(),
        ])),
      ),
    );
  }
}
