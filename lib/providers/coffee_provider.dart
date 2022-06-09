import 'package:flutter/foundation.dart';

import './product_provider.dart';

class CoffeeProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p3',
      name: 'Peet\'s',
      image: 'assets/images/peets.jpg',
      image2: 'assets/images/peets.jpg',
      price: 709,
      description:
          'The highest quality coffees from farms around the world, freshly roasted by hand to bring out every nuance, so you can taste the craft in every cup.',
    ),
    Product(
      id: 'p2',
      name: 'Deathwish',
      image: 'assets/images/deathwish.jpg',
      image2: 'assets/images/deathwish2.jpg',
      price: 600,
      description:
          'The main goal when creating Death Wish Coffee was to provide the strongest flavor and highest caffeine content. After testing and tasting several combinations of shades and beans, the French Roast was the clear cut winner.',
    ),
    
    Product(
      id: 'p1',
      name: 'Esppresso',
      image: 'assets/images/esppresso.jpg',
      image2: 'assets/images/esppresso2.jpg',
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
}
