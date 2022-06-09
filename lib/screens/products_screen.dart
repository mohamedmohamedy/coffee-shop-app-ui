import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coffee_provider.dart';

import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = 'test-screen';
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<CoffeeProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //...................Background.......................................
          Opacity(
            opacity: .7,
            child: Image(
              image: const AssetImage('assets/images/vectorback1.jpg'),
              fit: BoxFit.cover,
              height: screenSize.height,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(211, 162, 113, .8),
            ),
            height: screenSize.height,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //search bar..........................................................
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(84, 59, 31, .5),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(
                    top: 60, left: 30, right: 30, bottom: 20),
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
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Choose your Coffee',
                  style: TextStyle(
                    color: Color.fromRGBO(67, 41, 13, 1),
                    fontFamily: 'Pacifico',
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              //...........................products...................................
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.items.length,
                  itemBuilder: (context, index) => ProductItem(
                    coffeeName: products.items[index].name,
                    firstImage: products.items[index].image,
                    secondImage: products.items[index].image2,
                    price: products.items[index].price,
                    productID: products.items[index].id,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
