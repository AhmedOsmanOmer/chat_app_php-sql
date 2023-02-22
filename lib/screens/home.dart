// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messages_app/controllers/home_controller.dart';
import 'package:messages_app/main.dart';
import 'package:messages_app/screens/chat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Home_Controller>(
      init: Home_Controller(),
      builder: ((controller) => Scaffold(
          backgroundColor: const Color.fromARGB(255, 221, 243, 255),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(pref.getString('url').toString()),
                  radius: 35,
                ),
              ),
            ],
            title: const Center(
                child: Text("Chats", style: TextStyle(color: Colors.white))),
            elevation: 0,
            leading: IconButton(
              icon: Image.asset(
                'assets/menu.png',
                width: 30,
                height: 30,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 100,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    color: Colors.blueGrey),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white)),
                    label: const Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                margin: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 2),
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(50)),
                child: FutureBuilder(
                  future: controller.showChats(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print("${snapshot.data['data'].length}///////////////////////////////////////////////////*****//*");
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                          itemCount: snapshot.data!['data'].length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              onTap: (){ print("${snapshot.data['data'][i]['id']}"); Get.to(const Chat(),arguments:[snapshot.data['data'][i]['id'],snapshot.data['data'][i]['name'],'http://192.168.203.88/messages_app/upload/${snapshot.data['data'][i]['image_url']}']);},
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'http://192.168.203.88/messages_app/upload/${snapshot.data['data'][i]['image_url']}'),
                                  radius: 35,
                                ),
                                trailing: const CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),
                                title: Text("${snapshot.data['data'][i]['name']}"),subtitle:  Text("${snapshot.data['data1'][i]['message']}"),);
                          });
                    }
              
                    /// handles others as you did on question
                    else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ]),
          ))),
    );
  }
}
