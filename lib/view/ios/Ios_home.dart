// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:platformconverter/controller/platform_provider.dart';
// import 'package:provider/provider.dart';
//
// class Homepage1 extends StatefulWidget {
//   const Homepage1({super.key});
//
//   @override
//   State<Homepage1> createState() => _Homepage1State();
// }
//
// class _Homepage1State extends State<Homepage1> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PlatformProvider>(
//       builder: (context, platformprovider, child) {
//         return CupertinoPageScaffold(
//           backgroundColor: Colors.white,
//           navigationBar: CupertinoNavigationBar(
//             backgroundColor: Colors.white,
//             middle: Text(
//               "Platform Converter",
//               style: TextStyle(color: Colors.black),
//             ),
//             trailing: CupertinoSwitch(
//               value: platformprovider.isAndroid,
//               onChanged: (value) {
//                 platformprovider.changeplatform();
//               },
//             ),
//           ),
//           child: CupertinoTabBar(
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.person_add),
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.person_add),
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.person_add),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platformconverter/controller/contactlist_provider.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/controller/platform_provider.dart';
import 'package:platformconverter/modal/contact_modal.dart';
import 'package:platformconverter/view/ios/call_ios.dart';
import 'package:platformconverter/view/ios/chat_ios.dart';
import 'package:platformconverter/view/ios/profile_ios.dart';
import 'package:platformconverter/view/ios/setting_ios.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final int? index;

  const Home({super.key, this.index});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = " Save";
  final format = DateFormat("dd -MM -yyyy");

  @override
  void initState() {
    super.initState();
    var cm = Provider.of<ContactProvider>(context, listen: false);

    if (widget.index != null) {
      var clp = Provider.of<ContactProvider>(context, listen: false);
      var cmd = clp.contactlist[widget.index!];
      cm.phoneController.text = cmd.number ?? "";
      cm.nameController.text = cmd.name ?? "";

      title = " Add ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Contacts",
          style: TextStyle(
              color: Color(0xff060408),
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
        trailing: Consumer<PlatformProvider>(
          builder: (context, plate, child) {
            return CupertinoSwitch(
              value: plate.isAndroid,
              onChanged: (value) {
                plate.changeplatform();
              },
            );
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<ContactProvider>(
                builder: (context, page, child) {
                  return IndexedStack(
                    index: page.iconindex,
                    children: const [
                      Profile(),
                      IosChat(),
                      Calls(),
                      IosSettings(),
                    ],
                  );
                },
              ),
              Consumer<ContactProvider>(
                builder: (BuildContext context, page, Widget? child) {
                  return CupertinoTabBar(
                    onTap: (value) {
                      page.changeIndex(value);
                    },
                    currentIndex: page.iconindex,
                    items: [
                      BottomNavigationBarItem(
                        label: "Profile",
                        tooltip: "Add Person",
                        activeIcon: Icon(
                          CupertinoIcons.person_add,
                          size: 30,
                        ),
                        icon: const Icon(
                          CupertinoIcons.person_add,
                          size: 30,
                          color: Colors.brown,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: "Chats",
                        tooltip: "Messages",
                        activeIcon:
                            Icon(CupertinoIcons.chat_bubble_2_fill, size: 30),
                        icon: const Icon(CupertinoIcons.chat_bubble_2_fill,
                            color: Colors.brown, size: 30),
                      ),
                      BottomNavigationBarItem(
                        label: "Calls",
                        tooltip: "Calls",
                        activeIcon:
                            Icon(CupertinoIcons.phone_circle_fill, size: 30),
                        icon: const Icon(CupertinoIcons.phone_circle_fill,
                            color: Colors.brown, size: 30),
                      ),
                      BottomNavigationBarItem(
                        label: "Settings",
                        tooltip: "Settings",
                        activeIcon: Icon(CupertinoIcons.settings, size: 30),
                        icon: const Icon(
                          CupertinoIcons.settings,
                          size: 30,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
