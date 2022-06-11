import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  void dispose() {
    super.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
  }

//..................pick the first image........................................
  Future _image1() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final pickedimage = File(image.path);

      setState(() {
        image1 = pickedimage;
      });
    } on PlatformException catch (error) {
      print('error: $error');
    }
  }

//.............................pick the second image............................
  Future _image2() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final pickedimage = File(image.path);

      setState(() {
        image2 = pickedimage;
      });
    } on PlatformException catch (error) {
      print('error: $error');
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
        backgroundColor: Color.fromRGBO(211, 162, 113, .7),
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
            child: ListView(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  decoration: const InputDecoration(
                    labelText: 'Enter the Coffee name',
                  ),
                ),
                TextFormField(
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  focusNode: _priceFocusNode,
                  textInputAction: TextInputAction.next,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter the price',
                  ),
                ),
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  maxLines: 3,
                  autocorrect: true,
                  keyboardType: TextInputType.multiline,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  decoration: const InputDecoration(
                    labelText: 'Enter the description',
                  ),
                ),
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
                        () {},
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
