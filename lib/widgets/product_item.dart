import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details.dart';
import '../screens/add_product_screen.dart';

import '../providers/coffee_provider.dart';

class ProductItem extends StatelessWidget {
  final String? coffeeName;
  final Image firstImage;
  final Image secondImage;
  final int? price;
  final String? productID;

  // ignore: use_key_in_widget_constructors
  const ProductItem({
    required this.coffeeName,
    required this.firstImage,
    required this.secondImage,
    required this.price,
    required this.productID,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        ProductDetails.routeName,
        arguments: productID,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 250,
        child: Stack(
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.grey,
              margin: const EdgeInsets.all(5),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)),
              child: Row(
                children: [
                  //.............Coffee name........................................
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            coffeeName!,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Coffee',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //.........................price............................
                        Chip(
                          label: Text(
                            '\$$price',
                            style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        //....................add icon..............................
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            //primary: Color.fromRGBO(67, 41, 13, .5),
                          ),
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  //........................Images................................
                  SizedBox(
                    height: 100,
                    width: 130,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: firstImage,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 15,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: (secondImage),
                    ),
                  ),
                ],
              ),
            ),
            //..........Edit and Delete icons...................................
            Positioned(
              right: 20,
              top: 10,
              child: Row(
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () async {
                      try {
                        await Provider.of<CoffeeProvider>(context,
                                listen: false)
                            .deleteProduct(productID!);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Deleting failed!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(
                    iconSize: 30,
                    onPressed: () => Navigator.of(context).pushNamed(
                      AddProductScreen.routeName,
                      arguments: productID,
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
