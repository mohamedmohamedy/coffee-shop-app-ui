import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_product_screen.dart';

import '../providers/coffee_provider.dart';
import '../providers/auth_provider.dart';

import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = 'test-screen';
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddProductScreen.routeName),
        elevation: 10,
        tooltip: 'Add new product',
        backgroundColor: const Color.fromRGBO(84, 59, 31, .8),
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          //...................Background.....................................................................
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
              //..................search bar..................................................................
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  //................LogOut button.....................................
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 70, left: 30, right: 30, bottom: 20),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: const Color.fromRGBO(84, 59, 31, .5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.black54),
                          ),
                        ),
                        label: const Text('Log out'),
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .signOut();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //........................Headline..............................................................
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
              //...........................products...........................................................
              FutureBuilder(
                future: Provider.of<CoffeeProvider>(context, listen: false)
                    .fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.error != null) {
                    return const Center(
                      child: Text('Error occuerd!'),
                    );
                  } else {
                    return Expanded(
                      child: Consumer<CoffeeProvider>(
                        builder: ((context, products, child) =>
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: products.items.length,
                              itemBuilder: (context, index) => ProductItem(
                                coffeeName: products.items[index].name,
                                firstImage: Image(
                                  image: NetworkImage(
                                      products.items[index].image1!),
                                ),
                                secondImage: Image(
                                  image: NetworkImage(
                                      products.items[index].image2!),
                                ),
                                price: products.items[index].price,
                                productID: products.items[index].id,
                              ),
                            )),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
