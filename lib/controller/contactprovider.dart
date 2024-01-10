import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platformconverter/modal/contact_modal.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModal> contactlist = [];
  List<ContactModal> chatlist = [];
  // XFile? xFile;
  ImagePicker picker = ImagePicker();
  String? filepath;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> ioseditlKey = GlobalKey<FormState>();
  GlobalKey<FormState> iosKey = GlobalKey<FormState>();

  DateTime? selectdate;
  TimeOfDay? selecttime;

  void add(ContactModal contact) {
    contactlist.add(contact);
    notifyListeners();
  }

  void remove(int index) {
    contactlist.removeAt(index);
    notifyListeners();
  }

  void edit(int index, ContactModal contact) {
    contactlist[index] = contact;
    notifyListeners();
  }

  // void addcontact(ContactModal contact) {
  //   contactlist.add(contact);
  //   notifyListeners();
  // }
  void addcontact(ContactModal contact) {
    contactlist.add(contact);
    chatlist.add(contact);
    notifyListeners();
  }

  // void imagecamera() {
  //   picker.pickImage(source: ImageSource.camera).then(
  //     (value) {
  //       xFile = value;
  //       notifyListeners();
  //     },
  //   );
  // }
  void pickImage(bool isCamera) async {
    XFile? file = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    filepath = file?.path;
    notifyListeners();
  }

  void reset() {
    nameController.clear();
    phoneController.clear();
    chatController.clear();
    filepath = null;
    selectdate = null;
    selecttime = null;
  }

  void editContact(int index, ContactModal contact) {
    contactlist[index] = contact;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void changedata(DateTime dateTime) {
    this.selecttime = selecttime;
    notifyListeners();
  }

  void deleteContact(int index) {
    contactlist.removeAt(index);
    notifyListeners();
  }

  int iconindex = 0;

  void changeIndex(int index) {
    iconindex = index;
    notifyListeners();
  }
}


