import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/controller/theme_provider.dart';
import 'package:platformconverter/modal/contact_modal.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  final int? index;

  const Settings({super.key, this.index});

  @override
  State<Settings> createState() => _ContactSaveState();
}

class _ContactSaveState extends State<Settings> {
  ImagePicker picker = ImagePicker();
  XFile? xFile;
  bool swtich = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.person,
                color: Colors.lightBlueAccent,
                size: 45,
              ),
              SizedBox(
                width: 20,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Profile \n',
                      // style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //
                      //     fontSize: 20),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: 'Update Profile Data',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) => Switch(
                    value: swtich,
                        onChanged: (value) {
                          swtich = value;
                          setState(() {});
                          print(value);
                        },

                      )),
            ]),
            if(swtich)

              Container(
                child: Consumer<ContactProvider>(
                    builder: (context, contactprovider, child) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  contactprovider.pickImage(true);
                                },
                                child: CircleAvatar(
                                  minRadius: 80,
                                  backgroundImage: contactprovider.filepath != null
                                      ? FileImage(
                                    File(contactprovider.filepath?? ""),
                                  )
                                      : null,
                                  child: contactprovider.filepath == null
                                      ? Icon(Icons.add_a_photo_outlined)
                                      : null,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 130),
                              child: TextFormField(
                                controller: contactprovider.nameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your name...",

                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 140),
                              child: TextFormField(
                                // controller: contactprovider.nameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your bio...",

                                ),
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                var cp = Provider.of<ContactProvider>(context,
                                    listen: false);

                                ContactModal cm = ContactModal(
                                    name: cp.nameController.text,
                                    number: cp.phoneController.text,
                                    chat: cp.chatController.text,
                                    filepath: cp.filepath);

                                contactprovider.addcontact(cm);
                                contactprovider.reset();
                                print(contactprovider.contactlist);

        // Navigator.pushNamed(context, 'chatpage');
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                                child: Center(
                                  child: Text("Save",
                                      style: Theme.of(context).textTheme.bodyMedium

                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),

            SizedBox(
              height: 10,
            ),
            Divider(
                color: Colors.grey, thickness: 1.2, indent: 15, endIndent: 15),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.sunny,
                size: 45,
                color: Colors.lightBlueAccent,
              ),
              SizedBox(
                width: 20,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Theme \n',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: 'Change Theme',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 130,
              ),
              Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) => Switch(
                    value: themeProvider.currentTheme,
                    onChanged: (bool value) {
                      themeProvider.changeTheme(value);
                    },
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
