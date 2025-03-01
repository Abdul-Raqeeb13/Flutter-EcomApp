import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/helper/global.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  
  
  TextEditingController message = TextEditingController();


  // for user side 
  SendMessage(receiver_id) async {
    var message_id = FirebaseFirestore.instance.collection("message").doc().id;
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var senderId = sharedprefs.getString("userid");
    var obj = {
      "message": message.text.toString(),
      "message_Id": message_id,
      "SenderId": senderId,
      "receiverId": receiver_id,
      "converstaion_Id": currentConverstaion_id,
      "status": true,
      "created_at": FieldValue.serverTimestamp()
    };

    await FirebaseFirestore.instance
        .collection("message")
        .doc(message_id)
        .set(obj);

    message.clear();
  }

  // for user side 
  cretaeConverstaion(receiverId) async {
    var data =
        await FirebaseFirestore.instance.collection("converstaions").get();
    var p = data.docs;
    var con_id = "";
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var senderName = sharedprefs.getString("username");
    var senderEmail = sharedprefs.getString("useremail");
    var senderId = sharedprefs.getString("userid");

    for (var i = 0; i < p.length; i++) {
      if (p[i]["SenderId"] == senderId && p[i]["ReceiverID"] == receiverId) {
        con_id = p[i]["ConversationId"];
      }
    }

    if (con_id == "") {
      var id = FirebaseFirestore.instance.collection("converstaions").doc().id;

      var obj = {
        "ReceiverID": receiverId,
        "ReceiverName": "Admin",
        "SenderName": senderName,
        "SenderEmail": senderEmail,
        "SenderId": senderId,
        "ConversationId": id,
        "LastMessage": "",
      };

      currentConverstaion_id = id;

      await FirebaseFirestore.instance
          .collection("converstaions")
          .doc(id)
          .set(obj);
    } else {
      currentConverstaion_id = con_id;
    }

    print(currentConverstaion_id);
  }

    


}
