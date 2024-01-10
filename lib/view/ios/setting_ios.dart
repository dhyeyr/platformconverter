import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/controller/platform_provider.dart';
import 'package:provider/provider.dart';


import '../../controller/theme_provider.dart';

class IosSettings extends StatefulWidget {
  const IosSettings({super.key});

  @override
  State<IosSettings> createState() => _IosSettingsState();
}

class _IosSettingsState extends State<IosSettings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoListTile(
            trailing: Consumer<PlatformProvider>(
              builder: (BuildContext context, pa, Widget? child) {
                return CupertinoSwitch(
                  autofocus: true,
                  value: pa.ispro,
                  onChanged: (value) {
                     pa.Pro();
                  },
                );
              },
            ),
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.blueAccent,
            ),
            title: Text("Profile",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            subtitle: Text(
              "Update Profile Data",
            ),
          ),
          if (Provider.of<PlatformProvider>(context).ispro)
            Container(
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: MediaQuery.sizeOf(context).width,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: CupertinoButton(
                        onPressed: () {
                          Provider.of<ContactProvider>(context, listen: false)
                              .picker;
                        },
                        child: Icon(
                          CupertinoIcons.camera,
                          color:
                          Provider.of<ContactProvider>(context, listen: false)
                              .filepath ==
                              null
                              ? Colors.white
                              : Colors.transparent,
                          size: 40,
                        ),
                      ),
                      radius: 80,
                      backgroundImage:
                      Provider.of<ContactProvider>(context).filepath != null
                          ? FileImage(File(
                          Provider.of<ContactProvider>(context)
                              .filepath as String ))
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width / 3),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter Your Name...",
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.blueAccent,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width / 3),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter Your Bio",
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.blueAccent,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          CupertinoListTile(
            trailing:
            Consumer<ThemeProvider>(
              builder: (context, themeprovider, child) {
                return   CupertinoSwitch(
                  value: themeprovider.currentTheme,
                  onChanged: (value) {
                    themeprovider.changeTheme(value);
                  },
                );
              },
            ),

            leading: Icon(
              CupertinoIcons.person,
              color: Colors.blueAccent,
            ),
            title: Text("Thememode",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            subtitle: Text(
              "Update Theme Data",

            ),
          ),

        ],
      ),
    );
  }
}
