import 'package:flutter/material.dart';
import 'package:chat_list/chat_list.dart';
import 'package:get/get.dart';
import 'package:messages_app/controllers/chat_controller.dart';
import 'package:messages_app/main.dart';
import 'package:messages_app/widget/widget.dart';
class Chat extends StatefulWidget {
  const Chat({super.key});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var data = Get.arguments;
  Chat_Controller c=Chat_Controller();
  @override
  void initState() {
    //pref.clear();
    //c.getMessages(data[0]);
    print("${c.messages}3################################################");
    super.initState();
  }
    final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Chat_Controller>(
      init: Chat_Controller(),
      builder: (controller) =>  Scaffold(
          appBar: AppBar(
            leading:  Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(data[2]),
                radius: 10,
              ),
            ),
            title: Text(data[1]),
            /*actions: [
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.call))
                ],
              )
            ],*/
          ),
          body: Container(
            decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wall4.jpg"),
            fit: BoxFit.cover,
          ),
        ),
            child: Stack(
              children:[controller.fillMessages(data[0], context),
             Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text_Form2(const Icon(Icons.keyboard), false, controller.msg,IconButton(onPressed:(){controller.sendMessage(data[0],context);}, icon: const Icon(Icons.send))),
              ),
            )]),
          ),
        ));
      }

  }
