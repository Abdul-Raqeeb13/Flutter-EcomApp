// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/User/UserAddToCartController.dart';
import 'package:ecomapp/Controller/User/UserDishesController.dart';
import 'package:ecomapp/View/Users/UserBottomeAddToCart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserViewSpecificDish extends StatefulWidget {
  final dynamic categoryData;

  UserViewSpecificDish({super.key, required this.categoryData});

  @override
  State<UserViewSpecificDish> createState() => _UserViewSpecificDishState();
}

class _UserViewSpecificDishState extends State<UserViewSpecificDish> {
  final UserDishes dishesController = Get.put(UserDishes());
  // final addTocartController = Get.put(userAddtoCartController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSpecificCategoryDishes();
    });
  }

  void getSpecificCategoryDishes() {
    var categoryKey = widget.categoryData["CategoryKey"];
    dishesController.getDishesByCategoryId(categoryKey);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryData["CategoryName"]),
        ),
        body: GetBuilder<UserDishes>(
          builder: (controller) {
            return controller.specificCategorydishList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.no_food,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "No Dishes Available",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Please check back later or explore other categories.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: controller.specificCategorydishList.length,
                    itemBuilder: (context, index) {
                      var dish = controller.specificCategorydishList[index];
                      return Container(
                        width: screenWidth * 0.25, // Card width
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          elevation: 25,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Dish Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    dish["DishImage"],
                                    width: double.infinity, // Full width
                                    height: screenHeight * 0.3,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Dish Name & Price
                                Text(
                                  dish["DishName"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Price: Rs ${dish["DishPrice"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 15),
                                // Buttons Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Add to Cart Button
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                            ),
                                            builder: (context) {
                                              return Container(
                                                height: screenHeight *
                                                    0.34, // Fixed height in pixels
                                                padding: EdgeInsets.all(16),
                                                child:
                                                    AddToCart(dishData: dish),
                                              );
                                            },
                                          );

                                          // Add to Cart Functionality
                                          // print("${dish["DishName"]} added to cart!");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                        ),
                                        child: Text("Add to Cart"),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Order Now Button
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Order Now Functionality
                                          print(
                                              "Order Now for ${dish["DishName"]}");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                        ),
                                        child: Text("Order Now"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
