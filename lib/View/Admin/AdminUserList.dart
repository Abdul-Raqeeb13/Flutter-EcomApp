// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/Admin/AdminUserListController.dart';
import 'package:ecomapp/View/Admin/DrawerData.dart';
import 'package:ecomapp/Wdigets/Text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  var useradmincontroller = Get.put(AdminUserController());
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsersData();
  }

  getAllUsersData() {
    useradmincontroller.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("New"),
            ),
            drawer: Drawer(
              child: DrawerData(),
            ),
            body: GetBuilder<AdminUserController>(builder: (controller) {
              return Center(
                child: Column(
                  children: [
                    TextWidget(
                      text: "UserList",
                      color: Colors.red,
                      fontFamily: "font1",
                      fontbold: true,
                      fontsize: 30.0,
                    ),
                
                    controller.isLoading ? CircularProgressIndicator() : Container(),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.UserList.length ,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          child: ListTile(
                            title: Text(controller.UserList[index]["UserName"].toString()),
                          ),
                        );
                      },)
                  ],
                ),
              );
            })
            )
            );
  }
}
