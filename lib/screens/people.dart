// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class People extends StatefulWidget {
  const People({ Key? key }) : super(key: key);

  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text("People", style: TextStyle(color: Colors.white))),
          elevation: 0,
          leading: IconButton(
            icon:const Icon(Icons.menu,size: 40,),
            onPressed: () {},
          ),
        ) ,
      body:SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey
          ),
          child: Column(
                    children: [
                      Container(width: MediaQuery.of(context).size.width,height:2,color: Colors.white,),
                      for (var i = 0; i < 15; i++) ...{
                        ListTile(
                          contentPadding: const EdgeInsets.only(top:10,right: 5,left: 5),
                            leading: Stack(
                                children:const [ CircleAvatar(backgroundImage: AssetImage('assets/person.png'),radius: 35,),Positioned(top: 40,left: 50,child: CircleAvatar(backgroundColor: Colors.green,radius: 8,))]),
                            trailing: const Text('Online',style: TextStyle(
                              color: Colors.white
                            ),),
                           /* subtitle: Row(
                              children: const [
                                Icon(Icons.video_call),
                                Text("Outgoing . Sunday"),
                              ],
                            ),*/
                            title: const Text("Ahmed Osman Omer",
                                style: TextStyle(
                                  
                                    color: Colors.white, fontSize: 17)))
                      }

                    ],
                  ),
        ),
      ),
    );
  }
}