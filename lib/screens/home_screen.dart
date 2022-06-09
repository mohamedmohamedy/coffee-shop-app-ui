import 'package:flutter/material.dart';

import '../screens/products_screen.dart';

import '../widgets/publicButton.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
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
          Positioned(
            top: screenSize.height * .1,
            left: screenSize.width * .2,
            child: const Image(
              image: AssetImage('assets/images/cup.png'),
              height: 200,
              width: 200,
            ),
          ),
          Positioned(
            top: screenSize.height * .38,
            left: screenSize.width * .2,
            child: const Text(
              'Coffee Shop',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 37,
                  color: Color.fromRGBO(67, 41, 13, 1)),
            ),
          ),
          Positioned(
            top: screenSize.height * .85,
            left: screenSize.width * .16,
            child: SizedBox(
              height: 50,
              width: 250,
              child: PublicButton(
                () => Navigator.of(context).pushNamed(ProductsScreen.routeName),
                'Get started',
                19,
                25,
                buttonColor: const Color.fromRGBO(84, 59, 31, .7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
