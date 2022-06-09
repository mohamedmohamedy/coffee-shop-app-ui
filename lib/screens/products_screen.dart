
import 'package:flutter/material.dart';

import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = 'product-screen';
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //search bar..........................................................
          Container(
            margin: const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 20),
            height: 50,
            width: 100,
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),

          //........................Headline....................................
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              'Our Products',
              style: TextStyle(
                  color: Colors.black45, fontFamily: 'Roboto', fontSize: 40),
              textAlign: TextAlign.start,
            ),
          ),
          //...........................products...................................
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: const[
               
                 ProductItem(
                  coffeeName: 'Peet\'s',
                  firstImage: 'assets/images/peets.jpg',
                  secondImage: 'assets/images/peets.jpg',
                  price: 709,
                  productID: 'p3',
                ),
                ProductItem(
                  coffeeName: 'Deathwish',
                  firstImage: 'assets/images/deathwish.jpg',
                  secondImage: 'assets/images/deathwish2.jpg',
                  price: 600,
                  productID: 'p2',
                ),
                ProductItem(
                  coffeeName: 'Esppresso',
                  firstImage: 'assets/images/esppresso.jpg',
                  secondImage: 'assets/images/esppresso2.jpg',
                  productID: 'p1',
                  price: 530,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
