// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/Admin/AdminDashboardController.dart';
import 'package:ecomapp/View/Admin/AdminDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var controller = Get.put(AdminDashboardController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDashboardData();
    });
  }

  getDashboardData() {
    controller.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin Dashboard"),
        ),
        drawer: const Drawer(
          child: DrawerData(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<AdminDashboardController>(
            builder: (controller) {
              return controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 14), // Prevents top overflow
                          Text(
                            "Dashboard Overview",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 14), // Extra spacing for better UI
                          SizedBox(
                            height: MediaQuery.of(context).size.height,  // Prevents overflow
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                DashboardCard(
                                  title: "Total Users",
                                  value: controller.usersCount.toString(),
                                  icon: Icons.person,
                                  color: Colors.blue,
                                ),
                                DashboardCard(
                                  title: "Categories",
                                  value: controller.Categories.toString(),
                                  icon: Icons.category,
                                  color: Colors.green,
                                ),
                                DashboardCard(
                                  title: "Total Dishes",
                                  value: controller.Dishes.toString(),
                                  icon: Icons.fastfood,
                                  color: Colors.orange,
                                ),
                                DashboardCard(
                                  title: "Pending Orders",
                                  value: controller.pendingOrder.toString(),
                                  icon: Icons.pending_actions,
                                  color: Colors.red,
                                ),
                                DashboardCard(
                                  title: "Completed Orders",
                                  value: controller.completeOrder.toString(),
                                  icon: Icons.check_circle,
                                  color: Colors.teal,
                                ),
                                DashboardCard(
                                  title: "Cancelled Orders",
                                  value: controller.cancelOrder.toString(),
                                  icon: Icons.cancel,
                                  color: Colors.purple,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            // const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
