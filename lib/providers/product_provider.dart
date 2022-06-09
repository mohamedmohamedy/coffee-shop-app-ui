import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String image;
  final int price;
  final String description;
  final String image2;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.image2
  });
}
