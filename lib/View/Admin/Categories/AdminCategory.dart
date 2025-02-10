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
        appBar: AppBar(),
        drawer: Drawer(child: DrawerData()),
        body: GetBuilder<AdminCategoryController>(builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFieldWidget(
                  hintText: "Enter Your Category",
                  controller: inputCategoryController,
                  width: screenWidth ,
                  obscureText: false,
                ),
                ElevatedButtonWidget(
                  buttonText: "Add Category",
                  buttonwidth: screenWidth,
                  onPress: () {
                    categoryController.addCategory(inputCategoryController.text);
                  },
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
                          DataTable(
                            columnSpacing: screenWidth * 0.07,
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
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.updateCategoryStatus(index);
                                          },
                                          child: Icon(
                                            controller.CategoryList[index]["Status"] ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(controller.CategoryList[index]["Status"].toString()),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.deleteCategory(index);
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: TextFieldWidget(controller: EditCategoryController, obscureText: false,),
                                                actions: [
                                                  ElevatedButtonWidget(
                                                    buttonText: "Edit",
                                                    buttonwidth: screenWidth,
                                                    onPress: (){
            
                                                    })
                                                ],
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
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
