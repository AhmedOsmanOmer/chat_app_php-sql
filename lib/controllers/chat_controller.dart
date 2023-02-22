import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_list/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:messages_app/main.dart';
import 'package:messages_app/widget/widget.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
class Chat_Controller extends GetxController {
  ScrollController _scrollController = ScrollController();
  List messages = [];
  TextEditingController msg = TextEditingController();
  String url = "http://192.168.203.88/messages_app";
  sendMessage(String reciver_id, BuildContext context) async {
    if (msg.text == "") {
      showMessage(context, "Enter Message", DialogType.error);
    } else {
      var respond = await http.post(Uri.parse("$url/send_message.php"), body: {
        'message': msg.text,
        'sender_id': pref.getString('id'),
        'reciver_id': reciver_id
      });
      var result = await json.decode(respond.body);
      if (result == "success") {
        print("DOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONE");
        msg.text = "";
        //_scrollController=_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        update();
      } else {
        print("EROOOOOOOOOOOOOOOR SDEEEEEEEEEND //////////////////////////");
      }
    }
  }

//
//
  getMessages(String reciver_id, BuildContext context) async {
    var respond = await http.post(Uri.parse("$url/get_messages.php"),
        body: {'sender_id': pref.getString('id'), 'reciver_id': reciver_id});
    var result = await json.decode(respond.body);
    if (result['status'] == "success") {
      print("${result['data']}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      return result['data'];
    } else {
      print("EROOOOOOOOOOOOOOOR SDEEEEEEEEEND //////////////////////////");
    }
    update();
  }

  Widget fillMessages(reciver_id, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: FutureBuilder(
        future: getMessages(reciver_id, context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                addAutomaticKeepAlives: true,
                controller: _scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return ChatList(
                    padding: EdgeInsets.all(10),
                    scrollController: _scrollController,
                    children: [
                    Message(
                      backgroundColor:snapshot.data[i]['reciver_id']==reciver_id?Colors.green[200]:Colors.white ,
                      textColor: Colors.black,
                      content: snapshot.data[i]['message'],
                      ownerType:  snapshot.data[i]['reciver_id']==reciver_id
                          ? OwnerType.sender
                          : OwnerType.receiver,
                         
                    )
                  ]);
                });
          }

          /// handles others as you did on question
          else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
