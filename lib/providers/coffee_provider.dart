import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_provider.dart';

class CoffeeProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

// to find specific product by ID
  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

// Fetch products from the database.

  Future<void> fetchProducts() async {
    final url = Uri.parse(
        'https://coffee-shop-48c6b-default-rtdb.firebaseio.com/products.json');
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

// to add new product.
  Future<void> addNewProduct(Product product) async {
    final url = Uri.parse(
        'https://coffee-shop-48c6b-default-rtdb.firebaseio.com/products.json');
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

  //to update an existing product.
  void updateProduct(String id, Product newProduct) {
    final oldProduct = _items.indexWhere((element) => element.id == id);
    _items[oldProduct] = newProduct;
    notifyListeners();
  }
}
