import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_provider.dart';
import '../models/http_exception.dart';

class CoffeeProvider with ChangeNotifier {
  List<Product> _items = [];
  String? token;

  CoffeeProvider(this.token, this._items);

// get a copy of the products.
  List<Product> get items {
    return [..._items];
  }

// to find specific product by ID
  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

//.................... Fetch products from the database.........................

  Future<void> fetchProducts() async {
    final url = Uri.parse(
        'https://coffee-shop-48c6b-default-rtdb.firebaseio.com/products.json?auth=$token');
    try {
      final response = await http.get(url);

      final fetchedProducts =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Product> newProducts = [];

      fetchedProducts.forEach((prodID, prodData) {
        newProducts.add(
          Product(
            id: prodID,
            name: prodData['name'],
            image1: prodData['image1'],
            price: prodData['price'],
            description: prodData['description'],
            image2: prodData['image2'],
          ),
        );
      });

      _items = newProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

//...........................to add new product.................................
  Future<void> addNewProduct(Product product) async {
    final url = Uri.parse(
        'https://coffee-shop-48c6b-default-rtdb.firebaseio.com/products.json?auth=$token');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': product.name,
            'price': product.price,
            'description': product.description,
            'image1': product.image1,
            'image2': product.image2,
          },
        ),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        name: product.name,
        image1: product.image1,
        price: product.price,
        description: product.description,
        image2: product.image2,
      );

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      {
        log('$error');
        rethrow;
      }
    }
  }

  //......................to update an existing product.........................
  Future<void> updateProduct(String id, Product newProduct) async {
    final url = Uri.parse(
        'https://coffee-shop-48c6b-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
    try {
      await http.patch(url,
          body: json.encode({
            'description': newProduct.description,
            'image1': newProduct.image1,
            'image2': newProduct.image2,
            'price': newProduct.price,
            'name': newProduct.name
          }));

      final oldProduct = _items.indexWhere((element) => element.id == id);
      _items[oldProduct] = newProduct;
      notifyListeners();
    } catch (error) {
      log(name: 'error', '$error');
    }
  }

//...........................Delete product.....................................

  Future<void> deleteProduct(String iD) async {
    final selectedProductIndex =
        _items.indexWhere((product) => product.id == iD);
    Product? selectedProduct = _items[selectedProductIndex];
    _items.removeAt(selectedProductIndex);
    notifyListeners();

    final url = Uri.parse(
        'https://coffee-shop-48c6b-default-rtdb.firebaseio.com/products/$iD.json?auth=$token');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(selectedProductIndex, selectedProduct);
      notifyListeners();
      throw HttpException('Couldn\'t delete product');
    }
    selectedProduct = null;
  }
}
