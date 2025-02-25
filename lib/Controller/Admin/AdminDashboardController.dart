import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  var isLoading = false;

  var usersCount = 0;
  var Categories = 0;
  var Dishes = 0;
  var pendingOrder = 0;
  var completeOrder = 0;
  var cancelOrder = 0;
  var acceptedOrder = 0;

  setLoading(val) {
    isLoading = val;
    update();
  }

  getDashboardData() async {
    // setLoading(true);
    CollectionReference users =
        FirebaseFirestore.instance.collection('FlutterUsers');
    CollectionReference category =
        FirebaseFirestore.instance.collection('Category');
    CollectionReference dish = FirebaseFirestore.instance.collection('Dishes');
    CollectionReference allOrders =
        FirebaseFirestore.instance.collection('allOrder');

    await users.get().then((QuerySnapshot snapshot) {
      usersCount = snapshot.docs.length;
    });
    await category.get().then((QuerySnapshot snapshot) {
      Categories = snapshot.docs.length;
    });
    await dish.get().then((QuerySnapshot snapshot) {
      Dishes = snapshot.docs.length;
    });

    //  UserOrders(status: "pending"),
    // UserOrders(status: "accepted"),
    // UserOrders(status: "inprogress"),
    // UserOrders(status: "completed"),
    pendingOrder = 0;
    completeOrder = 0;
    cancelOrder = 0;
    acceptedOrder = 0;

    await allOrders.get().then((QuerySnapshot snapshot) {
      for (var i = 0; i < snapshot.docs.length; i++) {
        if (snapshot.docs[i]["status"] == "pending") {
          pendingOrder += 1;
        } else if (snapshot.docs[i]["status"] == "accepted") {
          acceptedOrder += 1;
        } else if (snapshot.docs[i]["status"] == "cancel") {
          cancelOrder += 1;
        } else if (snapshot.docs[i]["status"] == "completed") {
          completeOrder += 1;
        }
      }
    });

    update();

    print(usersCount);
    print(Categories);
    print(Dishes);
  }
}
