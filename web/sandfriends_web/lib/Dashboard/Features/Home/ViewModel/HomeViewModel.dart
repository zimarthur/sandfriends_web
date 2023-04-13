import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String get welcomeTitle {
    int hourNow = DateTime.now().hour;
    if (hourNow < 12) {
      return "Bom dia, Beach Brasil!";
    } else if (hourNow < 18) {
      return "Boa tarde, Beach Brasil!";
    } else {
      return "Boa noite, Beach Brasil!";
    }
  }
}
