import 'package:flutter/material.dart';
import 'package:flutterapp/Models/Product.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductLitTab extends StatefulWidget {
  @override
  _ProductLitTabState createState() => _ProductLitTabState();
}

class _ProductLitTabState extends State<ProductLitTab> {
  @override
  Widget build(BuildContext context) {
    final List<Product> _products =
        ScopedModel.of<ProductModel>(context).productsAquire();

    return Container(
      child: ListView(
        children: _products.map((value) {
          return Dismissible(
            background: Container(color: Theme.of(context).accentColor),
            key: Key(value.title),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(value.image),
                  ),
                  title: Text(value.title),
                  subtitle: Text(value.price.toString()),
                  trailing: Text('futuer button'),

                  //TODO: add a edit product massage
                ),
                Divider(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
