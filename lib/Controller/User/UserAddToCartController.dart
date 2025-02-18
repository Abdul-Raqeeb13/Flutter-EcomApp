import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class userAddtoCartController extends GetxController {

  var isLoading = false;
  var userAddtoCart = [];

  addToCartDishes(data){
    // print(data);
    userAddtoCart.add(data);
    print(userAddtoCart);
    update();
    // update();
  }

  checkDishCart(data){
    // print(data)  ;
    var check = false;
    for (var i = 0; i < userAddtoCart.length; i++) {
      if (userAddtoCart[i]["DishKey"] == data["DishKey"]) {
        print("found smae sish");
        check = true;
        break;
      } 
    }

    return check;
  }
  
}