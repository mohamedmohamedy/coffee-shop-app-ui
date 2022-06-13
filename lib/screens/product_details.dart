import 'package:coffee_shop/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../providers/coffee_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/publicButton.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = 'product-details-screen';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double? _ratingValue;

  bool _iselected1 = true;
  bool _iselected2 = false;
  bool _iselected3 = false;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<CoffeeProvider>(context, listen: false).findById(productId);
    return Scaffold(
      
      body: Column(
        children: [
          //................images..............................................
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              //color: Colors.grey,
            ),
            height: 300,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const Image(
                    image: AssetImage('assets/images/whitecoffee3.jpg'),
                    fit: BoxFit.cover,
                    //height: 300,
                  ),
                ),
                Positioned(
                  top: 130,
                  right: 70,
                  child: SizedBox(
                      height: 170, width: 200, child: loadedProduct.image),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      primary: Colors.blueGrey[900],
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
          ),
          //.................Name and Price.....................................
          const SizedBox(height: 10),
          //....................................................................
          Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loadedProduct.name! + ' Coffee',
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$' + loadedProduct.price.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    //...................Rating.................................
                    RatingBar(
                        itemSize: 20,
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.orange),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValue = value;
                          });
                        }),
                    const SizedBox(width: 10),
                    Text(
                      _ratingValue != null
                          ? _ratingValue.toString()
                          : 'Rate it!',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    //.....................Review...............................
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      '(34 Reviews)',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //..................................qonatity............................
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(25),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PublicButton(
                  () {
                    setState(() {
                      _iselected1 = true;
                      _iselected2 = false;
                      _iselected3 = false;
                    });
                  },
                  '250gm',
                  15,
                  25,
                  buttonColor: _iselected1 ? Colors.orange : Colors.orange[50],
                  textColor: _iselected1 ? Colors.white : Colors.black,
                ),
                PublicButton(() {
                  setState(
                    () {
                      _iselected1 = false;
                      _iselected2 = true;
                      _iselected3 = false;
                    },
                  );
                }, '500gm', 15, 25,
                    buttonColor:
                        _iselected2 ? Colors.orange : Colors.orange[50],
                    textColor: _iselected2 ? Colors.white : Colors.black),
                PublicButton(
                  () {
                    setState(() {
                      _iselected1 = false;
                      _iselected2 = false;
                      _iselected3 = true;
                    });
                  },
                  '1000gm',
                  15,
                  25,
                  buttonColor: _iselected3 ? Colors.orange : Colors.orange[50],
                  textColor: _iselected3 ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
          //.......................describtion.................................
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      loadedProduct.description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey[400]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //........................Button......................................
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SizedBox(
                width: 300,
                child: PublicButton(
                  () {},
                  'Buy Now',
                  15,
                  8,
                )),
          ),
        ],
      ),
    );
  }
}
