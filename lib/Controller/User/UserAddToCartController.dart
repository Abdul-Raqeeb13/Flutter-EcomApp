// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Wdigets/PopUpMessage.dart';
import 'package:ecomapp/helper/global.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserAddtoCartController extends GetxController {
  var isLoading = false;
  var userCard = [];

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount.toString(), 'RS');
      paymentIntent = await createPaymentIntent(amount.toString(), 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                //Gotten from payment intent

                  style: ThemeMode.dark,
                  merchantDisplayName: 'My'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(amount);
    } catch (err) {
      print('==========================> errorrr: $err');
      throw Exception(err);
    }
  }

  displayPaymentSheet(amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        print(paymentIntent!["id"].toString());
        OrderNow(amount);


        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:---> $error');

        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    final uri = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final headers = {
      'Authorization': 'Bearer $secretKey',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
    }; 

    try {
      final response = await http.post(uri, headers: headers, body: body);

      return json.decode( response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  TextEditingController address = TextEditingController();
  TextEditingController contactno = TextEditingController();
  // var isDismissible;

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

  getData() {
    userCard = userCard;
    // return userCard;
    update();
  }

  getAllCard() {}

  checkCard(data) {
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
      if (userCard[index]["quantity"] != null &&
          userCard[index]["quantity"] > 1) {
        userCard[index]["quantity"] -= 1;
      } else {
        userCard.removeAt(index);
        update();
      }
      update();
    }
  }

  showBottomSheetFunc(context, totalprice) {
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (context) {
          return Container(
              margin: EdgeInsets.all(10),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text("Order Details"),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(hintText: "Enter Address"),
                  ),
                  TextField(
                    controller: contactno,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: "Enter Contact Number"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        // showAlertDialog(context);

                        checkAndValidate(context, totalprice);
                      },
                      child: Text("Order Place"))
                ],
              ));
        });
  }

  showAlertDialog(BuildContext context, totalprice) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        // Get.back();
        makePayment(totalprice);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Your Order"),
      content: Text("Order Place Confirmation Price ${totalprice}"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  checkAndValidate(context, totalprice) {
    if (address.text.isEmpty) {
      Get.snackbar("Error", "Please EnteR yOUR aDDRESS");
    } else if (contactno.text.isEmpty) {
      Get.snackbar("Error", "Please EnteR yOUR contact number");
    } else {
      Navigator.pop(context);
      showAlertDialog(context, totalprice);
    }
  }

  OrderNow(totalprice) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("useremail");

    var key = FirebaseDatabase.instance.ref('Orders').push().key; //order
    var obj = {
      "userUid": uid,
      "email": email,
      "orders": userCard,
      "totalPrice": totalprice,
      "address": address.text,
      "contact": contactno.text,
      "orderkey": key,
      "status": "pending",
      "reason": ""
    };

    print(obj);
    CollectionReference userOrderInst =
        FirebaseFirestore.instance.collection("userOrder");

    CollectionReference adminOrderInst =
        FirebaseFirestore.instance.collection("allOrder");

    await userOrderInst.doc(key).set(obj);
    await adminOrderInst.doc(key).set(obj);
    userCard.clear();
    update();
    Get.back();
    Get.snackbar("Success", "Add New Order");
  }
}
