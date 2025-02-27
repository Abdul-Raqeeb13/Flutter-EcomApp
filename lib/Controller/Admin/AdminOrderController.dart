import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/View/Admin/AdminViewAllOrders.dart';
import 'package:get/get.dart';

// form previous we use getBuilder to get the updated data on run time but now we use obx both are same but the diffenece is getbuilder complete updated the UI but obx just chnage the part of UI where he get the update data

class AdminGetOrderController extends GetxController {
  // obx rule for defininf varible
  CollectionReference allOrders =
      FirebaseFirestore.instance.collection('allOrder');
  CollectionReference userOrder =
      FirebaseFirestore.instance.collection('userOrder');
  RxBool isLoading = true.obs;
  RxList Orders = [].obs;
  setLoading(val) {
    isLoading.value = val;
  }

  getOrders(status) async {
    setLoading(true);
    await allOrders.get().then((QuerySnapshot snapshot) {
      var Orderdata = [];
      snapshot.docs.forEach((doc) {
        var newdata = doc.data() as Map;
        if (newdata["status"] == status) {
          Orderdata.add(doc.data());
        }
      });
      Orders.value = Orderdata;
      setLoading(false);
    });
  }


    UpdateOrder(key, type, reason,index) async {
    
    await allOrders.doc(key).update({"status": type, "reason": reason});
    await userOrder.doc(key).update({"status": type,"reason": reason});
    var newdata = Orders.value;
    newdata.removeAt(index);
    Orders.value=newdata;
    update();
    getOrders("pending");
    AdminViewAllOrders(status: type);

  }

 InProgressOrder(key, type, reason,index) async {
    await allOrders.doc(key).update({"status": type, "reason": reason});
    await userOrder.doc(key).update({"status": type,"reason": reason});
    var newdata = Orders.value;
    newdata.removeAt(index);
    Orders.value=newdata;
    update();
        AdminViewAllOrders(status: type);

  }

}
