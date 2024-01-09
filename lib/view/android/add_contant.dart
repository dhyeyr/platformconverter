import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/modal/contact_modal.dart';
import 'package:provider/provider.dart';

class Add_contact extends StatefulWidget {
  final int? index;

  const Add_contact({super.key, this.index});

  @override
  State<Add_contact> createState() => _ContactSaveState();
}

class _ContactSaveState extends State<Add_contact> {
  final sDateFormate = "dd/MM/yyyy";
  DateTime selectedDate = DateTime.now();

  // String date = DateFormat("dd/MM/yyyy").format(DateTime.now());

  @override
  void initState() {
    var cp = Provider.of<ContactProvider>(context, listen: false);

    if (widget.index != null) {
      var cp = Provider.of<ContactProvider>(context, listen: false);
      var contactmodel = cp.contactlist[widget.index!];
      cp.nameController.text = contactmodel.name ?? "";
      cp.phoneController.text = contactmodel.number ?? "";
      cp.chatController.text = contactmodel.chat ?? "";
      cp.selecttime = contactmodel.selecttime;
      cp.selectdate = contactmodel.selectdate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<ContactProvider>(builder: (context, ContactProvider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    ContactProvider.pickImage(true);
                  },
                  child: CircleAvatar(
                    minRadius: 80,
                    backgroundImage: ContactProvider.filepath != null
                        ? FileImage(
                            File(ContactProvider.filepath?? ""),
                          )
                        : null,
                    child: ContactProvider.filepath == null
                        ? Icon(Icons.add_a_photo_outlined)
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: ContactProvider.nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: ContactProvider.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: ContactProvider.chatController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.chat),
                    hintText: "Chat Conversation",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        ContactProvider.selectdate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          barrierDismissible: false,
                        );
                        ContactProvider.refresh();
                      },
                      child: Icon(
                        Icons.calendar_month,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ContactProvider.selectdate != null
                          ? "${ContactProvider.selectdate}"
                          : "Pick Date",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        ContactProvider.selecttime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        ContactProvider.refresh();
                      },
                      child: Icon(
                        Icons.access_time_outlined,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ContactProvider.selecttime != null
                          ? "${ContactProvider.selecttime?.hour}:${ContactProvider.selecttime?.minute}"
                          : "PickTime",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(right: 246),
              //   child: Text("Pick Time",style: Theme.of(context).textTheme.bodyLarge,),
              // ),
              InkWell(
                onTap: () {

                  ContactModal cm = ContactModal(
                      name: ContactProvider.nameController.text,
                      number: ContactProvider.phoneController.text,
                      chat: ContactProvider.chatController.text,
                    filepath: ContactProvider.filepath,
                    selectdate: ContactProvider.selectdate,
                    selecttime:ContactProvider.selecttime,);


                  ContactProvider.addcontact(cm);
                  ContactProvider.reset();
                  print(ContactProvider.contactlist);


                  // Navigator.pushNamed(context, 'chatpage');
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      )),
                  child: Center(
                    child: Text("Save",
                        style: Theme.of(context).textTheme.bodyMedium
                        // TextStyle(
                        //   // fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //    ),
                        ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

//
//
// class AddPerson extends StatefulWidget {
//   final int? index;
//   const AddPerson({super.key, this.index});
//
//   @override
//   State<AddPerson> createState() => _AddPersonState();
// }
//
// class _AddPersonState extends State<AddPerson> {
//
//   @override
//   void initState() {
//     var cp = Provider.of<ContactProvider>(context, listen: false);
//
//     if (widget.index != null) {
//       var cp = Provider.of<ContactProvider>(context, listen: false);
//       var contactmodel = cp.contactlist[widget.index!];
//       cp.nameController.text = contactmodel.name ?? "";
//       cp.phoneController.text = contactmodel.number ?? "";
//       cp.xFile = contactmodel.xFile;
//     }
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(30),
//         child: Consumer<ContactProvider>(
//             builder: (context, contactprovider, child) {
//               return SingleChildScrollView(
//                 child: Container(
//                   height: MediaQuery.sizeOf(context).height * 0.7,
//                   width: MediaQuery.sizeOf(context).width * 0.9,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey, spreadRadius: 1, blurRadius: 15),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: InkWell(
//                           onTap: () {
//                             contactprovider.imagecamera();
//                           },
//                           child: CircleAvatar(
//                             minRadius: 80,
//                             backgroundImage: contactprovider.xFile != null
//                                 ? FileImage(
//                               File(contactprovider.xFile?.path ?? ""),
//                             )
//                                 : null,
//                             child: contactprovider.xFile == null
//                                 ? Icon(Icons.add_a_photo_outlined)
//                                 : null,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                         const EdgeInsets.only(top: 20, left: 20, right: 20),
//                         child: TextFormField(
//                           controller: contactprovider.nameController,
//                           keyboardType: TextInputType.name,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.person),
//                             hintText: "Full Name",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                         const EdgeInsets.only(top: 20, left: 20, right: 20),
//                         child: TextFormField(
//                           controller: contactprovider.phoneController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.phone),
//                             hintText: "Phone Number",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: TextFormField(
//                           controller: contactprovider.chatController,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.chat),
//                             hintText: "Chat Conversation",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 250),
//                         child: Text("Pick Date"),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 246),
//                         child: Text("Pick Time"),
//                       ),
//                       // InkWell(
//                       //   // child: Container(
//                       //   //   height: 40,
//                       //   //   width: 100,
//                       //   //   color: Colors.black,
//                       //   //   // decoration: BoxDecoration(
//                       //   //   //   borderRadius: BorderRadius.circular(30),
//                       //   //   //   color: Theme.of(context).colorScheme.primaryContainer,
//                       //   //   //   // color: Colors.white,
//                       //   //   //   // boxShadow: [
//                       //   //   //   //   BoxShadow(
//                       //   //   //   //       //
//                       //   //   //   //
//                       //   //   //   //       spreadRadius: 1,
//                       //   //   //   //       blurRadius: 15),
//                       //   //   //   // ],
//                       //   //   // ),
//                       //   //   child: Center(
//                       //   //     child: InkWell(
//                       //   //       onTap: () {
//                       //   //         var cp = Provider.of<ContactProvider>(context,
//                       //   //             listen: false);
//                       //   //
//                       //   //         ContactModal cm = ContactModal(
//                       //   //             name: cp.nameController.text,
//                       //   //             number: cp.phoneController.text,
//                       //   //             chat: cp.chatController.text,
//                       //   //             xFile: cp.xFile);
//                       //   //
//                       //   //         contactprovider.addcontact(cm);
//                       //   //         contactprovider.reset();
//                       //   //         print(contactprovider.contactlist);
//                       //   //
//                       //   //         // Navigator.pushNamed(context, 'chatpage');
//                       //   //       },
//                       //   //       child: Text("Save",
//                       //   //           style: Theme.of(context).textTheme.titleLarge,),
//                       //   //     ),
//                       //   //   ),
//                       //   // ),
//                       // )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
//
//
