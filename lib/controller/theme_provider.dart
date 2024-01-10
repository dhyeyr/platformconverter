// import 'package:flutter/material.dart';
// import 'package:platformconverter/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   bool isDark = prefs.getBool("theme")??false;
//   bool currentTheme = false;
//
//
//   void changeTheme() async {
//     isDark = !isDark;
//     prefs.setBool("theme", isDark);
//     notifyListeners();
//   }
//   void getTheme() {
//     bool? val=prefs.getBool("theme");
//     print("Theme ==> $val");
//   }
//
//   ThemeMode? get thememode {
//     if (currentTheme == false) {
//       return ThemeMode.light;
//     } else if (currentTheme == true) {
//       return ThemeMode.dark;
//     }
//     return null;
//   }
//
//
//   void iosTheme() async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     await preferences.setBool("theme", isDark);
//     isDark = !isDark;
//     notifyListeners();
//   }
//
//   void getIos() async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     var iosthme = preferences.getBool("theme");
//   }
//
//
//   settheme(String theme) async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     await preferences.setString("theme", theme);
//     notifyListeners();
//   }
//
//   gettheme() async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     notifyListeners();
//   }
//
// }
//
//
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/main.dart';


class ThemeProvider extends ChangeNotifier {
  bool currentTheme = false;

  ThemeMode? get thememode {
    if (currentTheme == false) {
      return ThemeMode.light;
    } else if (currentTheme == true) {
      return ThemeMode.dark;
    }
    return null;
  }

  void changeTheme(bool theme) {
    prefs.setBool('theme', theme);
    currentTheme = theme;
    notifyListeners();
  }

  void getTheme() {
    currentTheme = prefs.getBool('theme') ?? false;
    notifyListeners();
  }

}
