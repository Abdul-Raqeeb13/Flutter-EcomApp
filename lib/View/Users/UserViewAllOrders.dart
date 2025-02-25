// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/User/UserViewAllOrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOrders extends StatefulWidget {
  final String status;
  UserOrders({super.key, required this.status});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  var orderController = Get.put(viewAllController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOrder();
    });
  }

  getOrder() async {
    await orderController.getOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blueAccent.withOpacity(0.1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: GetBuilder<viewAllController>(builder: (controller) {
        return orderController.orders.isEmpty
            ? Center(
                child: Text(
                  "No Orders Yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: orderController.orders.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.only(bottom: 15),
                    child: ExpansionTile(
                      leading: Icon(Icons.receipt_long, color: Colors.blue),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${orderController.orders[index]["orderkey"].toString()}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "\$${orderController.orders[index]["totalPrice"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orderController.orders[index]["orders"].length,
                          itemBuilder: (context, index2) {
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  orderController.orders[index]["orders"][index2]["DishImage"],
                                ),
                              ),
                              title: Text(
                                orderController.orders[index]["orders"][index2]["DishName"],
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "Quantity: ${orderController.orders[index]["orders"][index2]["quantity"]}",
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                              trailing: Text(
                                "\$${orderController.orders[index]["orders"][index2]["DishPrice"]}",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              );
      }),
    );
  }
}
