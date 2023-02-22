// ignore_for_file: camel_case_types, use_build_context_synchronously, unnecessary_null_comparison, depend_on_referenced_packages, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messages_app/constant.dart';
import 'package:messages_app/main.dart';
import 'package:messages_app/screens/login.dart';
import 'package:messages_app/screens/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:messages_app/widget/widget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Auth_Controller extends GetxController {
  File? myfile;
  String url = "http://192.168.203.88/messages_app";
  //String image_url = "http://192.168.203.88/messages_app/upload/default.png";

  ///
  ///
  bool isValid = true;
  bool logisvalid = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();

  ///
  //
  final logformKey = GlobalKey<FormState>();

  TextEditingController logEmail = TextEditingController();
  TextEditingController logPassword = TextEditingController();

  ///
  ///
  /*signIn(BuildContext context) async {
    googleSignInAccount = await GoogleSignIn().signIn();
    if (googleSignInAccount == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Faild To login")));
    } else {
      var respond = await http.post(Uri.parse("$url/google.php"), body: {
        'name': googleSignInAccount!.displayName,
        'email': googleSignInAccount!.email,
      });
      var result = await json.decode(respond.body);
      if (result['status'] == "user_exist") {
        print("user exist//////////////////////////////////");
        pref.setString('id', result['data']['id']);
        pref.setString('name', result['data']['name']);
        pref.setString('email', result['data']['email']).toString();
        pref.setString('url', googleSignInAccount!.photoUrl.toString());
        image_url = googleSignInAccount!.photoUrl.toString();
        Get.to(const MainPage());
      } else {
        pref.setString('id', result['data']['id']);
        pref.setString('name', googleSignInAccount!.displayName.toString());
        pref.setString('email', googleSignInAccount!.email.toString());
        pref.setString('url', googleSignInAccount!.photoUrl.toString());
        print("new exist//////////////////////////////////");
        image_url = googleSignInAccount!.photoUrl.toString();
        Get.to(const MainPage());
      }
    }
  }*/
  Future<File> _fileFromImageUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    final documentDirectory = await getApplicationDocumentsDirectory();
     
    final file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }
  signIn(BuildContext context) async {
    GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Faild To login")));
    } else {
      var respond = await postRequestWithFile("$url/google.php",{
        'name': googleSignInAccount.displayName,
        'email': googleSignInAccount.email,
      },myfile==null?myfile=await _fileFromImageUrl(googleSignInAccount.photoUrl.toString()):myfile!);
      var result=json.decode(respond.body);
      if (result['status']== "user_exist") {
        pref.setString('id', result['data']['id'].toString());
        pref.setString('name', result['data']['name']);
        pref.setString('email', result['data']['email']).toString();
        pref.setString('url', googleSignInAccount.photoUrl.toString());
        image_url = googleSignInAccount.photoUrl.toString();
        Get.to(const MainPage());
      } else {
        pref.setString('id', result['data']['id'].toString());
        pref.setString('name', googleSignInAccount.displayName.toString());
        pref.setString('email', googleSignInAccount.email.toString());
        pref.setString('url', googleSignInAccount.photoUrl.toString());
        print("new exist//////////////////////////////////");
        image_url = googleSignInAccount.photoUrl.toString();
        Get.to(const MainPage());
      }
    }
  }

  ///
  ///
  signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isValid = true;
      if (myfile == null) {
        showMessage(context, "Please Choose Image", DialogType.error);
      }
      if (password.text == repassword.text) {
        var respond = await postRequestWithFile(
            "$url/signup.php",
            {'name': name.text, 'email': email.text, 'password': password.text},
            myfile!);
        update();
        Get.to(() => const Login());
        showMessage(
            context, "SignUp Success You Can Login Now", DialogType.success);
      } else {
        showMessage(context, "Password not match", DialogType.error);
      }
    } else {
      isValid = false;
    }
    update();
  }

  login(BuildContext context) async {
    if (logformKey.currentState!.validate()) {
      logisvalid = true;
      var respond = await http.post(Uri.parse("$url/login.php"),
          body: {'email': logEmail.text, 'password': logPassword.text});
      var result = await json.decode(respond.body);
      if (result['status'] == "success") {
      String id=(result["data"]["id"]).toString();
        pref.setString('id',id);
        pref.setString('name', result['data']['name']);
        pref.setString('email', result['data']['email']).toString();
        pref.setString('url',
            "http://192.168.203.88/messages_app/upload/${result['data']['image_url']}");

        image_url =
            "http://192.168.203.88/messages_app/upload/${result['data']['image_url']}";
        print("done.....");
        Get.to(() => const MainPage());
      } else {
        showMessage(
            context, "Username or Password Incorrect", DialogType.error);
      }
    } else {
      logisvalid = false;
    }
    update();
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

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200) {
      return response;
    } else {
      print("error//////////////////****************************/");
    }
  }
}
