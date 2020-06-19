import 'package:geolocator/geolocator.dart';

class Product {
  Product(
      {this.image,
      this.title,
      this.price,
      this.description,
      this.location,
      this.address,
      this.id});
  dynamic id;
  double price;
  String title;
  String description;
  Position location;
  String address;
  String image;
  bool favoraite = false;
}
