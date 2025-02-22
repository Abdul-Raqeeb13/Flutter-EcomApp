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
    userCard = CardList;
    update();
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
  
}