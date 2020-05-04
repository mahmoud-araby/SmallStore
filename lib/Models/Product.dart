import 'package:google_maps_flutter/google_maps_flutter.dart';

class Product {
  Product(
      {this.image,
      this.title,
      this.price,
      this.description,
      this.location,
      this.id});
  dynamic id;
  double price;
  String title;
  String description;
  LatLng location;
  String image;
  bool favoraite = false;
}
