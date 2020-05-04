import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/Product.dart';
import 'package:flutterapp/component/DleteProduct.dart';

class ProductVisualizer extends StatefulWidget {
  static String id = 'visualizer';
  final Product product;

  ProductVisualizer(this.product);
  @override
  _ProductVisualizerState createState() => _ProductVisualizerState();
}

class _ProductVisualizerState extends State<ProductVisualizer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.product.title),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(widget.product.image),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.product.title,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).accentColor.withOpacity(0.9),
                    shadowColor: Theme.of(context).accentColor.withOpacity(0.8),
                    type: MaterialType.card,
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        widget.product.price.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  productDelete(context);
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
