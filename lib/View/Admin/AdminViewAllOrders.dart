import 'package:ecomapp/Controller/Admin/AdminOrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminViewAllOrders extends StatefulWidget {
  var status;
   AdminViewAllOrders({super.key, required this.status});
   

  @override
  State<AdminViewAllOrders> createState() => _AdminViewAllOrdersState();
}


class _AdminViewAllOrdersState extends State<AdminViewAllOrders> {

var controller = Get.put(AdminGetOrderController());

  @override
  void initState() {
    super.initState();
    getOrdersDetails();
  }

  void getOrdersDetails() {
    controller.getOrders(widget.status);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder:(context, index) {
        return Text(widget.status);
      },  );
  }
}