import 'package:flutter/material.dart';
import 'package:platformconverter/view/android/add_contant.dart';
import 'package:platformconverter/view/android/call_page.dart';
import 'package:platformconverter/view/android/chat_page.dart';
import 'package:platformconverter/view/android/setting_page.dart';
import 'view/android/home_page.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      routes: {
        "/": (context) =>Android_home(),
        "ContactSave": (context) =>Add_contact(),
        "ContactSave": (context) =>Chat_page(),
        "ContactSave": (context) =>Settings(),
        "ContactSave": (context) =>Call_page(),

      },
    );
  }
}