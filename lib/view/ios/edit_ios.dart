import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/modal/contact_modal.dart';
import 'package:platformconverter/view/ios/chat_ios.dart';
import 'package:provider/provider.dart';

import '../../controller/contactlist_provider.dart';


class Iosedit extends StatefulWidget {
  final int? index;

  const Iosedit({super.key, this.index});

  @override
  State<Iosedit> createState() => _IoseditState();
}

class _IoseditState extends State<Iosedit> {
  final LocalAuthentication auth = LocalAuthentication();
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
      navigationBar: widget.index != null
          ? CupertinoNavigationBar(
        leading: CupertinoButton(
          child: Icon(Icons.arrow_circle_left_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text("Edit Chats"),
      )
          : null,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Consumer<ContactProvider>(
                    builder: (context, contactprovider, child) {
                      return Consumer<ContactProvider>(
                        builder:
                            (BuildContext context, contact, Widget? child) {
                          return Form(
                            key: contact.ioseditlKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      minRadius: 50,
                                      backgroundImage: contact.filepath != null
                                          ? FileImage(
                                        File(contactprovider.filepath! ),
                                      )
                                          : null,
                                      child: contactprovider.filepath == null
                                          ? CupertinoButton(
                                        onPressed: () {
                                          contact.picker;
                                        },
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )
                                          : null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,  right: 20),
                                    child: CupertinoTextFormFieldRow(
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return "Enter Name";
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: contact.nameController,
                                      keyboardType: TextInputType.name,
                                      prefix: Icon(
                                          CupertinoIcons.person_alt_circle),
                                      decoration:
                                      BoxDecoration(color: Colors.black38),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,  right: 20),
                                    child: CupertinoTextFormFieldRow(

                                      controller: contact.phoneController,
                                      keyboardType: TextInputType.phone,
                                      prefix: Icon(CupertinoIcons.phone),
                                      decoration:
                                      BoxDecoration(color: Colors.black38),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,  right: 20),
                                    child: CupertinoTextFormFieldRow(

                                      controller: contact.chatController,
                                      prefix: Icon(
                                          CupertinoIcons.chat_bubble_2_fill),
                                      decoration:
                                      BoxDecoration(color: Colors.black38),
                                    ),
                                  ),
                                  Consumer<ContactProvider>(
                                    builder: (BuildContext context, data,
                                        Widget? child) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 200),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                              ),
                                              data.selectdate == null
                                                  ? Text(
                                                "Pick Date",
                                                style: TextStyle(
                                                    color:
                                                    Colors.black54),
                                              )
                                                  : Text(
                                                // format.format(data.datetime)
                                                  "${data.selectdate?.day}/${data.selectdate?.month}/${data.selectdate?.year}"),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Consumer<ContactProvider>(
                                    builder: (BuildContext context, time,
                                        Widget? child) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 200),
                                        child: TextButton(
                                          onPressed: () async {
                                            // pTime= time;
                                            time.refresh();
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.watch_later_outlined),
                                              time.selecttime == null
                                                  ? Text(
                                                "Pick Time",
                                                style: TextStyle(
                                                    color:
                                                    Colors.black54),
                                              )
                                                  : Text(
                                                  "${time.selecttime?.hour}:${time.selecttime?.minute}")
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 15),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        var cp = Provider.of<ContactProvider>(
                                            context,
                                            listen: false);
                                        if (cp.globalKey.currentState
                                            ?.validate() ??
                                            false) {
                                          ContactModal cm = ContactModal(
                                              number: cp.phoneController.text,
                                              filepath: cp.filepath,
                                              name: cp.nameController.text,
                                              chat: cp.chatController.text,
                                              selectdate: cp.selectdate,
                                              selecttime: cp.selecttime);

                                          if (widget.index != null) {
                                            Provider.of<ContactProvider>(
                                                context,
                                                listen: false)
                                                .edit(widget.index!, cm);
                                            Navigator.pop(context);
                                            cp.reset();
                                          } else {
                                            Provider.of<ContactProvider>(
                                                context,
                                                listen: false)
                                                .add(cm);
                                          }

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => IosChat(),
                                              ));
                                          cp.reset();
                                        }
                                      },
                                      child: Text(
                                        title,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
