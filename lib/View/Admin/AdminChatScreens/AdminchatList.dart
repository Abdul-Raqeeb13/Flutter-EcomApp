// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/Controller/Admin/AdminChatController.dart';
import 'package:ecomapp/View/Admin/AdminChatScreens/AdminMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminChatList extends StatefulWidget {
  const AdminChatList({super.key});

  @override
  State<AdminChatList> createState() => _AdminChatListState();
}

class _AdminChatListState extends State<AdminChatList> {
  final chatController = Get.put(AdminChatController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.getChatList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        title: const Text("Chats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
  if (chatController.UserCharList.isEmpty) {
    return const Center(child: Text("No chats available"));
  }
  return ListView.builder(
    itemCount: chatController.UserCharList.length,
    itemBuilder: (context, index) {
      var chatData = chatController.UserCharList[index];

      return Card(
        elevation: 10,
        child: ListTile(
          title: Text(
            chatData["SenderName"]?.toString() ?? "Unknown User",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            chatData["LastMessage"]?.toString() ?? "No message available",
          ),
          trailing: const Icon(Icons.chat),
          onTap: () async {
            final SharedPreferences sharedprefs =
                await SharedPreferences.getInstance();
            var senderId = sharedprefs.getString("userid");

            await chatController.cretaeConverstaion(
                chatController.UserCharList[index]["SenderId"]);

            Get.to(AdminMessageScreen(
                RecieverId: chatController.UserCharList[index]["SenderId"],
                SenderId: senderId));
          },
        ),
      );
    },
  );
}),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00BF6D),
        child: const Icon(Icons.person_add_alt_1, color: Colors.white),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chat,
    required this.press,
  });

  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0 * 0.75),
        child: Row(
          children: [
            CircleAvatarWithActiveIndicator(
              image: chat.image,
              isActive: chat.isActive,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(chat.time),
            ),
          ],
        ),
      ),
    );
  }
}

class FillOutlineButton extends StatelessWidget {
  const FillOutlineButton({
    super.key,
    this.isFilled = true,
    required this.press,
    required this.text,
  });

  final bool isFilled;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: isFilled ? 2 : 0,
      color: isFilled ? Colors.white : Colors.transparent,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? const Color(0xFF1D1D35) : Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

class CircleAvatarWithActiveIndicator extends StatelessWidget {
  const CircleAvatarWithActiveIndicator({
    super.key,
    this.image,
    this.radius = 24,
    this.isActive,
  });

  final String? image;
  final double? radius;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(image!),
        ),
        if (isActive!)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF00BF6D),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 3),
              ),
            ),
          )
      ],
    );
  }
}

class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "Admin Chat",
    lastMessage: "Hope you are doing well...",
    image: "https://i.postimg.cc/g25VYN7X/user-1.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "https://i.postimg.cc/cCsYDjvj/user-2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "https://i.postimg.cc/sXC5W1s3/user-3.png",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "https://i.postimg.cc/4dvVQZxV/user-4.png",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "https://i.postimg.cc/FzDSwZcK/user-5.png",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "https://i.postimg.cc/g25VYN7X/user-1.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "https://i.postimg.cc/cCsYDjvj/user-2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "https://i.postimg.cc/sXC5W1s3/user-3.png",
    time: "5d ago",
    isActive: false,
  ),
];
