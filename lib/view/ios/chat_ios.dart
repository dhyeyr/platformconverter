import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/modal/contact_modal.dart';
import 'package:platformconverter/view/ios/edit_ios.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/contactlist_provider.dart';
class IosChat extends StatefulWidget {
  const IosChat({super.key});

  @override
  State<IosChat> createState() => _IosChatState();
}

class _IosChatState extends State<IosChat> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Provider.of<ContactProvider>(context).contactlist.isNotEmpty
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height:
                                  MediaQuery.sizeOf(context).height *
                                      0.02,
                                ),
                                Center(
                                  child: CircleAvatar(
                                      radius: 60,
                                      child: Icon(
                                          CupertinoIcons
                                              .person_alt_circle_fill,
                                          color: cl.filepath == null
                                              ? Colors.white
                                              : Colors.transparent,
                                          size: 70),
                                      backgroundImage: cl.filepath != null
                                          ? FileImage(
                                        File(cl.filepath!),
                                      )
                                          : null),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.sizeOf(context).height *
                                      0.02,
                                ),
                                Text(
                                  cl.name!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.sizeOf(context).height *
                                      0.01,
                                ),
                                Text(
                                  cl.chat!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.sizeOf(context).height *
                                      0.02,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CupertinoButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return Iosedit(
                                                        index: index);
                                                  },
                                                ),
                                              );
                                            },
                                            child: Icon(
                                              Icons.edit_note_sharp,
                                              size: 30,
                                            ),
                                          ),
                                          Text(
                                            "Edit contact",
                                            style: TextStyle(
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context)
                                            .width *
                                            0.1,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CupertinoButton(
                                            onPressed: () {
                                              Provider.of<ContactProvider>(
                                                  context,
                                                  listen: false)
                                                  .remove(index);
                                              Navigator.pop(context);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              size: 30,
                                            ),
                                          ),
                                          Text("Delete",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  leading: Consumer<ContactProvider>(
                    builder:
                        (BuildContext context, contact, Widget? child) {
                      return CircleAvatar(
                          radius: 40,
                          child: Icon(
                              CupertinoIcons.person_alt_circle_fill,
                              color: cl.filepath == null
                                  ? Colors.white
                                  : Colors.transparent,
                              size: 30),
                          backgroundImage: cl.filepath != null
                              ? FileImage(
                            File(cl.filepath!),
                          )
                              : null);
                    },
                  ),
                  title: Text(
                    cl.name!,
                  ),
                  subtitle: Text(
                    cl.chat!,
                  ),
                  trailing: Text(
                    cl.selectdate != null
                        ? "${cl.selectdate?.day}/${cl.selectdate?.month}/${cl.selectdate?.year},${cl.selectdate?.hour}:${cl.selectdate?.minute}"
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                );
              },
            ),
          );
        },
      )
          : Container(
        height: MediaQuery.sizeOf(context).height * 0.8,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.chat_bubble_2_fill,
                size: MediaQuery.of(context).devicePixelRatio * 10),
            Text(
              "Not Any Messages Yet...!",
              style: TextStyle(
                  color: Color(0xff171DF7),
                  fontSize: MediaQuery.of(context).devicePixelRatio * 7),
            ),
          ],
        ),
      ),
    );
  }
}