// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/Controller/Admin/AdminCategoryController.dart';
import 'package:ecomapp/View/Admin/DrawerData.dart';
import 'package:ecomapp/Wdigets/Button.dart';
import 'package:ecomapp/Wdigets/Text.dart';
import 'package:ecomapp/Wdigets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController inputCategoryController = TextEditingController();
  TextEditingController EditCategoryController = TextEditingController();
  var categoryController = Get.put(AdminCategoryController());
  var selectedIndex;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  void getAllCategories() {
    categoryController.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Category Page"),
        ),
        drawer: Drawer(child: DrawerData()),
        body: GetBuilder<AdminCategoryController>(builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hintText: "Enter Your Category",
                        controller: inputCategoryController,
                        width: screenWidth,
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      ElevatedButtonWidget(
                        buttonText: "Add Category",
                        buttonwidth: screenWidth,
                        onPress: () {
                          categoryController.addCategory(inputCategoryController.text);
                        },
                      ),
                    ],
                  ),
                ),
                controller.CategoryList.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(height: 15),
                          Center(
                            child: TextWidget(
                              color: Colors.blue,
                              text: "All Categories",
                              fontFamily: "font1",
                              fontbold: false,
                              fontsize: 30.0,
                            ),
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 20,
                              columns: [
                                DataColumn(label: Text('S.NO', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('C_NAME', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('STATUS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Action', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                              ],
                              rows: List.generate(controller.CategoryList.length, (index) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(controller.CategoryList[index]["CategoryName"])),
                                    DataCell(
                                      GestureDetector(
                                        onTap: () {
                                          controller.updateCategoryStatus(index, !controller.CategoryList[index]["Status"], "");
                                        },
                                        child: Icon(
                                          controller.CategoryList[index]["Status"] ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                                          color: controller.CategoryList[index]["Status"] ? Colors.green : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.deleteCategory(index);
                                            },
                                            child: Icon(Icons.delete, color: Colors.red),
                                          ),
                                          SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedIndex = index;
                                                EditCategoryController.text = controller.CategoryList[index]["CategoryName"].toString();
                                              });
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: Text("Edit Category"),
                                                  content: TextFieldWidget(
                                                    controller: EditCategoryController,
                                                    obscureText: false,
                                                  ),
                                                  actions: [
                                                    ElevatedButtonWidget(
                                                      buttonText: "Cancel",
                                                      buttonwidth: screenWidth * 0.3,
                                                      onPress: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    ElevatedButtonWidget(
                                                      buttonText: "Update",
                                                      buttonwidth: screenWidth * 0.3,
                                                      onPress: () {
                                                        controller.updateCategoryStatus(index, controller.CategoryList[index]["Status"], EditCategoryController.text);
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.edit, color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
