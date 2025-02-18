import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class UserDishes extends GetxController {

  var isLoading = false;
  var specificCategorydishList = [];
  CollectionReference dishes =
      FirebaseFirestore.instance.collection('Dishes');
  // var UserList = [];

  // setLoading(val) {
  //   isLoading = val;
  //   update();
  // }

  getDishesByCategoryId(categoryKey) async {
    specificCategorydishList = [];
    update();
//  setLoading(true);
    await dishes.where("CategoryKey", isEqualTo: categoryKey).get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((doc) {
            specificCategorydishList.add(doc.data());
          })
        });
    // setLoading(false);
    update();
  }


}