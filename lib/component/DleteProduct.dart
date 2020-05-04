import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

productDelete(BuildContext context) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete this object ?'),
          content: Text('This Action can`t be undon'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Discard'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      });
}
