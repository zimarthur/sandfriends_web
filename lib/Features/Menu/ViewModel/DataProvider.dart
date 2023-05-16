import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';

import '../../../SharedComponents/Model/Employee.dart';
import '../../../SharedComponents/Model/Hour.dart';
import '../../../SharedComponents/Model/Sport.dart';
import '../../../SharedComponents/Model/Store.dart';
import '../../../SharedComponents/Model/Match.dart';

class DataProvider extends ChangeNotifier {
  Store? _store;
  Store? get store => _store;
  set store(Store? value) {
    _store = value;
    notifyListeners();
  }

  List<OperationDay> operationDays = [];

  List<Court> courts = [];

  List<Sport> availableSports = [];

  List<Hour> availableHours = [];

  List<Match> matches = [];

  final List<Employee> _employees = [];
  List<Employee> get employees {
    _employees.sort((a, b) {
      if (a.admin == b.admin) {
        return a.registrationDate.compareTo(b.registrationDate);
      } else {
        return 1;
      }
    });
    return _employees;
  }

  void addEmployee(Employee employee) {
    _employees.add(employee);
    notifyListeners();
  }

  Employee get loggedEmployee {
    return employees.firstWhere((employee) => employee.isLoggedUser);
  }

  String loggedAccessToken = "";
  String loggedEmail = "";
}
