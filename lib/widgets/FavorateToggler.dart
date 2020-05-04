import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:scoped_model/scoped_model.dart';

class FavorateToggler extends StatelessWidget {
  final int index;
  FavorateToggler(this.index);

  IconData favoraiteIcon(BuildContext context) {
    final currentFavoriate = ScopedModel.of<ProductModel>(context)
        .singleProductAquire(index)
        .favoraite;
    if (currentFavoriate == true) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ScopedModel.of<ProductModel>(context).toggleFavorate(index);
      },
      color: Theme.of(context).accentColor,
      icon: Icon(
        favoraiteIcon(context),
      ),
    );
  }
}
