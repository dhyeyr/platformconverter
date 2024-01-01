import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  final int? index;

  const Settings({super.key, this.index});

  @override
  State<Settings> createState() => _ContactSaveState();
}

class _ContactSaveState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

      ),

    );
  }
}
