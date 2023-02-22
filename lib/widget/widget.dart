// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//

Widget Text_Form(
    Icon icon, String hint, bool obsec, TextEditingController controller) {
  return TextFormField(
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Fill This Field Please ';
        }
        return null;
      },
      controller: controller,
      obscureText: obsec,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: icon,
         label: Text(
          hint,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ));
    }

   Widget Text_Form2(
    Icon icon, bool obsec, TextEditingController controller,Widget widget) {
  return TextFormField(
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Fill This Field Please ';
        }
        return null;
      },
      controller: controller,
      obscureText: obsec,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(  
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 5),
         suffix:widget,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: icon,
      
      )
       
      );
    }
showMessage(BuildContext context,String msg,DialogType dialog){
  AwesomeDialog(context: context,
  dialogBackgroundColor: const Color.fromARGB(255, 221, 243, 255),
  body: Text(msg),
  dialogType: dialog,
 btnOk: TextButton(child: const Text("OK"),onPressed: (){Get.back();})
  ).show();
}


showSnackBar(BuildContext context,String msg){
    final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message:
                        msg,

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.warning,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
}