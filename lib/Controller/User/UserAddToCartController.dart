import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:ecomapp/helper/global.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userAddtoCartController extends GetxController {

  var isLoading = false;
  var userCard = [];

  userAddToCard(data) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance(); 
  data["quantity"] = 1;
    userCard.add(data);
    CardList.add(data);
    
  //   List<String> jsonStringList = userCard.map((card) => jsonEncode(card)).toList();
  // await prefs.setStringList('addToCard', jsonStringList); 
    update();
  }

  // getAllCard() async {
  //   // jsonStringList.map((jsonString) => Person.fromJson(jsonDecode(jsonString))).
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var DataList = prefs.getStringList("addToCard");
  //     DataList!.map((jsonString) =>jsonDecode(jsonString)).toList();
  //      print(DataList);

  // }

  getData(){
    userCard = userCard;
    update();
  }

  getAllCard(){

  }

  checkCard(data){
    // print(data)  ;
    var check = false;
    for (var i = 0; i < userCard.length; i++) {
      if (userCard[i]["DishKey"] == data["DishKey"]) {
        print("found smae sish");
        check = true;
        break;
      } 
    }

    return check;
  }


  void incrementQuantity(int index) {
  if (index >= 0 && index < userCard.length) {
    if (userCard[index]["quantity"] == null) {
      userCard[index]["quantity"] = 1;
    } else {
      userCard[index]["quantity"] += 1;
    update();
    }
    update();
  }
}

void decrementQuantity(int index) {
  if (index >= 0 && index < userCard.length) {
    if (userCard[index]["quantity"] != null && userCard[index]["quantity"] > 1) {
      userCard[index]["quantity"] -= 1;
    } else {
      userCard.removeAt(index);
    update();
    }
    update();
  }
}

  
}