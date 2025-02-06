// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  var buttonText;
  var buttonwidth;
  final void Function() onPress;

  ElevatedButtonWidget(
      {super.key, this.buttonText, this.buttonwidth, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonwidth, // Full width inside the container
      padding:
          EdgeInsets.symmetric(horizontal: 20, vertical: 7), // Optional padding
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Button background color
          padding: EdgeInsets.symmetric(vertical: 10), // Vertical padding
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Bold text for modern feel
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13), // Rounded corners
          ),
          elevation: 15, // Shadow for the button
        ),
        child: Text(buttonText),
      ),
    );
  }
}
