import 'package:flutter/material.dart';

class UserAllAddToCart extends StatefulWidget {
  const UserAllAddToCart({super.key});

  @override
  State<UserAllAddToCart> createState() => _UserAllAddToCartState();
}

class _UserAllAddToCartState extends State<UserAllAddToCart> {
  @override
  Widget build(BuildContext context) {
 return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Add To Carts"),
        ),
        
        body: Column(
          children: [
            Text("Add To Card"),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Text("Add to Card");
              },
            ),

          ],
        ),
        ));
          }
}