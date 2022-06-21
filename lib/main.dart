import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './screens/home_screen.dart';
import './screens/products_screen.dart';
import './screens/product_details.dart';
import './screens/add_product_screen.dart';
import './screens/auth_screen.dart';

import './providers/product_provider.dart';
import './providers/coffee_provider.dart';
import './providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Product(
              id: '',
              name: '',
              image1: '',
              image2: '',
              price: 0,
              description: ''),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CoffeeProvider>(
          create: (context) => CoffeeProvider('', []),
          update: (context, auth, previousProducts) => CoffeeProvider(
              auth.token,
              previousProducts == null ? [] : previousProducts.items),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Shop',
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(67, 41, 13, 1),
            secondary: Color.fromRGBO(255, 144, 42, .7),
          ),
          textTheme:
              const TextTheme(headline6: TextStyle(fontFamily: 'Pacifico')),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          ProductsScreen.routeName: (ctx) => const ProductsScreen(),
          ProductDetails.routeName: (ctx) => const ProductDetails(),
          AddProductScreen.routeName: (context) => const AddProductScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
        },
      ),
    );
  }
}
