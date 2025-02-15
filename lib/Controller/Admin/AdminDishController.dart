// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
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
    print(
        "=============================================== get categories call");
    // DishList.clear();

    await categories
        .where("Status", isEqualTo: true)
        .get()
        .then((QuerySnapshot data) {
      final allData = data.docs.map((doc) => doc.data()).toList();
      // print(allData);
      allDish = List.from(allData);
      // dropdownvalue = List.from(allData);
      update();
      setLoading(false);
    });
  }

  setDropDownValue(val) {
    dropdownvalue = val["CategoryName"];
    selectedDropDownKey = val["CategoryKey"];
    print(dropdownvalue);
    print(selectedDropDownKey);
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
      // print(filepath.toString().split("/").last);
      // print(filepath);
      // print(filedata);
      imageName = filepath.toString().split("/").last;
      update(); 
      // uploadImageToStorage();
    } else {
      print("errro upload the profile image");
      // snackBarMessagePopup("Error", "Select the profile image", false);
      // print(e); 
    }
  }

  uploadImageToStorage() async {
    print("wokring");

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef =
          storage.ref().child('DishesImage/${imageName}');
      UploadTask upload =  storageRef.putFile(profileImage);
      TaskSnapshot snapshot = await upload.whenComplete(() => ());
      String profileDownloadURL = await snapshot.ref.getDownloadURL();

      imagelink = profileDownloadURL;
      update();
      print(profileDownloadURL);
      // storedb();

      var DishData = {
        "CategoryKey" : selectedDropDownKey,
        "CategoryName" : dropdownvalue,
        "DishName" : dishName.text,
        // "DishPrice" : 
      };
    } catch (e) {
      print(e);
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
        "Select the dish name",
        Colors.red, // Fully visible red color
        true,
      );
    } else {}
  }
}
