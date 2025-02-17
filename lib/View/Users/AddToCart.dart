import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {

  var dishData;
  AddToCart({super.key, required this.dishData});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: Column(
        children: [
          Text(widget.dishData["DishName"])
        ],
      ),
    );
  }
}