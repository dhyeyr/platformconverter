import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/controller/platform_provider.dart';
import 'package:platformconverter/view/android/setting_page.dart';
import 'package:platformconverter/view/ios/Ios_home.dart';
import 'package:provider/provider.dart';

import 'add_contant.dart';
import 'call_page.dart';
import 'chat_page.dart';

class Android_home extends StatefulWidget {
  const Android_home({super.key});

  @override
  State<Android_home> createState() => _Android_homeState();
}

class _Android_homeState extends State<Android_home> {

  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
     return

       Consumer<PlatformProvider>(
           builder: (context, platformprovider, child) {
             return platformprovider.isAndroid
                 ? const Home()
                 : DefaultTabController(
               length: 4,
               child: Scaffold(
                 appBar: AppBar(
                   title: Text("Platform Converter"),
                   actions: [
                   Switch(
                   inactiveTrackColor: Colors.black38,
                   activeColor: Colors.white,
                   activeTrackColor: Colors.green,
                     value: platformprovider.isAndroid,
                       onChanged: (bool value) {
                         platformprovider.changeplatform();
                       },
                 )

                   ],
                   bottom: TabBar(
                     physics: BouncingScrollPhysics(),
                     labelStyle: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.w500,
                     ),
                     tabs: [
                       Icon(Icons.person_add_alt),
                       Text("CHATS"),
                       Text("CALLS"),
                       Text("SETTING"),
                     ],
                   ),
                 ),
                 body: TabBarView(
                     children: [Add_contact(), Chat_page(), Call_Page(), Settings()]
                 ),
               ),
             );
           });


  }
}

