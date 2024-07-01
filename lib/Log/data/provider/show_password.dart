import 'package:flutter/material.dart';

class ShowPassword with ChangeNotifier {
  bool obscureText = true;

  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
