import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/view/android/add_contant.dart';
import 'package:provider/provider.dart';
import '../../modal/contact_modal.dart';

class Chat_page extends StatefulWidget {
  ContactModal? contact;

  Chat_page({super.key, this.contact});

  @override
  State<Chat_page> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat_page> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ContactModal? arguments =
        ModalRoute.of(context)?.settings.arguments as ContactModal?;
    widget.contact = arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<ContactProvider>(builder: (context, contactprovider, child) {
        return ListView.separated(
          itemCount: contactprovider.contactlist.length,
          itemBuilder: (context, index) {
            var contactModal = contactprovider.contactlist[index];
            return InkWell(
              onTap: () {
                var cp = Provider.of<ContactProvider>(context, listen: false);
                showBottomSheet(
                  enableDrag: false,
                  elevation: 6,
                  context: context,
                  builder: (context) {
                    return Container(
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20),
                          topStart: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context)
                                .height *
                                0.02,
                          ),
                          Center(
                            child: CircleAvatar(
                                radius: 60,
                                child: Icon(Icons.person,
                                    color: contactModal.filepath == null
                                        ? Colors.white
                                        : Colors.transparent,
                                    size: 49),
                                backgroundImage:
                                contactModal.filepath != null
                                    ? FileImage(
                                  File(contactModal.filepath!),
                                )
                                    : null),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context)
                                .height *
                                0.02,
                          ),
                          Text(
                            contactModal.name!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context)
                                .height *
                                0.01,
                          ),
                          Text(
                            contactModal.chat!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context)
                                .height *
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
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Add_contact(
                                                  index: index);
                                            },
                                          ),
                                        );
                                      },
                                      icon: Icon(
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
                                  width:
                                  MediaQuery.sizeOf(context)
                                      .width *
                                      0.1,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<ContactProvider>(
                                            context,
                                            listen: false)
                                            .remove(index);
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
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
                    );
                  },
                );
                // showBottomSheet(
                //   context: context,
                //   builder: (context) {
                //     return Container(
                //       height: 400,
                //       width: MediaQuery.sizeOf(context).width * 1,
                //
                //       decoration: BoxDecoration(
                //         color: Colors.grey,
                //         borderRadius: BorderRadiusDirectional.only(
                //           topEnd: Radius.circular(20),
                //           topStart: Radius.circular(20),
                //         ),
                //       ),
                //       child: Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.all(10),
                //             child: CircleAvatar(
                //               backgroundImage: contactModal.filepath != null
                //                   ? FileImage(
                //                       File(contactModal.filepath!),
                //                     )
                //                   : null,
                //               child: contactModal.filepath == null
                //                   ? Icon(
                //                       Icons.person,
                //                       size: 40,
                //                     )
                //                   : null,
                //               maxRadius: 60,
                //             ),
                //           ),
                //           Text(
                //             "${contactModal.name}",
                //             style: TextStyle(
                //                 fontSize: 25, fontWeight: FontWeight.bold),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(top: 10),
                //             child: Text(
                //               "${contactModal.chat}",
                //               style: TextStyle(fontWeight: FontWeight.w500),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(top: 20),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 InkWell(
                //                   onTap: () {
                //                     contactprovider.deleteContact(index);
                //                   },
                //                   child: Icon(Icons.delete),
                //                 ),
                //                 InkWell(
                //                   onTap: () {
                //                     ContactModal cm = ContactModal(
                //                         name: cp.nameController.text,
                //                         number: cp.phoneController.text,
                //                         chat: cp.chatController.text,
                //                         selectdate: cp.selectdate,
                //                         selecttime: cp.selecttime,
                //                         filepath: cp.filepath);
                //
                //                     Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => Add_contact(
                //                           index: index,
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                   child: Icon(Icons.edit),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // );
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: contactModal.filepath != null
                      ? FileImage(
                          File(contactModal.filepath??""),
                        )
                      : null,
                  child: contactModal.filepath == null ? Icon(Icons.person) : null,
                ),
                title: Text(contactModal.name ?? ""),
                subtitle: Text(contactModal.chat ?? ""),
                trailing: Text(
                    "${contactModal.selectdate?.day}-${contactModal.selectdate?.month}-${contactModal.selectdate?.year}/${contactModal.selecttime?.hour}:${contactModal.selecttime?.minute}"),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        );
      }),
    );
  }
}
