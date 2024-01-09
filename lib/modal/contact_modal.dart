import 'package:flutter/material.dart';

class ContactModal {
  String? name;
  String? number;
  String? contact;
  String? chat;
  String? filepath;
  DateTime? selectdate;
  TimeOfDay? selecttime;

  ContactModal( {this.name, this.number, this.filepath, this.chat,this.selectdate,this.selecttime});
}
