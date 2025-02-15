import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AdminCategoryController extends GetxController {
  TextEditingController categoryController = TextEditingController();

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
    CategoryList.clear();
//  setLoading(true);
    await categories.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((doc) {
            CategoryList.add(doc.data());
          })
        });
    // setLoading(false);
    update();
  }

  addCategory(String name) async {
    if (name.toString().trim().isEmpty) {
      snackBarMessagePopup(
          "Error", "Category Cannot be empty", Colors.red, false);
    } else {
      var key = FirebaseDatabase.instance.ref("category").push().key;
      var categoryData = {
        "CategoryName": name,
        "Status": true,
        "CategoryKey": key
      };

      await categories.doc(key).set(categoryData);
      snackBarMessagePopup("Success", "Category Added", Colors.green, false);

      getCategoryList();
    }
  }

  deleteCategory(index) async {
    await categories.doc(CategoryList[index]["CategoryKey"]).delete();
    CategoryList.removeAt(index);
    update();
  }

  updateCategoryStatus(index, status, categoryEditName) async {
    if (status == true) {
      await categories
          .doc(CategoryList[index]["CategoryKey"])
          .update({"Status": !CategoryList[index]["Status"]});
      CategoryList[index]["Status"] = !CategoryList[index]["Status"];
      update();
    } else {
      await categories
          .doc(CategoryList[index]["CategoryKey"])
          .update({"CategoryName": categoryEditName});
      update();
      getCategoryList();
    }
  }
}
