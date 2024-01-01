import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/view/android/setting_page.dart';

import 'add_contant.dart';
import 'call_page.dart';
import 'chat_page.dart';

class Android_home extends StatefulWidget {
  const Android_home({super.key});

  @override
  State<Android_home> createState() => _Android_homeState();
}

class _Android_homeState extends State<Android_home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Platform Convertr"),
          bottom: const TabBar(tabs: [
            Icon(
              Icons.person_add_alt_1_outlined,
            ),
            Text("CHATS"),
            Text("CALLS"),
            Text("SETTINGS"),
          ]),
        ),
        body: TabBarView(
            children: [
              Add_contact(),
              Chat_page(),
              Call_page(),
              Settings()]),
      ),
    );
  }
}
