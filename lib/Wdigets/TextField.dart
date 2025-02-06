// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  var width;
  var hintText; 
  var prefixIcon;
  var suffixIcon;
  TextEditingController controller;
  final String? Function(String?)? validator; // Validator function
  bool obscureText;  // Add this to manage visibility

  TextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.obscureText,  // Receive the value of obscureText
  });

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      margin: EdgeInsets.symmetric(
          horizontal: ScreenWidth * 0.05, vertical: ScreenHeight * 0.016),
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 10, // Soft blur effect
            offset: Offset(2, 2), // Shadow direction
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,  // Bind the obscureText here
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,  // This will now work with the IconButton
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Match Container's border
            borderSide: BorderSide.none, // No default border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: Colors.blue, width: 2), // Blue border on focus
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: Colors.grey, width: 1), // Gray border normally
          ),
          filled: true,
          fillColor: Colors.white, // Ensures background color is applied
        ),
      ),
    );
  }
}
