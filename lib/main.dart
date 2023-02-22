import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messages_app/screens/login.dart';
import 'package:messages_app/screens/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
late SharedPreferences pref;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'lora'
      ),
      home:pref.getString('id')!=null?const MainPage(): const Login(),
    );
  }
}

