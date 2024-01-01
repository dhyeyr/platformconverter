import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chat_page extends StatefulWidget {
  final int? index;

  const Chat_page({super.key, this.index});

  @override
  State<Chat_page> createState() => _ContactSaveState();
}

class _ContactSaveState extends State<Chat_page> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "chates",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

      ),

    );
  }
}
