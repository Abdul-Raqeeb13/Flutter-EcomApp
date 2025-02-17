import 'package:ecomapp/Controller/User/DishesController.dart';
import 'package:ecomapp/View/Users/AddToCart.dart';
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
                ? Center(child: Text("No dishes available"))
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

                                          showModalBottomSheet(context: context, builder: (context){
                                            return AddToCart(dishData: dish);
                                          });
                                          controller.addToCartDishes(dish);
                                          // Add to Cart Functionality
                                          print("${dish["DishName"]} added to cart!");
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
                                          print("Order Now for ${dish["DishName"]}");
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
