import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Call_Page extends StatefulWidget {
  const Call_Page({super.key});

  @override
  State<Call_Page> createState() => _CallPageState();
}

class _CallPageState extends State<Call_Page> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<ContactProvider>(context).contactlist.isNotEmpty
     ? Consumer<ContactProvider>(
        builder: (context, contactprovider, child) {
          return Scaffold(
            body: ListView.builder(
              itemCount: contactprovider.contactlist.length,
              itemBuilder: (context, index) {
                var contactModal = contactprovider.contactlist[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: contactModal.filepath != null
                        ? FileImage(
                      File(contactModal.filepath?? ""),
                    )
                        : null,
                    child: contactModal.filepath == null ? Icon(Icons.person) : null,
                  ),
                  title: Text(contactModal.name ?? ""),
                  subtitle: Text(contactModal.chat ?? ""),
                  trailing:   IconButton(
                    onPressed: () {
                      var uri = Uri.parse(
                          "tel:+91${contactModal.number}");

                      launchUrl(uri);
                    },
                    icon: Icon(Icons.call),
                  ),
                );
              },
            ),
          );
        })
        : Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Not Any Calls Yet...!",
            style: TextStyle(
                color: Color(0xff171DF7),
                fontSize: MediaQuery.of(context).devicePixelRatio * 7),
          ),
        ),
      ],
    );
  }
}