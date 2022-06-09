

import 'package:flutter/material.dart';

import '../screens/products_screen.dart';



class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //image

          const SizedBox(
            height: 300,
            width: 200,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image(
                image: AssetImage(
                  'assets/images/beans.jpg',
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              children: const [
                SizedBox(
                  height: 250,
                  width: 400,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Image(
                        image: AssetImage('assets/images/coffeevector.jpg')),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Text(
                    textAlign: TextAlign.center,
                    ' All the coffee you need',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //button
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 10, top: 0, bottom: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(20, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(ProductsScreen.routeName),
              child: const Text(
                'Explore',
                style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
