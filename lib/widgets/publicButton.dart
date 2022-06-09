import 'package:flutter/material.dart';

class PublicButton extends StatelessWidget {
  final VoidCallback buttonFunction;
  final String text;
  final double textSize;
  final double borderRadius;
  final Color? buttonColor;
  final Color? textColor;

  // ignore: use_key_in_widget_constructors
  const PublicButton(this.buttonFunction, this.text, this.textSize, this.borderRadius,
      {this.buttonColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: buttonFunction,
      child: Text(
        text,
        style: TextStyle(
            fontSize: textSize, fontFamily: 'Roboto', color: textColor),
      ),
    );
  }
}
