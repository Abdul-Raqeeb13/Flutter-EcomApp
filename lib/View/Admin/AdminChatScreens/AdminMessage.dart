// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/Controller/User/UserChatController.dart';
import 'package:ecomapp/helper/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMessageScreen extends StatefulWidget {
  
  var RecieverId;
  var SenderId;

  AdminMessageScreen({super.key, this.RecieverId, this.SenderId});

  @override
  State<AdminMessageScreen> createState() => _AdminMessageScreenState();
}

class _AdminMessageScreenState extends State<AdminMessageScreen> {
  var messageController = Get.put(ChatController());

var stream = FirebaseFirestore.instance
   .collection("message")
.where("converstaion_Id", isEqualTo: currentConverstaion_id.toString())
   .where("status", isEqualTo: true)
   .orderBy("created_at", descending: true) // Fix this field name
   .snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        // automaticallyImplyLeading: false,
        title: const Text("Chats"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 22,
        ),
        child: Container(
          height: Get.height,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Color(0xffDCDFE2)),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: stream,
                      builder: (context, snapshot) {
                        // return Text("data");
                           return snapshot.connectionState == ConnectionState.waiting
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : snapshot.data!.docs.length ==0
                                ? Text("No chat")
                                : ListView.builder(
                                  shrinkWrap: true,
                                    reverse: true,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      // return Text(snapshot.data!.docs[index]["message"]);
                                      return snapshot.data!.docs[index]["SenderId"] == widget.SenderId ?
                                    Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              // mainAxisSize: MainAxi
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '${snapshot.data!.docs[index]["message"]}',
                                                    style: TextStyle(color: const Color.fromARGB(255, 12, 12, 12), fontSize: 13),
                                                  ),
                                                ),

                                              ],
                                            ):
                                               Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              // mainAxisSize: MainAxi
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '${snapshot.data!.docs[index]["message"]}',
                                                    style: TextStyle(color: const Color.fromARGB(255, 12, 12, 12), fontSize: 13),
                                                  ),
                                                ),

                                              ],
                                            );

                                    }
                                    );

                      }),),
              Container(
                width: Get.width,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  // vertical: 16
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 244, 234, 245),
                        spreadRadius: 0,
                        blurRadius: 12,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ],
                    border: Border.all(width: 1, color: Color(0xffDCDFE2)),
                    borderRadius: BorderRadius.circular(15)),

                // foloatinf type message box to write message
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: messageController.message,
                      maxLines: null,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      // controller: chatController.message,
                      decoration: InputDecoration(
                          isCollapsed: true,
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 0, right: 8),
                          border: InputBorder.none,
                          hintText: 'Type your message here...',
                          hintStyle: TextStyle(
                              color: Color(0xffABABAB), fontSize: 13)),
                    )),
                    InkWell(
                        onTap: () async {
                          if (messageController.message.text.isNotEmpty) {
                            messageController.SendMessage(widget.RecieverId);
                          }
                        },
                        child: Icon(Icons.send))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
