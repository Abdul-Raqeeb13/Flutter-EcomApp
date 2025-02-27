import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:ecomapp/helper/global.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class viewAllController extends GetxController {
  var isLoading = false;
  var orders = [];

  setLoading(val) {
    isLoading = val;
  }

  getOrders(status) async {
    orders.clear();
    update();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
    print(prefs.getString("userid"));
    if (uid.isEmpty) {
      uid = prefs.getString("userid") ?? "";
    }

    print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\");
    print(uid);

    CollectionReference userOrderInst =
        FirebaseFirestore.instance.collection("userOrder");
    userOrderInst
        .where("userUid", isEqualTo: uid)
        .where("status", isEqualTo: status)
        .get()
        .then((QuerySnapshot data) {
      final allOrders = data.docs.map((doc) => doc.data()).toList();
      orders = allOrders;
      // print(orders);
      // print( orders[0]["orders"][1]["DishName"],);
      update();
    });
  }
}
