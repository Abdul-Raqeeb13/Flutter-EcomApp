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
    CollectionReference dish =
        FirebaseFirestore.instance.collection('Dishes');

    await users.get().then((QuerySnapshot snapshot) {
      usersCount = snapshot.docs.length;
    });
    await category.get().then((QuerySnapshot snapshot) {
      Categories = snapshot.docs.length;

    });
    await dish.get().then((QuerySnapshot snapshot) {
      Dishes = snapshot.docs.length;
    });
    
    update();

    print(usersCount);
    print(Categories);
    print(Dishes);
  }
}
