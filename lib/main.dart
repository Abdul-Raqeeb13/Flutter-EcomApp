// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/SplashScreen.dart';
import 'package:ecomapp/View/Auth/Login.dart';
import 'package:ecomapp/View/Auth/Signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   Stripe.publishableKey = "pk_test_51QwozwRrjvbEsEGTxaGnMy2vysDU0wRSSuZYfE6jVr6WGxYf60Kq8FXkCyoLHzjk6WxnvWnEjkgGnbbpVbww4o7i00a2dJbczY";
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Signup(),
      home: SplashScreen(),
    );
  }
}
