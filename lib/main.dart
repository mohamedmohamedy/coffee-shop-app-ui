import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/products_screen.dart';
import './screens/product_details.dart';
import './screens/add_product_screen.dart';

import 'providers/product_provider.dart';
import 'providers/coffee_provider.dart';

void main() {
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
                image: Image(image: AssetImage('')),
                image2:Image(image: AssetImage('')) ,
                price: 0,
                description: '')),
        ChangeNotifierProvider(create: (context) => CoffeeProvider()),
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
        },
      ),
    );
  }
}
