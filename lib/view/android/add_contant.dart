import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Add_contact extends StatefulWidget {
  final int? index;

  const Add_contact({super.key, this.index});

  @override
  State<Add_contact> createState() => _ContactSaveState();
}

class _ContactSaveState extends State<Add_contact> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         "ADDCONTANCT",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

      ),

    );
  }
}
