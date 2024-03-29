import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/modal/contact_modal.dart';
import 'package:provider/provider.dart';


class Profile extends StatefulWidget {
  final int? index;

  const Profile({super.key, this.index});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ContactProvider>(
            builder: (BuildContext context, contact, Widget? child) {
              return Form(
                key: contact.globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CircleAvatar(
                        minRadius: 80,
                        backgroundImage: contact.filepath != null
                            ? FileImage(
                          File(contact.filepath!),
                        )
                            : null,
                        child: contact.filepath == null
                            ? CupertinoButton(
                          onPressed: () {
                            contact.picker;
                          },
                          child: const Icon(
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
                        placeholder: "Full Name",
                        controller: contact.nameController,
                        keyboardType: TextInputType.name,
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(CupertinoIcons.person_alt_circle, size: 25),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: CupertinoColors.inactiveGray),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 20),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Phone Number",
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter Phone Number";
                          } else if (value?.length != 10) {
                            return "Invalid Phone Number";
                          } else {
                            return null;
                          }
                        },
                        controller: contact.phoneController,
                        keyboardType: TextInputType.phone,
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(CupertinoIcons.phone),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: CupertinoColors.inactiveGray),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20,top: 10),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Chats Conversation",
                        keyboardType: TextInputType.name,
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(CupertinoIcons.chat_bubble_text),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return " Plz Enter Bio";
                          } else {
                            return null;
                          }
                        },
                        controller: contact.chatController,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: CupertinoColors.inactiveGray),
                        ),
                      ),
                    ),
                    Consumer<ContactProvider>(
                      builder: (BuildContext context, data,
                          Widget? child) {
                        return Padding(
                          padding: EdgeInsets.only(right: 180),
                          child: TextButton(
                            onPressed: () async {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.sizeOf(context)
                                        .height *
                                        0.3,
                                    width: MediaQuery.sizeOf(context)
                                        .width,
                                    decoration: BoxDecoration(
                                        color: Colors.white),
                                    child: CupertinoDatePicker(
                                      use24hFormat: false,
                                      maximumDate: DateTime(2050),
                                      maximumYear: 1990,
                                      initialDateTime: DateTime.now(),
                                      dateOrder:
                                      DatePickerDateOrder.dmy,
                                      onDateTimeChanged: (value) {
                                        data.changedata(value);
                                        data.selectdate = value;
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(
                                  CupertinoIcons.calendar,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  data.selectdate == null
                                      ? "Pick Date"
                                      : "${data.selectdate?.day}/${data.selectdate?.month}/${data.selectdate?.year}",
                                  style: TextStyle(
                                      color: Colors.blueAccent),
                                ),
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
                          padding: EdgeInsets.only(right: 180.0),
                          child: TextButton(
                            onPressed: () async {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.sizeOf(context)
                                        .height *
                                        0.3,
                                    width: MediaQuery.sizeOf(context)
                                        .width,
                                    decoration: BoxDecoration(
                                        color: Colors.white),
                                    child: CupertinoDatePicker(
                                      use24hFormat: false,
                                      showDayOfWeek: true,
                                      mode: CupertinoDatePickerMode
                                          .time,
                                      onDateTimeChanged: (value) {
                                        time.changedata(value);
                                        time.selectdate = value;
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(CupertinoIcons.clock),
                                SizedBox(width: 10,),
                                Text(
                                  time.selectdate == null
                                      ? "Pick Time"
                                      : "${time.selectdate?.hour}:${time.selectdate?.minute}",
                                  style: TextStyle(
                                      color: Colors.blueAccent),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          fixedSize: Size(
                              MediaQuery.sizeOf(context).width * 0.3,
                              MediaQuery.sizeOf(context).height *
                                  0.05)),
                      onPressed: () {
                        var cp = Provider.of<ContactProvider>(context,
                            listen: false);
                        if (cp.globalKey.currentState?.validate() ??
                            false) {
                          ContactModal cm = ContactModal(
                              number: cp.phoneController.text,
                              filepath: cp.filepath,
                              name: cp.nameController.text,
                              chat: cp.chatController.text,
                              selectdate: cp.selectdate,
                              selecttime: cp.selecttime);

                          if (widget.index != null) {
                            Provider.of<ContactProvider>(context,
                                listen: false)
                                .edit(widget.index!, cm);

                            cp.reset();
                          } else {
                            Provider.of<ContactProvider>(context,
                                listen: false)
                                .add(cm);
                          }

                          cp.reset();
                        }
                      },
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white),
                      ),
                    )

                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
