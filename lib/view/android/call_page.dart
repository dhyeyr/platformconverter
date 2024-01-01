import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Call_page extends StatefulWidget {
  final int? index;

  const Call_page({super.key, this.index});

  @override
  State<Call_page> createState() => _ContactSaveState();
}

class _ContactSaveState extends State<Call_page> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "call",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

      ),

    );
  }
}
