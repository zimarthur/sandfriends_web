import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';

import '../../../SharedComponents/Model/AvailableSport.dart';
import '../../../SharedComponents/Model/Employee.dart';
import '../../../SharedComponents/Model/Hour.dart';
import '../../../SharedComponents/Model/HourPrice.dart';
import '../../../SharedComponents/Model/Sport.dart';
import '../../../SharedComponents/Model/Store.dart';
import '../../../SharedComponents/Model/Match.dart';
import '../../../Utils/LocalStorage.dart';

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

  void setLoginResponse(String response, bool keepConnected) {
    Map<String, dynamic> responseBody = json.decode(
      response,
    );
    loggedAccessToken = responseBody["AccessToken"];
    loggedEmail = responseBody["LoggedEmail"];
    if (keepConnected) {
      storeToken(responseBody['AccessToken']);
    }

    for (var employee in responseBody['Store']['Employees']) {
      employees.add(Employee.fromJson(employee));
    }
    employees
        .firstWhere((employee) => employee.email == loggedEmail)
        .isLoggedUser = true;

    for (var sport in responseBody['Sports']) {
      availableSports.add(Sport.fromJson(sport));
    }

    for (var hour in responseBody['AvailableHours']) {
      availableHours.add(Hour.fromJson(hour));
    }

    store = Store.fromJson(responseBody['Store']);

    for (var court in responseBody['Courts']) {
      var newCourt = Court.fromJson(court);
      for (var sport in availableSports) {
        bool foundSport = false;
        for (var courtSport in court["Sports"]) {
          if (courtSport["IdSport"] == sport.idSport) {
            foundSport = true;
          }
        }
        newCourt.sports
            .add(AvailableSport(sport: sport, isAvailable: foundSport));
      }
      for (var courtPrices in court["Prices"]) {
        newCourt.prices.add(
          HourPrice(
            startingHour: availableHours.firstWhere(
                (hour) => hour.hour == courtPrices["IdAvailableHour"]),
            weekday: courtPrices["Day"],
            allowReccurrent: courtPrices["AllowRecurrent"],
            price: courtPrices["Price"],
            recurrentPrice:
                courtPrices["RecurrentPrice"] ?? courtPrices["Price"],
            endingHour: availableHours.firstWhere(
                (hour) => hour.hour > courtPrices["IdAvailableHour"]),
          ),
        );
      }

      courts.add(newCourt);
    }
    if (courts.isNotEmpty) {
      List<HourPrice> courtPrices = courts.first.prices;
      if (courtPrices.isNotEmpty) {
        for (int weekday = 0; weekday < 7; weekday++) {
          List<HourPrice> filteredPrices = courtPrices
              .where((hourPrice) => hourPrice.weekday == weekday)
              .toList();
          operationDays.add(
            OperationDay(
              weekDay: weekday,
              startingHour: filteredPrices
                  .map((hourPrice) => hourPrice.startingHour)
                  .reduce((a, b) => a.hour < b.hour ? a : b),
              endingHour: filteredPrices
                  .map((hourPrice) => hourPrice.startingHour)
                  .reduce((a, b) => a.hour > b.hour ? a : b),
            ),
          );
        }
      }
    }
    notifyListeners();
  }
}
