// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminDishController extends GetxController {
  CollectionReference dishes = FirebaseFirestore.instance.collection('Dishes');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('Category');
  bool isLoading = false;
  var allDish = [];
  var selectedCategoryDishes = [];
  var dropdownvalue = "";
  var selectedDropDownKey = "";
  var profileImage;
  var filedata;
  var imagelink;
  var filepath = "";
  var imageName = "";
  final ImagePicker _picker = ImagePicker();
  var dishName = TextEditingController();
  var dishPrice = TextEditingController();

  setLoading(val) {
    isLoading = val;
    update();
  }

  getAllCategories() async {
    setLoading(true);
    // DishList.clear();

    await categories
        .where("Status", isEqualTo: true)
        .get()
        .then((QuerySnapshot data) {
      final allData = data.docs.map((doc) => doc.data()).toList();
      var newData = {"CategoryKey": "", "CategoryName": "All", "Status": true};

      allDish = allData;
      allDish.insert(0, newData);
      // dropdownvalue = List.from(allData);
      update();
      setLoading(false);
    });
  }

  setDropDownValue(val) {
    dropdownvalue = val["CategoryName"];
    selectedDropDownKey = val["CategoryKey"];
    update();
  }

  pickProfileImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    // sir file
    if (pickedFile != null) {
      // sir image       pickedfile -> sir file
      profileImage = File(pickedFile.path);
      filedata = pickedFile;
      filepath = pickedFile.path;
      imageName = filepath.toString().split("/").last;
      update();
    } else {
      snackBarMessagePopup(
          "Error", "Select the profile image", Colors.red, false);
    }
  }

  uploadImageAndDishDataToStorageAndDB() async {

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef = storage.ref().child('DishesImage/${imageName}');
      UploadTask upload = storageRef.putFile(profileImage);
      TaskSnapshot snapshot = await upload.whenComplete(() => ());
      String profileDownloadURL = await snapshot.ref.getDownloadURL();

      imagelink = profileDownloadURL;
      update();

      var dishkey = FirebaseDatabase.instance.ref("Dish").push().key;

      var DishData = {
        "CategoryKey": selectedDropDownKey,
        "DishKey": dishkey,
        "CategoryName": dropdownvalue,
        "DishName": dishName.text,
        "DishPrice": dishPrice.text,
        "DishImage": imagelink
      };

      await dishes.doc(dishkey).set(DishData);
      snackBarMessagePopup("Success", "New dish added", Colors.green, false);
      setLoading(false);

      getDishes(0);
    } catch (e) {
      snackBarMessagePopup("Error", e.toString(), Colors.red, true);
    }
  }

  addDish() {
    if (profileImage == null) {
      snackBarMessagePopup(
        "Error",
        "Select the dish image",
        Colors.red, // Fully visible red color
        true,
      );
    } else if (selectedDropDownKey == "") {
      snackBarMessagePopup(
        "Error",
        "Select the category",
        Colors.red, // Fully visible red color
        true,
      );
    } else if (dishName.text.isEmpty) {
      snackBarMessagePopup(
        "Error",
        "Enter the dish name",
        Colors.red, // Fully visible red color
        true,
      );
    } else if (dishPrice.text.isEmpty) {
      snackBarMessagePopup(
        "Error",
        "Enter the dish Price",
        Colors.red, // Fully visible red color
        true,
      );
    } else {
      setLoading(true);
      uploadImageAndDishDataToStorageAndDB();
    }
  }

  getDishes(index) async {
    if (allDish[index]["CategoryKey"] == "") {
      selectedCategoryDishes = [];
      await dishes.get().then((QuerySnapshot data) {
        final allDishes = data.docs.map((doc) => doc.data()).toList();
        selectedCategoryDishes = allDishes;
        update();
      });
    } else {
      await dishes
          .where("CategoryKey", isEqualTo: allDish[index]["CategoryKey"])
          .get()
          .then((QuerySnapshot data) {
        final allDishes = data.docs.map((doc) => doc.data()).toList();
        selectedCategoryDishes = allDishes;
        update();
      });
    }
  }

  deleteDish(index) async {

    await dishes.doc(selectedCategoryDishes[index]["DishKey"]).delete();
    selectedCategoryDishes.removeAt(index);
    update();
  }
}
