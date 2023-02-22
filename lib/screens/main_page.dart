// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:messages_app/screens/home.dart';
import 'package:messages_app/screens/people.dart';
import 'package:messages_app/screens/setting.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages=[
    const Home(),
    const Setting()
  ];

  int currentIndex=0;
  onTap(int index){
    setState(() {
      currentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold( 
  bottomNavigationBar: BottomNavigationBar(
    iconSize: 25,
    selectedItemColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 0,
    backgroundColor: Colors.blueGrey,
    currentIndex: currentIndex,
    onTap: onTap,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.chat,color: Colors.white),
        label: 'Chats',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings,color: Colors.white),
        label: 'Settings',
      ),
      
    ],
  ),
      body:pages[currentIndex]
    );
  }
}