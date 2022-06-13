import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/coffee_provider.dart';

import '../widgets/image_handler.dart';
import '../widgets/publicButton.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = 'add-product-screen';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  File? image1;
  File? image2;
  String? image164;
  String? image264;
  final _form = GlobalKey<FormState>();
  bool _isinit = true;
  var _addedProduct = Product(
    id: null,
    name: 'name',
    image: Image(image: AssetImage('')),
    price: 0,
    description: '',
    image2: Image(image: AssetImage(''),),

  );

  var _intialValues = {
    'name': '',
    'price': '',
    'description': '',
    'image1': Image(image: AssetImage('')),
    'image2': Image(image: AssetImage('')),
  };

  @override
  void dispose() {
    super.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isinit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
         _addedProduct =
            Provider.of<CoffeeProvider>(context, listen: false)
                .findById(productId.toString());
        _intialValues = {
          'price': _addedProduct.price.toString(),
          'name': _addedProduct.name.toString(),
          'description': _addedProduct.description.toString(),
          'image1': _addedProduct.image,
          'image2': _addedProduct.image2,
        };
      }
    }

    _isinit = false;
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_addedProduct.id != null) {
      Provider.of<CoffeeProvider>(context, listen: false)
          .updateProduct(_addedProduct.id!, _addedProduct);
    } else {
      Provider.of<CoffeeProvider>(context, listen: false)
          .addNewProduct(_addedProduct);
    }
    Navigator.of(context).pop();
  }

//..................pick the first image........................................
  Future _image1() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final pickedimage = File(image.path);

      List<int> imageBytes = pickedimage.readAsBytesSync();
      String base46Image = base64Encode(imageBytes);

      setState(() {
        image1 = pickedimage;
        image164 = base46Image;
      });
    } on PlatformException catch (error) {
      log('error: $error');
    }
  }

//.............................pick the second image............................
  Future _image2() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final pickedimage = File(image.path);

      List<int> imageBytes = pickedimage.readAsBytesSync();
      String base46Image = base64Encode(imageBytes);

      setState(() {
        image2 = pickedimage;
        image264 = base46Image;
      });
    } on PlatformException catch (error) {
      log('error: $error');
    }
  }

  //............................................................................
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text(
          'Add new product',
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: Color.fromRGBO(67, 41, 13, 1),
        ),
        backgroundColor: const Color.fromRGBO(211, 162, 113, .7),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(67, 41, 13, 1),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
          //.................Form...............................................
          Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                    initialValue: _intialValues['name'].toString(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please insert the Coffee name ';
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                    decoration: const InputDecoration(
                      labelText: 'Enter the Coffee name',
                    ),
                    onSaved: (value) {
                      _addedProduct = Product(
                        id: _addedProduct.id,
                        name: value,
                        image: _addedProduct.image,
                        price: _addedProduct.price,
                        description: _addedProduct.description,
                        image2: _addedProduct.image2,
                      );
                    }),
                TextFormField(
                  initialValue: _intialValues['price'].toString(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the price';
                    }
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  focusNode: _priceFocusNode,
                  textInputAction: TextInputAction.next,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter the price',
                  ),
                  onSaved: (value) {
                    _addedProduct = Product(
                      id: _addedProduct.id,
                      name: _addedProduct.name,
                      image: _addedProduct.image,
                      price: int.parse(value!),
                      description: _addedProduct.description,
                      image2: _addedProduct.image2,
                    );
                  },
                ),
                TextFormField(
                    initialValue: _intialValues['description'].toString(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the description';
                      }
                    },
                    focusNode: _descriptionFocusNode,
                    maxLines: 3,
                    autocorrect: true,
                    keyboardType: TextInputType.multiline,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                    decoration: const InputDecoration(
                      labelText: 'Enter the description',
                    ),
                    onSaved: (value) {
                      _addedProduct = Product(
                        id: _addedProduct.id,
                        name: _addedProduct.name,
                        image: Image.file(image1!),
                        price: _addedProduct.price,
                        description: value,
                        image2: Image.file(image2!),
                        image146: image164,
                        image246: image264,
                      );
                    }),
                //............................images............................
                ImageHandler(
                  image: image1,
                  imageFunction: _image1,
                  buttonText: 'Choose first image',
                ),
                ImageHandler(
                  image: image2,
                  imageFunction: _image2,
                  buttonText: 'Choose second image',
                ),

                //.................../Save Button...............................
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                      height: 40,
                      child: PublicButton(
                        () {
                          _saveForm();
                        },
                        'Save',
                        15,
                        0,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
