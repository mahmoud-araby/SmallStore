import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:scoped_model/scoped_model.dart';

import '../screens/ProductVisualizer.dart';
import '../widgets/ProductButtonBar.dart';

class ProductsList extends StatelessWidget {
  Widget _builder(BuildContext context, int index) {
    return ScopedModelDescendant<ProductModel>(
      rebuildOnChange: true,
      builder: (BuildContext context, Widget child, ProductModel model) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                  placeholder: AssetImage('assets/login.jpg'),
                  image: AssetImage(model.singleProductAquire(index).image)),
              Text(model.singleProductAquire(index).title),
              ProductButtonBar(
                action: () {
                  Navigator.pushNamed(context,
                          '/${ProductVisualizer.id}/${index.toString()}')
                      .then((value) {
                    if (value == true) {
                      ScopedModel.of<ProductModel>(context)
                          .deleteProduct(index);
                    }
                  });
                },
                index: index,
              ),
            ],
          ),
          elevation: 10.0,
        );
      },
    );
  }

  Widget productViewer(BuildContext context) {
    return ScopedModel.of<ProductModel>(context).productsAquire().length > 0
        ? ListView.builder(
            itemBuilder: _builder,
            itemCount:
                ScopedModel.of<ProductModel>(context).productsAquire().length,
          )
        : Center(
            child: Text('NO Products'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: productViewer(context),
        ),
      ],
    );
  }
}
