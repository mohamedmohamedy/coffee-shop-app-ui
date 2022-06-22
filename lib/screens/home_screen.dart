import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_products_screen.dart';
import 'user_products_screen.dart';
import '../screens/auth_screen.dart';

import '../providers/auth_provider.dart';

import '../widgets/publicButton.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final authData = Provider.of<AuthProvider>(context);

    // Check if the user has a token or not, if he has a valid one he will be signed in automatically, if not he will need to authenticate.
    void tryLogin() {
      authData.autoLogIn().then(
        (_) {
          if (authData.isAuth) {
            // if it's the admin who logging in or a user.
            if (authData.userId == 'NTzenSI2EoNkWbw02BBBZNXCdM02') {
              Navigator.of(context).pushNamed(AdminProductsScreen.routeName);
            } else {
              Navigator.of(context).pushNamed(UserProductsScreen.routeName);
            }
          }

          if (!authData.isAuth) {
            Navigator.of(context).pushNamed(AuthScreen.routeName);
          }
        },
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          //..................Background........................................
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
          //.....................Logo.............................................
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
                color: Color.fromRGBO(67, 41, 13, 1),
              ),
            ),
          ),
          //......................... Starting button..............................
          Positioned(
            top: screenSize.height * .85,
            left: screenSize.width * .16,
            child: SizedBox(
              height: 50,
              width: 250,
              child: PublicButton(
                // if user got a token, navigate automatically to products screen. if not sign in or sign up.
                () => tryLogin(),
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
