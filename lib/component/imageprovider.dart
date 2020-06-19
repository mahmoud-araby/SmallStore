import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/ProductController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ImageGetter extends StatefulWidget {
  @override
  _ImageGetterState createState() => _ImageGetterState();
}

class _ImageGetterState extends State<ImageGetter> {
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    ScopedModel.of<ProductModel>(context).setImage(image);
    Navigator.pop(context);
  }

  Future photoImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    ScopedModel.of<ProductModel>(context).setImage(image);

    Navigator.pop(context);
  }

  Widget imageview() {
    if (ScopedModel.of<ProductModel>(context, rebuildOnChange: true)
            .uploadedImage ==
        null) {
      return Container();
    } else {
      return Image.file(
          ScopedModel.of<ProductModel>(context, rebuildOnChange: true)
              .uploadedImage);
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
