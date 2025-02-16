// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Controller/User/HomeController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomapp/View/Users/Dishes.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:text_marquee/text_marquee.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  var userHomeController = Get.put(UserHomeController());

  final List<String> imgList = [
    'https://img.freepik.com/free-photo/flat-lay-mexican-food_23-2148140353.jpg?ga=GA1.1.881659082.1730823737',
    'https://img.freepik.com/premium-photo/front-view-burger-with-french-fries_23-2148234993.jpg?ga=GA1.1.881659082.1730823737',
    'https://img.freepik.com/premium-photo/close-up-bugers-cutting-board_23-2148234996.jpg?ga=GA1.1.881659082.1730823737',
    'https://img.freepik.com/free-photo/top-view-table-full-delicious-food-composition_23-2149141354.jpg?ga=GA1.1.881659082.1730823737',
    'https://img.freepik.com/free-photo/top-view-table-full-food_23-2149209225.jpg?ga=GA1.1.881659082.1730823737',
    'https://img.freepik.com/premium-psd/realistic-burger-menu-with-veggies-ketchup_23-2148421444.jpg?ga=GA1.1.881659082.1730823737'
  ];

  late List<Widget> imageSliders;
  @override
  void initState() {
    super.initState();
    imageSliders = imgList
        .map(
          (item) => Container(
            child: Center(
                child: Image.network(item, fit: BoxFit.cover, width: 1000)),
          ),
        )
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllCategories();
    });
  }

  void getAllCategories() {
    userHomeController.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("User Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: userHomeController.CategoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.92, // Adjusts height-to-width ratio
                ),
                itemBuilder: (context, index) {
                  var category = userHomeController.CategoryList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(UserViewSpecificDish(
                          categoryData:
                              userHomeController.CategoryList[index]));
                      print("Clicked on ${category["CategoryName"]}");
                    },
                    child: Card(
                      elevation: 18,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded edges
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [Colors.blueAccent, Colors.purpleAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons
                                  .category, // Change to a dynamic icon if needed
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              category["CategoryName"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
