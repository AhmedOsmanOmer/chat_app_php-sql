
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Single_Message extends StatelessWidget {
  final bool isMe;
  final String message;
  const Single_Message({required this.isMe, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isMe?Colors.green:Colors.white
         ),
         child: Text(message,style: const TextStyle(fontSize: 18,color: Colors.black)),
        )
      ],
    );
  }
}
