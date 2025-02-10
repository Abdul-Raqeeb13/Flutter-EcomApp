import 'package:ecomapp/View/Admin/DrawerData.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to admin dashb board"),
        ),
        drawer: Drawer(
          child: DrawerData(),
        ),
      )
    );
  }
}