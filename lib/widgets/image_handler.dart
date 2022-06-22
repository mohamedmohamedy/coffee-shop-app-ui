
import 'package:flutter/material.dart';

class ImageHandler extends StatelessWidget {
  final String? image;
  final Function imageFunction;

  final String buttonText;

  const ImageHandler(
      {Key? key,
      required this.image,
      required this.imageFunction,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown, width: 1)),
              child: image != null
                  ? FittedBox(
                      child: Image.network(
                        image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Please choose an image to preview',
                        textAlign: TextAlign.center,
                      ),
                    )),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.brown[500]),
              onPressed: () {
                imageFunction();
              },
              icon: const Icon(Icons.image),
              label: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
