// ignore_for_file: camel_case_types, unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messages_app/screens/login.dart';
import 'package:http/http.dart' as http;
class Home_Controller extends GetxController{
  var chatList=[];
String url = "http://192.168.203.88/messages_app";

//
   static final _googleSignIn=GoogleSignIn();
  logout()async{
  await _googleSignIn.disconnect();
  Get.offAll(()=>const Login());
}

showChats()async{
var respond = await http.post(Uri.parse("$url/getchat.php"));
var result=json.decode(respond.body);
if(result['status']=="success"){
  print("${result['data']} data data dat ");
  return result;
}
else{
  printError();
}
update();
}
}