import 'dart:convert';
import 'dart:io';

import 'package:flutterapp/Models/google_drive.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'OAuthModel.dart';
import 'Product.dart';
import 'file_uploader.dart';

class ProductModel extends OAuthModel with GoogleDrive, FirebaseUploader {
  File uploadedImage;
  bool isloading = false;
  int currentProductIndex = 0;
  Product currentProduct = Product(image: 'assets/4.png');
  List<Product> _products = [
    Product(title: 'no.1', price: 20.0, image: 'assets/login.jpg'),
  ];

  List<Product> productsAquire() {
    return _products;
  }

  void goToProduct(int index) {
    currentProductIndex = index;
    notifyListeners();
  }

  //////////////////////////

  Product singleProductAquire(int index) {
    return _products[index];
  }

  Product currentProductAquire() {
    return _products[currentProductIndex];
  }

  //////////////////////////
  void deleteProduct(int index) async {
    isloading = true;
    notifyListeners();
    await http.delete(
      '$ProductsLink/${_products[index].id}${getToken()}.json',
    );
    _products.removeAt(index);
    isloading = false;
    notifyListeners();
  }

  void deleteCurrentProduct() {
    _products.removeAt(currentProductIndex);
    notifyListeners();
  }
/////////////////////////////////////////////

  toggleFavorate(int index) {
    _products[index].favoraite = _products[index].favoraite ? false : true;
    notifyListeners();
  }

  toggleCurrentFavorate() {
    _products[currentProductIndex].favoraite =
        _products[currentProductIndex].favoraite ? false : true;
    notifyListeners();
  }

  /////////////////////////////
  Future<void> addProduct(Product newProduct) async {
    isloading = true;
    notifyListeners();

    await uploadImage(uploadedImage);

    print(newProduct);
    final Map<String, dynamic> data = {
      'title': newProduct.title,
      'price': newProduct.price,
      'description': newProduct.description,
      'imagePath': 0,
      'image': 'assets/4.png',
      'imageUrl': 0,
      'address': newProduct.address,
      'loc_lat': newProduct.location.latitude,
      'loc_long': newProduct.location.longitude,
    };
    final onlineData = json.encode(data);
    http.Response response =
        await http.post('$ProductsLink${getToken()}.json', body: onlineData);
    final String id = jsonDecode(response.body)['name'];
    newProduct.id = id;
    print(newProduct);
    _products.add(newProduct);
    isloading = false;
    notifyListeners();
  }

  /////////////////////////////
  Future<void> updateProduct(Product newProduct, int index) async {
    isloading = true;
    notifyListeners();
    print(newProduct);
    final Map<String, dynamic> data = {
      'title': newProduct.title,
      'price': newProduct.price,
      'description': newProduct.description,
      'image': newProduct.image,
      'address': newProduct.address,
      'loc_lat': newProduct.location.latitude,
      'loc_long': newProduct.location.longitude,
    };
    final onlineData = json.encode(data);
    await http.put('$ProductsLink/${_products[index].id}${getToken()}.json',
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
    http.Response response = await http.get('$ProductsLink${getToken()}.json');
    print(response.body);
    final Map<String, dynamic> onlineProducts = jsonDecode(response.body);
    print(onlineProducts);
    if (onlineProducts != null && !onlineProducts.containsKey("error")) {
      onlineProducts.forEach((String productid, dynamic products) {
        Position position = Position(
            latitude: products['loc_lat'], longitude: products['loc_long']);
        Product fetchedProduct = Product(
            title: products['title'],
            description: products['description'],
            image: products['image'],
            location: position,
            address: products['address'],
            price: products['price'],
            id: productid);
        fetchedProducts.add(fetchedProduct);
      });
    }
    _products = fetchedProducts;
    isloading = false;
    notifyListeners();
  }

  getToken() {
    return '';
  }

  setImage(File image) {
    uploadedImage = image;
    notifyListeners();
  }

//  Future<Map<String, dynamic>> uploadImage(File image,
//      {String imagePath}) async {
//    final mimeTypeData = lookupMimeType(image.path).split('/');
//    final imageUploadRequest = http.MultipartRequest(
//        'POST',
//        Uri.parse(
//            'https://us-central1-flutterstore-c3a00.cloudfunctions.net/storeImage'));
//    final file = await http.MultipartFile.fromPath(
//      'image',
//      image.path,
//      contentType: MediaType(
//        mimeTypeData[0],
//        mimeTypeData[1],
//      ),
//    );
//    imageUploadRequest.files.add(file);
//    if (imagePath != null) {
//      imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
//    }
//    imageUploadRequest.headers['Authorization'] = 'Bearer $getTokenName';
//
//    try {
//      final streamedResponse = await imageUploadRequest.send();
//      final response = await http.Response.fromStream(streamedResponse);
//      if (response.statusCode != 200 && response.statusCode != 201) {
//        print('Something went wrong');
//        print((response.statusCode));
//        print(json.decode(response.body));
//        return null;
//      }
//      final responseData = json.decode(response.body);
//      return responseData;
//    } catch (error) {
//      print(error);
//      return null;
//    }
//  }
}
