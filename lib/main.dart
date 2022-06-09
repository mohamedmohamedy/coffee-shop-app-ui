import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/products_screen.dart';
import './screens/product_details.dart';
import 'screens/products_screen.dart';
import 'screens/home_screen.dart';

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
                image: '',
                image2: '',
                price: 0,
                description: '')),
        ChangeNotifierProvider(create: (context) => CoffeeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Shop',
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(255, 144, 42, .7),
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
        },
      ),
    );
  }
}
