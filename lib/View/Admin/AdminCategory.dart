// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/Controller/Admin/AdminCategoryController.dart';
import 'package:ecomapp/View/Admin/AdminDrawer.dart';
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
          title: Text("Category Page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        drawer: Drawer(child: DrawerData()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFieldWidget(
                  hintText: "Enter Your Category",
                  controller: inputCategoryController,
                  width: screenWidth * 0.9,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                ElevatedButtonWidget(
                  buttonText: "Add Category",
                  buttonwidth: screenWidth * 0.9,
                  onPress: () {
                    categoryController.addCategory(inputCategoryController.text);
                    inputCategoryController.text = "";
                  },
                ),
                SizedBox(height: 20),
                GetBuilder<AdminCategoryController>(builder: (controller) {
                  return controller.CategoryList.isNotEmpty
                      ? Column(
                          children: [
                            TextWidget(
                              color: Colors.blue,
                              text: "All Categories",
                              fontFamily: "font1",
                              fontbold: true,
                              fontsize: 24.0,
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)],
                              ),
                              child: Card(
                                elevation: 3,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columnSpacing: screenWidth * 0.07,
                                    headingRowColor: MaterialStateProperty.all(Colors.blue.shade100),
                                    // border: TableBorder.all(color: Colors.blue.shade300, width: 1),
                                    columns: [
                                      DataColumn(label: Text('S.No', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('C_Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Action', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
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
                                                    controller.updateCategoryStatus(index, true, "");
                                                  },
                                                  child: Icon(
                                                    controller.CategoryList[index]["Status"] ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                                                    color: Colors.green,
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
                                                IconButton(
                                                  icon: Icon(Icons.delete, color: Colors.red),
                                                  onPressed: () {
                                                    controller.deleteCategory(index);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.edit, color: Colors.blue),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedIndex = index;
                                                      EditCategoryController.text = controller.CategoryList[index]["CategoryName"].toString();
                                                    });
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) => AlertDialog(
                                                        title: Text("Edit Category"),
                                                        content: TextFieldWidget(controller: EditCategoryController, obscureText: false),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () => Navigator.pop(context),
                                                            child: Text("Cancel"),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              controller.updateCategoryStatus(index, false, EditCategoryController.text);
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text("Update"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(child: Text("No categories available"));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
