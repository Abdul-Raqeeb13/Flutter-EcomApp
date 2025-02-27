// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:ecomapp/View/Admin/AdminDashboard.dart';
import 'package:ecomapp/View/Auth/Login.dart';
import 'package:ecomapp/View/Users/UserHome.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:ecomapp/helper/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {

  bool isLoading = false;
  setLoading(val) {
    isLoading = val;
    // its same as setstate but in getx we use update to
    update();
  }

  

  signUpUser(name, email, password) async {
    try {
      setLoading(true);
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: password);
      
      var uid = userCredential.user!.uid;
            
      var userdata = {
        "UserName" : name,
        "UserEmail" : email,
        "UserPassword" : password,
        "UserType" : "user",
        "UserId" : uid,
        "Block" : false
      };


           CollectionReference users =
          FirebaseFirestore.instance.collection('FlutterUsers');
      await users.doc(userCredential.user!.uid).set(userdata);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

      
      // prefs.setString("uid",uid);



      setLoading(false);
      snackBarMessagePopup("Success", "Account Created", Colors.green, false);

      Get.to(Login());
      // imageStoreStorage();
    } catch (e) {
      setLoading(false);
      snackBarMessagePopup("Error", e.toString(), Colors.red, false);
    }
  }

  

  loginUser(email, password) async {
    try {
      setLoading(true);
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email, password: password);

      FirebaseFirestore.instance
          .collection('FlutterUsers')
          .doc(userCredential.user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map;

          print('USER data: ${data["UserType"]}');

          if(data["block"]==true){
            snackBarMessagePopup("Block", "Contact For Admin",Colors.red,true);

          }
          else{
              // setPrefernce(data);
               setPreferences(data);
            Get.offAll(UserDashboard());
            uid = userCredential.user!.uid;

          }
        } else {
          FirebaseFirestore.instance
              .collection('FlutterAdmin')
              .doc(userCredential.user!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              var data = documentSnapshot.data() as Map;
               setPreferences(data);
              // Get.to give the back option & Get.ofAll replace the pagr not allow to back the page from where you come
              Get.offAll(AdminDashboard());
            } else {
              snackBarMessagePopup("Error", "Document does not exist on the database", Colors.red, true);
            }
          });
        }
      });

      // uid = userCredential.user!.uid;
      setLoading(false);
      snackBarMessagePopup("Success", "Login Success", Colors.green, false);

      // imageStoreStorage();
    } catch (e) {
      setLoading(false);
      snackBarMessagePopup("Error", e.toString(), const Color.fromARGB(255, 235, 133, 125), false);
    }
  }



  setPreferences(data) async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance(); 
    sharedprefs.setBool("Login", true);
    sharedprefs.setString("username", data["UserName"]);
    sharedprefs.setString("useremail", data["UserEmail"]);
    sharedprefs.setString("usertype", data["UserType"]);
    sharedprefs.setString("userid", data["UserId"]);
  }
}
