import 'package:flutter/cupertino.dart';

class PlatformProvider extends ChangeNotifier {

  bool isAndroid = false;
  // bool isIos = true;
  bool ispro=false;

  void changeplatform() {
    isAndroid = !isAndroid;
    // isIos=!isIos;
    notifyListeners();
  }
  void Pro() {
    ispro = !ispro;

    notifyListeners();
  }
}

