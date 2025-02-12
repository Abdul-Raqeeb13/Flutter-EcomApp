// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminDishController extends GetxController {
  
  
  CollectionReference dishes =
  FirebaseFirestore.instance.collection('Dishes');
  CollectionReference categories =
  FirebaseFirestore.instance.collection('Category');
  bool isLoading = false;
  var allDish = [];
  var dropdownvalue = "" ;
  var selectedDropDownKey = "";

  
  setLoading(val) {
    isLoading = val;
    update(); 
  }
  

 getAllCategories() async {
    setLoading(true);
    print("=============================================== get categories call");
    // DishList.clear();
    
        await categories.where("Status" , isEqualTo: true).get().then((QuerySnapshot data)  {
          final allData = data.docs.map((doc) => doc.data()).toList();
          // print(allData); 
          allDish = List.from(allData);
          // dropdownvalue = List.from(allData);
          update();
        setLoading(false);
        });

  }


  setDropDownValue(val){
    dropdownvalue = val["CategoryName"];
    selectedDropDownKey = val["CategoryKey"];
    print(dropdownvalue);
    print(selectedDropDownKey);
    update();
  }
}
