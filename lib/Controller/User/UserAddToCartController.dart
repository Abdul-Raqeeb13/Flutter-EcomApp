import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class UserDishes extends GetxController {

  var isLoading = false;
  var specificCategorydishList = [];

  addToCartDishes(dishData){
    print(dishData);
  }
}