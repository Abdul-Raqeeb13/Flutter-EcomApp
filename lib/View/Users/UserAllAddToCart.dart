// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/User/UserAddToCartController.dart';
import 'package:ecomapp/Wdigets/Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAllAddToCart extends StatefulWidget {
  const UserAllAddToCart({super.key});

  @override
  State<UserAllAddToCart> createState() => _UserAllAddToCartState();
}

class _UserAllAddToCartState extends State<UserAllAddToCart> {
var controller = Get.put(UserAddtoCartController());
  var totalPrice = 0;

   void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((data) {
      getAddToCard();
    });
  }

  getAddToCard() {
    print(controller.userCard.toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Add To Carts"),
        ),
        body: GetBuilder<UserAddtoCartController>(
          builder: (controller) {
            return controller.userCard.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your cart is empty!",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Visit the dishes section and select your favorite items.",
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
                    itemCount: controller.userCard.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        totalPrice = 0;
                      }
                      var price =
                          int.parse(controller.userCard[index]["DishPrice"]) *
                              controller.userCard[index]["quantity"];
                      totalPrice += price.toInt();
                      var dish = controller.userCard[index];
                      return Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: ListTile(
                              leading: Image.network(
                                dish["DishImage"],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                dish["DishName"],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Price: \$${price}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove,
                                        color: Colors.red),
                                    onPressed: () {
                                      controller.decrementQuantity(index);
                                      controller.update(); // Update UI
                                    },
                                  ),
                                  Text(
                                    "${dish["quantity"]}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        color: Colors.green),
                                    onPressed: () {
                                      controller.incrementQuantity(index);
                                      controller.update(); // Update UI
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (index == controller.userCard.length - 1)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                padding: EdgeInsets.all(6),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total Price"),
                                        Text(totalPrice.toString())
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButtonWidget(
            onPress: () => controller.showBottomSheetFunc(
                context, totalPrice), // Wrap in a function
            buttonText: "Order Now",
            buttonwidth: screenWidth,
          ),
        ),
      ),
    );
  }
}
