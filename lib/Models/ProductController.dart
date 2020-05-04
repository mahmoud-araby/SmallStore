import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import 'Product.dart';

class ProductModel extends Model {
  bool isloading = false;
  int currentProduct = 0;
  List<Product> _products = [
    Product(title: 'no.1', price: 20.0, image: 'assets/login.jpg'),
  ];

  List<Product> productsAquire() {
    return _products;
  }

  void goToProduct(int index) {
    currentProduct = index;
    notifyListeners();
  }

  //////////////////////////

  Product singleProductAquire(int index) {
    return _products[index];
  }

  Product currentProductAquire() {
    return _products[currentProduct];
  }

  //////////////////////////
  void deleteProduct(int index) async {
    isloading = true;
    notifyListeners();
    await http.delete(
      'https://flutterstore-c3a00.firebaseio.com/products/${_products[index].id}.json',
    );
    _products.removeAt(index);
    isloading = false;
    notifyListeners();
  }

  void deleteCurrentProduct() {
    _products.removeAt(currentProduct);
    notifyListeners();
  }
/////////////////////////////////////////////

  toggleFavorate(int index) {
    _products[index].favoraite = _products[index].favoraite ? false : true;
    notifyListeners();
  }

  toggleCurrentFavorate() {
    _products[currentProduct].favoraite =
        _products[currentProduct].favoraite ? false : true;
    notifyListeners();
  }

  /////////////////////////////
  void addProduct(Product newproduct) async {
    isloading = true;
    notifyListeners();
    print(newproduct);
    final Map<String, dynamic> data = {
      'title': newproduct.title,
      'price': newproduct.price,
      'description': newproduct.description,
      'image': newproduct.image
    };
    final onlinedata = json.encode(data);
    http.Response response = await http.post(
        'https://flutterstore-c3a00.firebaseio.com/products.json',
        body: onlinedata);
    final String id = jsonDecode(response.body)['name'];
    newproduct.id = id;
    print(newproduct);
    _products.add(newproduct);
    isloading = false;
    notifyListeners();
  }

  /////////////////////////////
  voidUpdateProduct(Product newproduct, int index) async {
    isloading = true;
    notifyListeners();
    print(newproduct);
    final Map<String, dynamic> data = {
      'title': newproduct.title,
      'price': newproduct.price,
      'description': newproduct.description,
      'image': newproduct.image
    };
    final onlinedata = json.encode(data);
    await http.put(
        'https://flutterstore-c3a00.firebaseio.com/products/${_products[index].id}.json',
        body: onlinedata);
    newproduct.id = _products[index].id;
    print(newproduct);
    _products.insert(index, newproduct);
    isloading = false;
    notifyListeners();
  }

//////////////////////////////////////////////////////////////
  Future<void> fetchProducts() async {
    List<Product> fetchedproducts = [];
    isloading = true;
    notifyListeners();
    http.Response response = await http
        .get('https://flutterstore-c3a00.firebaseio.com/products.json');
    final Map<String, dynamic> onlineproducts = jsonDecode(response.body);
    if (onlineproducts != null) {
      onlineproducts.forEach((String productid, dynamic products) {
        Product fetchedProduct = Product(
            title: products['title'],
            description: products['description'],
            image: products['image'],
            location: products['location'],
            price: products['price'],
            id: productid);
        fetchedproducts.add(fetchedProduct);
      });
    }
    _products = fetchedproducts;
    isloading = false;
    notifyListeners();
  }
}
