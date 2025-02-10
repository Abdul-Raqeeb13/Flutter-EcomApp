// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  var width;
  var hintText; 
  var prefixIcon;
  var suffixIcon;
  TextEditingController controller;
  final String? Function(String?)? validator;
  bool obscureText;

  TextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: ScreenWidth,
      margin: EdgeInsets.symmetric(horizontal: ScreenWidth * 0.05, vertical: ScreenHeight*0.016),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12), // Reduced padding
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
