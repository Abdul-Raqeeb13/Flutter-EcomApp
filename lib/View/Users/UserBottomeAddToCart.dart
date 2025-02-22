// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/User/UserAddToCartController.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddToCart extends StatefulWidget {
  final Map<String, dynamic> dishData;

  AddToCart({super.key, required this.dishData});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  // int quantity = 1; // Default quantity
  var controller = Get.put(userAddtoCartController());
  var status = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getBackData();
      checkDish();
    });
  }

  // getBackData() async {
  //   await controller.getAllCard();
  // }

  checkDish() async {
    // await controller.getData();
    var res = await controller.checkCard(widget.dishData);
    setState(() {
      status = res;
      print(status);
    });
  }

  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dish Name
            Text(
              widget.dishData["DishName"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            // Quantity Selector + Price

            SizedBox(height: 16),

            // Add to Cart Button
            status
                ? Column(
                    children: [
                      Text("This is already added in add to cart"),
                      SizedBox(height: 20),
                    ],
                  )
                : SizedBox.shrink(), // More efficient than an empty Container

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  controller.userAddToCard(widget.dishData);
                  snackBarMessagePopup(
                      "Success", "Item added success", Colors.green, false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  status ? "Remove From Cart" : "Add To Cart",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
