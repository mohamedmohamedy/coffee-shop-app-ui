import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_provider.dart';

class CoffeeProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p3',
      name: 'Peet\'s',
      image: const Image(
          image: AssetImage('assets/images/peets.jpg'), fit: BoxFit.fill),
      image2: const Image(
          image: AssetImage('assets/images/peets.jpg'), fit: BoxFit.fill),
      price: 709,
      description:
          'The highest quality coffees from farms around the world, freshly roasted by hand to bring out every nuance, so you can taste the craft in every cup.',
    ),
    Product(
      id: 'p2',
      name: 'Deathwish',
      image: const Image(
          image: AssetImage('assets/images/deathwish.jpg'), fit: BoxFit.fill),
      image2: const Image(
          image: AssetImage('assets/images/deathwish2.jpg'), fit: BoxFit.fill),
      price: 600,
      description:
          'The main goal when creating Death Wish Coffee was to provide the strongest flavor and highest caffeine content. After testing and tasting several combinations of shades and beans, the French Roast was the clear cut winner.',
    ),
    Product(
      id: 'p1',
      name: 'Esppresso',
      image: const Image(
          image: AssetImage('assets/images/esppresso.jpg'), fit: BoxFit.fill),
      image2: const Image(
          image: AssetImage('assets/images/esppresso2.jpg'), fit: BoxFit.fill),
      price: 530,
      description:
          'Espresso is a concentrated form of coffee served in small, strong shots and is the base for many coffee drinks. It\'s made from the same beans as coffee but is stronger, thicker, and higher in caffeine.',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addNewProduct(Product product) {
    final url = Uri.parse(
        'https://coffee-shop-48c6b-default-rtdb.firebaseio.com/products.json');

    http.post(url,
        body: json.encode({
          'name': product.name,
          'price': product.price,
          'description': product.description,
          'image1': product.image146,
          'image2': product.image246,
        }));

    final newProduct = Product(
      id: DateTime.now().toString(),
      name: product.name,
      image: product.image,
      price: product.price,
      description: product.description,
      image2: product.image2,
    );

    _items.add(newProduct);

    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final oldProduct = _items.indexWhere((element) => element.id == id);
    _items[oldProduct] = newProduct;
    notifyListeners();
  }
}
