import 'dart:convert';

import 'package:flutterapp/Models/securedToken.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../config.dart';
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
      '$ProductsLink/${_products[index].id}${securedToken.getToken()}}',
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
    final onlineData = json.encode(data);
    http.Response response = await http
        .post('$ProductsLink${securedToken.getToken()}', body: onlineData);
    final String id = jsonDecode(response.body)['name'];
    newproduct.id = id;
    print(newproduct);
    _products.add(newproduct);
    isloading = false;
    notifyListeners();
  }

  /////////////////////////////
  voidUpdateProduct(Product newProduct, int index) async {
    isloading = true;
    notifyListeners();
    print(newProduct);
    final Map<String, dynamic> data = {
      'title': newProduct.title,
      'price': newProduct.price,
      'description': newProduct.description,
      'image': newProduct.image
    };
    final onlineData = json.encode(data);
    await http.put(
        '$ProductsLink/${_products[index].id}${securedToken.getToken()}',
        body: onlineData);
    newProduct.id = _products[index].id;
    print(newProduct);
    _products.insert(index, newProduct);
    isloading = false;
    notifyListeners();
  }

//////////////////////////////////////////////////////////////
  Future<void> fetchProducts() async {
    List<Product> fetchedProducts = [];
    isloading = true;
    notifyListeners();
    http.Response response =
        await http.get('$ProductsLink${securedToken.getToken()}');
    final Map<String, dynamic> onlineProducts = jsonDecode(response.body);
    print(onlineProducts);
    if (onlineProducts != null && !onlineProducts.containsKey("error")) {
      onlineProducts.forEach((String productid, dynamic products) {
        Product fetchedProduct = Product(
            title: products['title'],
            description: products['description'],
            image: products['image'],
            location: products['location'],
            price: products['price'],
            id: productid);
        fetchedProducts.add(fetchedProduct);
      });
    }
    _products = fetchedProducts;
    isloading = false;
    notifyListeners();
  }
}
