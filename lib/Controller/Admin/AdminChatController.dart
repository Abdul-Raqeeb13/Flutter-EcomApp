import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/helper/global.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminChatController extends GetxController {
  
  
  TextEditingController message = TextEditingController();
  RxList UserCharList = [].obs;


  getChatList() async {
  // Clear list before adding new data
  UserCharList.clear();

  var data = await FirebaseFirestore.instance
      .collection('converstaions')
      .where("ReceiverID", isEqualTo: "aActlqLEsjNnRQ6hi24zVQC2Yyx2")
      .get();

  // Print the first document (for debugging)
  if (data.docs.isNotEmpty) {
    print(data.docs[0].data()); // ✅ Correct way to print Firestore document
  }

  // Extract data and store it in UserCharList
  for (var doc in data.docs) {
    UserCharList.add(doc.data()); // ✅ Correct way to add documents
  }

  print(UserCharList); // Debugging to see the list of users
}

 cretaeConverstaion(senderIdUser) async {
    var data =
        await FirebaseFirestore.instance.collection("converstaions").get();
    var p = data.docs;
    var con_id = "";
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var senderName = sharedprefs.getString("username");
    var senderEmail = sharedprefs.getString("useremail");
    var senderId = sharedprefs.getString("userid");

    for (var i = 0; i < p.length; i++) {
      if (p[i]["SenderId"] == senderIdUser && p[i]["ReceiverID"] == senderId) {
        con_id = p[i]["ConversationId"];
      }
    }

  currentConverstaion_id = con_id;
  }

    


}

   // for user side 
  // SendMessage(receiver_id) async {
  //   var message_id = FirebaseFirestore.instance.collection("message").doc().id;
  //   final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
  //   var senderId = sharedprefs.getString("userid");
  //   var obj = {
  //     "message": message.text.toString(),
  //     "message_Id": message_id,
  //     "SenderId": senderId,
  //     "receiverId": receiver_id,
  //     "converstaion_Id": currentConverstaion_id,
  //     "status": true,
  //     "created_at": FieldValue.serverTimestamp()
  //   };

  //   await FirebaseFirestore.instance
  //       .collection("message")
  //       .doc(message_id)
  //       .set(obj);

  //   message.clear();
  // }

  // // for user side 
  // cretaeConverstaion(receiverId) async {
  //   var data =
  //       await FirebaseFirestore.instance.collection("converstaions").get();
  //   var p = data.docs;
  //   var con_id = "";
  //   final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
  //   var senderName = sharedprefs.getString("username");
  //   var senderEmail = sharedprefs.getString("useremail");
  //   var senderId = sharedprefs.getString("userid");

  //   for (var i = 0; i < p.length; i++) {
  //     if (p[i]["SenderId"] == senderId && p[i]["ReceiverID"] == receiverId) {
  //       con_id = p[i]["ConversationId"];
  //     }
  //   }

  //   if (con_id == "") {
  //     var id = FirebaseFirestore.instance.collection("converstaions").doc().id;

  //     var obj = {
  //       "ReceiverID": receiverId,
  //       "ReceiverName": "Admin",
  //       "SenderName": senderName,
  //       "SenderEmail": senderEmail,
  //       "SenderId": senderId,
  //       "ConversationId": id,
  //       "LastMessage": "",
  //     };

  //     currentConverstaion_id = id;

  //     await FirebaseFirestore.instance
  //         .collection("converstaions")
  //         .doc(id)
  //         .set(obj);
  //   } else {
  //     currentConverstaion_id = con_id;
  //   }

  //   print(currentConverstaion_id);
  // }

    


 