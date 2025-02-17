import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  var isLoading = false;
  var CategoryList = [];
  CollectionReference categories =
      FirebaseFirestore.instance.collection('Category');
  // var UserList = [];

  // setLoading(val) {
  //   isLoading = val;
  //   update();
  // }

  getCategoryList() async {
//  setLoading(true);
    await categories.where("Status", isEqualTo: true).get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((doc) {
            CategoryList.add(doc.data());
          })
        });
    // setLoading(false);
    // print(CategoryList);
    update();
  }



}