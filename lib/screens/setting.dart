// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messages_app/controllers/settings_controller.dart';
import 'package:messages_app/main.dart';


class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<Settings_Controller>(
            init: Settings_Controller(),
            builder: (controller) => SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Stack(children: [
                          InkWell(
                            onTap: () {
                              controller.chooseImage(context);
                            },
                            child: Stack(children: [
                              controller.myfile == null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          pref.getString('url').toString()),
                                      backgroundColor: Colors.teal,
                                      radius: 60)
                                  : CircleAvatar(
                                      backgroundImage:
                                          FileImage(controller.myfile!),
                                      backgroundColor: Colors.teal,
                                      radius: 60),
                              const Positioned(
                                  height: 200,
                                  left: 80,
                                  child: CircleAvatar(
                                      child: Icon(Icons.camera_alt)))
                            ]),
                          ),
                        ]),
                        const SizedBox(height: 10),
                        Text(
                          pref.getString('name').toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: ListTile.divideTiles(
                                color: Colors.black,
                                context: context,
                                tiles: [
                                  ListTile(
                                    style: ListTileStyle.list,
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.dark_mode,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: const Text("Dark Mode",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    trailing: CupertinoSwitch(
                                      value: controller.switchValue,
                                      onChanged: (value) {
                                        if (value == true) {
                                          pref.setString('mode', 'dark');
                                          Get.changeTheme(ThemeData.dark());
                                        } else {
                                          pref.setString('mode', 'light');
                                          Get.changeTheme(ThemeData.light());
                                        }
                                        setState(() {
                                          controller.switchValue = value;
                                        });
                                      },
                                      //activeTrackColor: Colors.lightGreenAccent,
                                      activeColor: Colors.green,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: (){pref.clear();},
                                    style: ListTileStyle.list,
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: const Text("Notifications & Sounds",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text("On",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Icon(Icons.arrow_forward,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                  const ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.contacts_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text("Phone Contacts",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    trailing: Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                  ),
                                  const ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text("Photos & Media",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    trailing: Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                  )
                                ]).toList(),
                          ),
                        ),

                        ////
                        ///
                        ///
                        ///

                        ///
                        ///
                        //
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: ListTile.divideTiles(
                                color: Colors.black,
                                context: context,
                                tiles: [
                                  const ListTile(
                                    style: ListTileStyle.list,
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.switch_account_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text("Account Settings",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    trailing: Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                  ),
                                  const ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.report_problem,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text("Report Problem",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    trailing: Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      controller.logout();
                                    },
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: const Text("Logout",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    trailing: const Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                  )
                                ]).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
