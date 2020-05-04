import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageGetter extends StatefulWidget {
  @override
  _ImageGetterState createState() => _ImageGetterState();
}

class _ImageGetterState extends State<ImageGetter> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.pop(context);
  }

  Future photoImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    Navigator.pop(context);
  }

  Widget imageview() {
    if (_image == null) {
      return Container();
    } else {
      return Image.file(_image);
    }
  }

  Widget imagepicker(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              getImage();
            },
            child: CircleAvatar(
              child: Icon(Icons.image),
            ),
          ),
          FlatButton(
            onPressed: () {
              photoImage();
            },
            child: CircleAvatar(
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton.icon(
            onPressed: () {
              showModalBottomSheet(context: context, builder: imagepicker);
            },
            icon: Icon(Icons.image),
            label: Text('Pic an Image')),
        imageview(),
      ],
    );
  }
}
