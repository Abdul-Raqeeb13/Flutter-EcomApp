// ignore_for_file: prefer_const_constructors, unused_label, prefer_const_literals_to_create_immutables

import 'package:ecomapp/Controller/Admin/AdminDishController.dart';
import 'package:ecomapp/View/Admin/DrawerData.dart';
import 'package:ecomapp/Wdigets/Button.dart';
import 'package:ecomapp/Wdigets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminDish extends StatefulWidget {
  const AdminDish({super.key});

  @override
  State<AdminDish> createState() => _AdminDishState();
}

class _AdminDishState extends State<AdminDish> {
  var dishController = Get.put(AdminDishController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCategory();
    });
  }

  getCategory() async {
    await dishController.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dish Management", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        drawer: Drawer(child: DrawerData()),
        body: GetBuilder<AdminDishController>(builder: (controller) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.image, color: Colors.blueAccent),
                                    title: Text('Pick from Gallery'),
                                    onTap: () {
                                      controller.pickProfileImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.camera, color: Colors.blueAccent),
                                    title: Text('Take a Photo'),
                                    onTap: () {
                                      controller.pickProfileImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: controller.profileImage != null
                              ? FileImage(controller.profileImage) as ImageProvider
                              : NetworkImage(
                                  "https://img.freepik.com/free-vector/image-upload-concept-illustration_114360-996.jpg")
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          underline: SizedBox(),
                          hint: Text(controller.dropdownvalue.isEmpty ? "Select Category" : controller.dropdownvalue),
                          items: controller.allDish.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items["CategoryName"], style: TextStyle(fontSize: 16)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.setDropDownValue(newValue);
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(controller: controller.dishName, hintText: "Enter dish name", obscureText: false, width: screenWidth,),
                      TextFieldWidget(controller: controller.dishPrice, hintText: "Enter dish price", obscureText: false,width: screenWidth,),
                      controller.isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButtonWidget(
                              buttonText: "Add Dish",
                              buttonwidth: screenWidth,
                              onPress: () => controller.addDish()),
                      // SizedBox(height: 5),
                      SizedBox(height: 20),

                      Container(
                        width: screenWidth*0.8,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: controller.allDish.asMap().entries.map((entry) {
                              int index = entry.key;
                              var dish = entry.value;
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                  onPressed: () => controller.getDishes(index),
                                  child: Text(dish["CategoryName"].toString().toUpperCase(),
                                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      controller.selectedCategoryDishes.isEmpty
                          ? Center(child: Text("No dishes found in this category"))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.selectedCategoryDishes.length,
                              itemBuilder: (context, index) {
                                var dish = controller.selectedCategoryDishes[index];
                                return Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(10),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(dish["DishImage"], width: 60, height: 60, fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.image_not_supported, size: 60, color: Colors.grey);
                                      }),
                                    ),
                                    title: Text(dish["DishName"],
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    subtitle: Text("${dish["CategoryName"]} - ₹${dish["DishPrice"]}",
                                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    trailing: IconButton(
                                      onPressed: () => controller.deleteDish(index),
                                      icon: Icon(Icons.delete, color: Colors.white),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
