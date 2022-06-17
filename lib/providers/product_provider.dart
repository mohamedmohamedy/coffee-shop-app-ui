import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? name;
  
  final int? price;
  final String? description;
  
  final String? image1;
  final String? image2;
  
 

  Product(
      {required this.id,
      required this.name,
      required this.image1,
      required this.price,
      required this.description,
      required this.image2,
      });
}
