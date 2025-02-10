// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminDishController extends GetxController {
  
  
  CollectionReference dishes =
  FirebaseFirestore.instance.collection('Dishes');
  CollectionReference categories =
  FirebaseFirestore.instance.collection('Category');
  var isLoading = false;
  var DishList = [];
  
  setLoading(val) {
    isLoading = val;
    update();
  }
  

  getAllCategories() async {
    print("=============================================== get categories call");
    // DishList.clear();
    
        await categories.get().then((QuerySnapshot data)  {
          final allData = data.docs.map((doc) => doc.data()).toList();
          for (var i = 0; i < allData.length; i++) {
            // if (allData[i]["Status"] as Map == true) {
              
            // }
          }
        });
        // update();
  }
}
