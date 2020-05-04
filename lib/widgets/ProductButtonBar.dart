import 'package:flutter/material.dart';

import 'FavorateToggler.dart';

class ProductButtonBar extends StatefulWidget {
  final Function action;
  final int index;
  ProductButtonBar({this.action, this.index});
  @override
  _ProductButtonBarState createState() => _ProductButtonBarState();
}

class _ProductButtonBarState extends State<ProductButtonBar> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {
            widget.action();
          },
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.info),
        ),
        FavorateToggler(widget.index),
      ],
    );
  }
}
