// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/Admin/AdminOrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminViewAllOrders extends StatefulWidget {
  final String status;
  AdminViewAllOrders({super.key, required this.status});

  @override
  State<AdminViewAllOrders> createState() => _AdminViewAllOrdersState();
}

class _AdminViewAllOrdersState extends State<AdminViewAllOrders> {
  final controller = Get.put(AdminGetOrderController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOrdersDetails();
    });
  }

  void getOrdersDetails() {
    controller.getOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.Orders.isEmpty
                ? const NoResultsScreen()
                : ListView.builder(
                    itemCount: controller.Orders.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    itemBuilder: (context, index) {
                      var order = controller.Orders[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Order Details
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order #${order["orderkey"]}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${order["totalPrice"]}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              Text(
                                order["email"],
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 5),

                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Expanded(child: Text(order["address"])),
                                ],
                              ),
                              const SizedBox(height: 5),

                              Row(
                                children: [
                                  const Icon(Icons.phone,
                                      size: 16, color: Colors.blue),
                                  const SizedBox(width: 5),
                                  Text(order["contact"]),
                                ],
                              ),
                              const SizedBox(height: 15),

                              // Expansion Tile for Order Items
                              ExpansionTile(
                                title: Text(
                                  "View Items",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                children: (order["orders"] as List)
                                    .map<Widget>((item) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 25, // Adjust size as needed
                                      backgroundColor:
                                          Colors.grey[200], // Background color
                                      backgroundImage:
                                          item["DishImage"] != null &&
                                                  item["DishImage"].isNotEmpty
                                              ? NetworkImage(item["DishImage"])
                                              : null, // Show image if available
                                      child: item["DishImage"] == null ||
                                              item["DishImage"].isEmpty
                                          ? Icon(Icons.image_not_supported,
                                              color: Colors.grey)
                                          : null, // Show icon if image is missing
                                    ),
                                    title: Text(item["DishName"]),
                                    subtitle:
                                        Text("Quantity: ${item["quantity"]}"),
                                    trailing: Text("\$${item["DishPrice"]}"),
                                  );
                                }).toList(),
                              ),

                              // Action Buttons
                              if (widget.status == "pending")
                                _buildActionButtons(
                                  onAccept: () => controller.UpdateOrder(
                                      order["orderkey"], "accepted", "", index, "pending"),
                                  onReject: () {
                                    controller.UpdateOrder(
                                      order["orderkey"], "rejected", "", index, "pending");
                                  },
                                )
                              else if (widget.status == "inprogress")
                                _buildSingleActionButton(
                                  text: "Complete",
                                  color: Colors.green,
                                  onPressed: () => controller.InProgressOrder(
                                      order["orderkey"], "completed", "", index, "inprogress"),
                                )

                              else if (widget.status == "accepted")
                                _buildSingleActionButton(
                                  text: "Start",
                                  color: Colors.green,
                                  onPressed: () => controller.UpdateOrder(
                                      order["orderkey"], "inprogress", "", index, "accepted"),
                                ),
                                
                              
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _buildActionButtons(
      {required VoidCallback onAccept, required VoidCallback onReject}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSingleActionButton(
            text: "Accept", color: Colors.green, onPressed: onAccept),
        _buildSingleActionButton(
            text: "Reject", color: Colors.red, onPressed: onReject),
      ],
    );
  }

  Widget _buildSingleActionButton(
      {required String text,
      required Color color,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(text.toUpperCase()),
    );
  }
}

// No Results Screen
class NoResultsScreen extends StatelessWidget {
  const NoResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            Text(
              "No Results!",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "We couldn't find any matches for your search.\nTry using different terms or browse categories.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Search Again".toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
