// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminUserController extends GetxController {
  var isLoading = false;
  var UserList = [];

  // setLoading(val) {
  //   isLoading = val;
  //   update();
  // }

  getAllUsers() async {
    // setLoading(true);
    UserList.clear();
    CollectionReference users =
        FirebaseFirestore.instance.collection('FlutterUsers');
        await users.get().then((QuerySnapshot snapshot) => {
           snapshot.docs.forEach((doc) {
              UserList.add(doc.data());
            })
        });
        // setLoading(false);
        update();
  }
}
