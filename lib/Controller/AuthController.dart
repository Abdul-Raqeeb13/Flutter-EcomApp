// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:ecomapp/View/Auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {

  bool isLoading = false;
  setLoading(val) {
    isLoading = val;
    // its same as setstate but in getx we use update to
    update();
  }

  void snackBarMessagePopup(status, messgae, color, showbtn) {
    Get.snackbar(
      status, // Title of the snackbar
      messgae, // Message
      snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
      backgroundColor: color, // Background color
      colorText: Colors.white, // Text color
      borderRadius: 10, // Border radius for rounded corners
      margin: EdgeInsets.all(15), // Margin around the snackbar
      padding: EdgeInsets.symmetric(
          vertical: 15, horizontal: 20), // Padding inside the snackbar
      duration: Duration(
          seconds: 3), // Duration for which the snackbar will be visible
      icon: showbtn
          ? Icon(
              Icons.error, // Icon to display in the snackbar
              color: Colors.white,
            )
          : null,

      mainButton: showbtn
          ? TextButton(
              onPressed: () {
                // Handle the button click here
                Get.back();
              },
              child: Text(
                "Retry",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
      isDismissible: true, // Allow dismissing the snackbar
      showProgressIndicator:
          true, // Show a progress indicator while the snackbar is visible
      progressIndicatorBackgroundColor:
          Colors.white, // Progress indicator background color
      forwardAnimationCurve:
          Curves.easeOut, // Animation curve for the snackbar appearance
      reverseAnimationCurve:
          Curves.easeIn, // Animation curve for the snackbar dismissal
    );
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
        "UserId" : uid
      };

  print(userdata);
           CollectionReference users =
          FirebaseFirestore.instance.collection('FlutterUsers');
      await users.doc(userCredential.user!.uid).set(userdata);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

      
      // prefs.setString("uid",uid);
      print(uid);


      setLoading(false);
      snackBarMessagePopup("Success", "Account Created", Colors.green, false);

      Get.to(Login());
      // imageStoreStorage();
    } catch (e) {
      print(e.toString());
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
            // Get.offAll(UserDashboard());
          }
        } else {
          FirebaseFirestore.instance
              .collection('FlutterAdmin')
              .doc(userCredential.user!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              var data = documentSnapshot.data() as Map;
              print('admin data: ${data["UserType"]}');
              // setPrefernce(data);
              // Get.offAll(AdminDashboard());
            } else {
              print('Document does not exist on the database');
            }
          });
        }
      });

      setLoading(false);
      snackBarMessagePopup("Success", "Login Success", Colors.green, false);

      // imageStoreStorage();
    } catch (e) {
      print(e.toString());
      setLoading(false);
      snackBarMessagePopup("Error", e.toString(), Colors.red, false);
    }
  }

}
