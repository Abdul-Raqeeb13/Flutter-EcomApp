import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

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