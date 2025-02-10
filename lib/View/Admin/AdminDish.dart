import 'package:ecomapp/Controller/Admin/AdminDishController.dart';
import 'package:ecomapp/View/Admin/DrawerData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDish extends StatefulWidget {
  const AdminDish({super.key});

  @override
  State<AdminDish> createState() => _AdminDishState();
}

class _AdminDishState extends State<AdminDish> {

    var dishController = Get.put(AdminDishController());

    @override
 @override
 void initState() {
   super.initState();
   getCategory();
 }

 
  getCategory() async {

    await dishController.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dish Page"),
        ),
        drawer: Drawer(child: DrawerData()),
        
        )
        );
  }
}