// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/View/Admin/AdminDish.dart';
import 'package:ecomapp/View/Admin/AdminDashboard.dart';
import 'package:ecomapp/View/Admin/AdminUserList.dart';
import 'package:ecomapp/View/Admin/AdminCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerData extends StatefulWidget {
  const DrawerData({super.key});

  @override
  State<DrawerData> createState() => _DrawerDataState();
}

class _DrawerDataState extends State<DrawerData> {
  var username = "";
  var useremail = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLoginUserData();
  }

  setLoginUserData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    username = sharedprefs.getString("username")!;
    useremail = sharedprefs.getString("useremail")!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
            child: Container(
          width: 300.0,
          height: 500.0,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                "https://media.istockphoto.com/vectors/dark-abstract-background-vector-illustration-vector-id929619614?b=1&k=6&m=929619614&s=612x612&w=0&h=bzXWUYZ7R9wMSTmWANhfhh2ct3RAnOBVKMhqLDE1KiY="),
            // fit: BoxFit.cover
          )),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon((Icons.supervised_user_circle_rounded)),
                color: Colors.white,
                iconSize: 60,
                onPressed: () {},
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    useremail.toString(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          )),
        )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: (Row(
                children: <Widget>[
                  // ...
                  Expanded(
                    child: Column(
                      children: <Widget>[Divider(color: Colors.black)],
                    ),
                  )
                ],
              )),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AdminDashboard());
              },
              child: ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.home)),
                    color: Color.fromARGB(255, 85, 92, 219),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Home")),
            ),


            GestureDetector(
              onTap: () {
                Get.to(UserList());
              },
              child: ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.person)),
                    color: Color.fromARGB(255, 85, 92, 219),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Users")),
            ),


            GestureDetector(
              onTap: () {
                Get.to(AddCategory());
              },
              child: ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.category)),
                    color: Color.fromARGB(255, 85, 92, 219),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Add Category")),
            ),


            GestureDetector(
              onTap: () {
                Get.to(AdminDish());
              },
              child: ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.food_bank)),
                    color: Color.fromARGB(255, 85, 92, 219),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Dish")),
            ),


            ListTile(
                leading: IconButton(
                  icon: Icon((Icons.settings_sharp)),
                  color: Colors.red,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("Setting")),
            ListTile(
                leading: IconButton(
                  icon: Icon((Icons.login_outlined)),
                  color: Colors.red,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("Log Out")),
          ],
        ),
        // GestureDetector(onTap: (){},child:ListTile(title:Text("hello"))),  //GestureDetector used for Drawer move one page to other
      ],
    );
  }
}
