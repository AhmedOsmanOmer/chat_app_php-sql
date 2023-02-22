// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:messages_app/constant.dart';
import 'package:messages_app/controllers/auth_controller.dart';
import 'package:messages_app/main.dart';
import 'package:messages_app/screens/login.dart';
import 'package:messages_app/widget/widget.dart';
import 'package:path/path.dart';

class Settings_Controller extends GetxController {
bool switchValue=false;

  Auth_Controller ac = Auth_Controller();
  String url = "http://192.168.203.88/messages_app";
  File? myfile;
  changeImage(BuildContext context) async {
    if (myfile == null) {
      showMessage(context, "Please Choose Image", DialogType.error);
    }
    var respond = await ac.postRequestWithFile("$url/change_image.php",
        {'id': pref.getString('id').toString()}, myfile!);
    pref.setString('url',
        'http://192.168.203.88/messages_app/upload/${basename(myfile!.path)}');
    /*showSnackBar(
            context, "Failed To Select Image");*/
    update();
    Get.back();
  }

  chooseImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) => Container(
          decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(20),
              height: 150,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () async {
                        XFile? xfile = await ImagePicker()
                            .pickImage(source: ImageSource.camera)
                            .whenComplete(() {
                          update();
                        });
                        myfile = File(xfile!.path);
                        update();
                        changeImage(context);
                        update();
                      },
                      child: Column(
                        children: const [
                          Icon(Icons.camera_enhance,size: 60),
                          Text("From Camera"),
                        ],
                      )),
                  const SizedBox(height: 15),
                  InkWell(
                      onTap: () async {
                        XFile? xfile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .whenComplete(() {
                          update();
                        });
                        myfile = File(xfile!.path);
                        update();
                        changeImage(context);
                        update();
                      },
                      child: Column(
                        children: const [
                          Icon(Icons.photo,size: 60),
                          Text("From Gallery"),
                        ],
                      )),
                ],
              ),
            ));
    update();
  }

  logout() async {
    await googleSignIn.disconnect();
    pref.clear();
    Get.offAll(() => const Login());
  }
}
