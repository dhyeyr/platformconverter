import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/controller/contactlist_provider.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/modal/contact_modal.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<ContactProvider>(context).contactlist.isNotEmpty
        ? Consumer<ContactProvider>(
      builder: (context, contact, child) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.82,
          child: ListView.builder(
            itemCount: contact.contactlist.length,
            itemBuilder: (context, index) {
              ContactModal cl = contact.contactlist[index];
              return CupertinoListTile(
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(20),
                              topStart: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height:
                                  MediaQuery.sizeOf(context).height *
                                      0.02,
                                ),

                              ],
                            ),
                          ),
                        );
                      });
                },
                leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 60,
                    child: Icon(CupertinoIcons.person_alt_circle_fill,
                        color: cl.filepath == null
                            ? Colors.white
                            : Colors.transparent,
                        size: 30),
                    backgroundImage: cl.filepath != null
                        ? FileImage(
                      File(cl.filepath!),
                    )
                        : null),
                title: Text(
                  cl.name!,
                ),
                subtitle: Text(
                  cl.number!,
                ),
                trailing: CupertinoButton(
                  child: const Icon(CupertinoIcons.phone),
                  onPressed: () {
                    var uri = Uri.parse("tel:+91${cl.number ?? ""}");
                    launchUrl(uri);
                  },
                ),
              );
            },
          ),
        );
      },
    )
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


