import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:scoped_model/scoped_model.dart';

class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        labelText: 'UserName',
      ),
      onSaved: (value) {
        ScopedModel.of<ProductModel>(context).user.email = value;
      },
      validator: ScopedModel.of<ProductModel>(context).emailValidator,
    );
  }
}
