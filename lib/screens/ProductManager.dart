import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:flutterapp/component/productsList.dart';
import 'package:flutterapp/widgets/SideDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductManager extends StatefulWidget {
  static String id = '/manager';

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  @override
  void initState() {
    ScopedModel.of<ProductModel>(context).fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            color: Theme.of(context).backgroundColor,
            icon: Icon(Icons.favorite_border),
          )
        ],
        title: Text('Products'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh:
                ScopedModel.of<ProductModel>(context, rebuildOnChange: true)
                    .fetchProducts,
            child: ScopedModel.of<ProductModel>(context, rebuildOnChange: true)
                    .isloading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: ProductsList(),
                  )),
      ),
    );
  }
}
