// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/View/Admin/AdminDrawer.dart';
import 'package:ecomapp/View/Admin/AdminViewAllOrders.dart';
import 'package:flutter/material.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          child: DrawerData(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 10,
          title: Center(
            child: Text(
              "Admin Orders",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
                letterSpacing: 1.2,
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blueAccent.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black54,
                labelColor: Colors.white,
                indicator: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(child: Padding(padding: EdgeInsets.all(8), child: Text("Pending"))),
                  Tab(child: Padding(padding: EdgeInsets.all(8), child: Text("Accepted"))),
                  Tab(child: Padding(padding: EdgeInsets.all(8), child: Text("In Progress"))),
                  Tab(child: Padding(padding: EdgeInsets.all(8), child: Text("Completed"))),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // AdminViewAllOrders()
            AdminViewAllOrders(status: "pending"),
            AdminViewAllOrders(status: "accepted"),  
            AdminViewAllOrders(status: "inprogress"),
            AdminViewAllOrders(status: "completed"),
          ],
        ),
      ),
    );
  }
}
