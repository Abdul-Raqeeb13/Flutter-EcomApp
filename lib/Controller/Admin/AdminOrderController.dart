import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// form previous we use getBuilder to get the updated data on run time but now we use obx both are same but the diffenece is getbuilder complete updated the UI but obx just chnage the part of UI where he get the update data

class AdminGetOrderController extends GetxController {
  // obx rule for defininf varible
  CollectionReference allOrders =
      FirebaseFirestore.instance.collection('allOrder');
  RxBool isLoading = true.obs;
  RxList Orders = [].obs;
  setLoading(val) {
    isLoading.value = val;
  }


  ///////////// 1:00:16
  getOrders(status) async {
  //   await allOrders.get().then((QuerySnapshot snapshot) {
  //     var Orderdata = [];
  //     snapshot.docs.forEach((doc) {
  //       Orderdata.add(doc.data);
  //     });
  //     Orders.value = Orderdata;
  //     print("-----------------------------");
  //     print(Orders.value);
  //   });
  }
}
