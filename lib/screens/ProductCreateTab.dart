import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:flutterapp/screens/ProductManager.dart';
import 'package:scoped_model/scoped_model.dart';

import '../component/imageprovider.dart';
import '../component/mapprovider.dart';

class ProductCreateTab extends StatefulWidget {
  @override
  _ProductCreateTabState createState() => _ProductCreateTabState();
}

class _ProductCreateTabState extends State<ProductCreateTab> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(
      builder: (BuildContext context, Widget child, ProductModel model) =>
          GestureDetector(
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        model.currentProduct.title = value;
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
                        model.currentProduct.description = value;
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
                        model.currentProduct.price = double.parse(value);
                      },
                    ),
                    MapProvider(),
                    ImageGetter(),
                    ScopedModel.of<ProductModel>(context).isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RaisedButton(
                            onPressed: () async {
                              if (formkey.currentState.validate() &&
                                  ScopedModel.of<ProductModel>(context,
                                              rebuildOnChange: true)
                                          .uploadedImage !=
                                      null) {
                                formkey.currentState.save();
                                await ScopedModel.of<ProductModel>(context,
                                        rebuildOnChange: true)
                                    .addProduct(model.currentProduct);
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
      ),
    );
  }
}
