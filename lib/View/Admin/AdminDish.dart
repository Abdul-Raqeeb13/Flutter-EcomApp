// ignore_for_file: prefer_const_constructors, unused_label

import 'package:ecomapp/Controller/Admin/AdminDishController.dart';
import 'package:ecomapp/View/Admin/DrawerData.dart';
import 'package:ecomapp/Wdigets/Button.dart';
import 'package:ecomapp/Wdigets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              title: Text("Dish Page"),
            ),
            drawer: Drawer(child: DrawerData()),
            body: GetBuilder<AdminDishController>(builder: (controller) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage("https://img.freepik.com/free-vector/image-upload-concept-illustration_114360-996.jpg?ga=GA1.1.881659082.1730823737&semt=ais_authors_boost"),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 19),
                          width: screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(255, 33, 93, 142),
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: DropdownButton(
                            dropdownColor:
                                const Color.fromARGB(255, 205, 200, 199),

                            hint: controller.dropdownvalue == ""
                                ? Text("select Category")
                                : Text(controller.dropdownvalue.toString()),
                            padding: EdgeInsets.symmetric(horizontal: 10),

                            // arrow show on right side
                            isExpanded: true,
                            // Initial Value
                            // value: controller.dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: controller.allDish.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items["CategoryName"]),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (newValue) {
                              setState(() {
                                print(newValue);
                                newValue as Map;
                                controller.setDropDownValue(newValue);
                                // controller.dropdownvalue = newValue["CategoryName"];
                                // dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                        Center(
                          child: TextFieldWidget(
                              controller: searchController, obscureText: false),
                        ),
                        ElevatedButtonWidget(
                            buttonText: "Search",
                            buttonwidth: screenWidth,
                            onPress: () {}),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.red,
                          height: screenHeight * 0.1,
                          width: screenWidth,
                          child: Center(
                            // Ensures the Row stays centered within available width
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Allows Row to take only needed width
                                children: controller.allDish.map((dish) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(dish["CategoryName"]
                                          .toString()
                                          .toUpperCase()),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
            })));
  }
}
