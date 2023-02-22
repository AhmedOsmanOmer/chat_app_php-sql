// ignore_for_file: library_private_types_in_public_api, file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:messages_app/constant.dart';
import 'package:messages_app/controllers/auth_controller.dart';
import 'package:messages_app/widget/widget.dart';
import 'package:path/path.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 243, 255),
        body: SingleChildScrollView(
            child: Column(children: [
          ClipPath(
            clipper: WaveClipperOne(flip: true),
            child: Container(
              height: 130,
              width: 500,
              color: Colors.blueGrey,
              child: const Center(
                  child: Text(
                "Registration",
                style: TextStyle(
                    fontFamily: "tangerine", color: Colors.white, fontSize: 50),
              )),
            ),
          ),
          GetBuilder<Auth_Controller>(
            init: Auth_Controller(),
            builder: (controller) => Container(
              margin: const EdgeInsets.only(top: 20, bottom: 60),
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(60)),
              height: controller.isValid ? 620 : 730,
              width: 350,
              child: Column(
                children: [
                  Form(
                      key: controller.formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                controller.chooseImage(context);
                              },
                              child: Stack(children:  [
                                controller.myfile==null?CircleAvatar(
                                    backgroundImage: NetworkImage(image_url),
                                    backgroundColor: Colors.teal,
                                    radius: 60):CircleAvatar(
                                    backgroundImage: FileImage(controller.myfile!),
                                    backgroundColor: Colors.teal,
                                    radius: 60),
                                const Positioned(
                                    height: 200,
                                    left: 80,
                                    child: CircleAvatar(
                                        child: Icon(Icons.camera_alt)))
                              ]),
                            ),
                            const SizedBox(height: 20),
                            Text_Form(
                                const Icon(Icons.person, color: Colors.white),
                                "Name",
                                false,
                                controller.name),
                            const SizedBox(
                              height: 20,
                            ),
                            Text_Form(
                                const Icon(Icons.email, color: Colors.white),
                                "Email",
                                false,
                                controller.email),
                            const SizedBox(
                              height: 20,
                            ),
                            Text_Form(
                                const Icon(Icons.password, color: Colors.white),
                                "Password",
                                true,
                                controller.password),
                            const SizedBox(
                              height: 20,
                            ),
                            Text_Form(
                                const Icon(Icons.password, color: Colors.white),
                                "Re Enter Password",
                                true,
                                controller.repassword),
                            const SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                controller.signUp(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 40, right: 40),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 221, 243, 255),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text("SignUp "),
                                    Icon(Icons.app_registration)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                print(image_url+basename(controller.myfile!.path));
                                //Get.off(() => const Login());
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ])),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ])));
  }
}
