import 'package:flutter/material.dart';
import 'package:flutterapp/Models/Product.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:scoped_model/scoped_model.dart';

import 'imageprovider.dart';
import 'mapprovider.dart';

class ProductCreateTab extends StatefulWidget {
  String title;
  String description;
  double price;

  @override
  _ProductCreateTabState createState() => _ProductCreateTabState();
}

class _ProductCreateTabState extends State<ProductCreateTab> {
  String image = 'assets/4.png';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'title'),
                    textDirection: TextDirection.rtl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.title = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 4,
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Description must be at least 10 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.description = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if ((value.isEmpty) ||
                          (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                              .hasMatch(value))) {
                        print('a7a');
                        return 'Price is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.price = double.parse(value);
                    },
                  ),
                  MapProvider(),
                  ImageGetter(),
                  RaisedButton(
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        formkey.currentState.save();
                        ScopedModel.of<ProductModel>(context,
                                rebuildOnChange: true)
                            .addProduct(Product(
                                title: widget.title,
                                description: widget.description,
                                price: widget.price,
                                image: image));
                        Navigator.pushNamed(context, ProductManager.id);
                      }
                    },
                    child: Text('Add Product'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
