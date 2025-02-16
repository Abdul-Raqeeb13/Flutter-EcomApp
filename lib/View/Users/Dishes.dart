// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ecomapp/Controller/User/DishesController.dart';
import 'package:ecomapp/Controller/User/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserViewSpecificDish extends StatefulWidget {

  var categoryData;

  UserViewSpecificDish({super.key, required this.categoryData});

  @override
  State<UserViewSpecificDish> createState() => _UserViewSpecificDishState();
}

class _UserViewSpecificDishState extends State<UserViewSpecificDish> {
    var DishesController = Get.put(UserDishes());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      getSpecificCategoryDishes();
    });
  }

  getSpecificCategoryDishes(){
    var categoryKey = widget.categoryData["CategoryKey"];
    DishesController.getDishesByCategoryId(categoryKey);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.categoryData["CategoryName"]),),
        body: Column(
          children: [
            // Text(dishName);
          ],
        ),
      ),
    );
  }
}