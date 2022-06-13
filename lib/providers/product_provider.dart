import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? name;
  final Image image;
  final int? price;
  final String? description;
  final Image image2;
  final String? image146;
  final String? image246;


  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.description,
      required this.image2,
      this.image146,
      this.image246
      });
}
