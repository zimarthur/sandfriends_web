import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';

import '../../SharedComponents/Model/Hour.dart';
import '../../SharedComponents/Model/Sport.dart';
import '../../SharedComponents/Model/Store.dart';

class DataProvider extends ChangeNotifier {
  Store? _store;
  Store? get store => _store;
  set store(Store? value) {
    _store = value;
    notifyListeners();
  }

  List<Court> courts = [];

  List<Sport> sports = [];

  List<Hour> hours = [];
}
