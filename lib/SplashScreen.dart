import 'package:ecomapp/View/Admin/AdminDashboard.dart';
import 'package:ecomapp/View/Auth/Login.dart';
import 'package:ecomapp/View/Auth/Signup.dart';
import 'package:ecomapp/View/Users/UserHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      // Get.to(Login());
      checkUserLoginStatus();
    });
  }

  checkUserLoginStatus() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var userCheck = sharedprefs.getBool("Login") ?? false;

    var usertype = sharedprefs.getString("usertype");
    var userid = sharedprefs.getString("userid");

    if (userCheck) {
      var usertype = sharedprefs.getString("usertype");
      var userid = sharedprefs.getString("userid")!;
      if (usertype == "admin") {
        Get.offAll(AdminDashboard());
      } else {
        Get.offAll(UserDashboard());
      }
    } else {
      Get.offAll(Login());
    }

      // Get.offAll(Login());


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: _opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(50), // Adjust the radius as needed
                  child: Image.network(
                    "https://img.freepik.com/free-vector/online-shopping-concept-illustration_114360-1081.jpg",
                    height: 150,
                    fit: BoxFit
                        .cover, // Ensures the image covers the area properly
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "ShopEase",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your favorite shopping destination!",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
