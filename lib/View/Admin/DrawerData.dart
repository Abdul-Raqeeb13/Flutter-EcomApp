// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/View/Admin/AdminDish.dart';
import 'package:ecomapp/View/Admin/AdminDashboard.dart';
import 'package:ecomapp/View/Admin/AdminUserList.dart';
import 'package:ecomapp/View/Admin/AdminCategory.dart';
import 'package:ecomapp/View/Auth/Login.dart';
import 'package:flutter/material.dart';
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
    super.initState();
    setLoginUserData();
  }

  setLoginUserData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    username = sharedprefs.getString("username") ?? "User";
    useremail = sharedprefs.getString("useremail") ?? "example@mail.com";

    setState(() {});
  }

  logout() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    sharedprefs.clear();
    Get.offAll(Login());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header with a Dark Nature Theme
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0"),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text(
              username,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
            ),
            accountEmail: Text(
              useremail,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontFamily: 'Nunito',
              ),
            ),
            // currentAccountPicture: CircleAvatar(
            //   backgroundColor: Colors.white,
            //   child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
            // ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                buildDrawerItem(Icons.dashboard_rounded, "Dashboard", () {
                  Get.to(AdminDashboard());
                }, Colors.blueAccent),
                buildDrawerItem(Icons.group_rounded, "Users", () {
                  Get.to(UserList());
                }, Colors.green),
                buildDrawerItem(Icons.category_rounded, "Add Category", () {
                  Get.to(AddCategory());
                }, Colors.orange),
                buildDrawerItem(Icons.restaurant_menu_rounded, "Dish", () {
                  Get.to(AdminDish());
                }, Colors.redAccent),
                buildDrawerItem(Icons.settings_rounded, "Settings", () {}, Colors.grey),
                buildDrawerItem(Icons.exit_to_app_rounded, "Log Out", logout, Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap, Color color) {
    return ListTile(
      leading: Icon(icon, color: color, size: 28),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
          color: Colors.black87,
        ),
      ),
      tileColor: Colors.grey[200], // Light background for each tile
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      onTap: onTap,
    );
  }
}
