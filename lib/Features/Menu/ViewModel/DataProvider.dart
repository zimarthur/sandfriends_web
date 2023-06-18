import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppRecurrentMatch.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:intl/intl.dart';
import 'package:sandfriends_web/SharedComponents/Model/Reward.dart';
import '../../../SharedComponents/Model/AvailableSport.dart';
import '../../../SharedComponents/Model/Employee.dart';
import '../../../SharedComponents/Model/Hour.dart';
import '../../../SharedComponents/Model/HourPrice.dart';
import '../../../SharedComponents/Model/Sport.dart';
import '../../../SharedComponents/Model/Store.dart';
import '../../../SharedComponents/Model/AppMatch.dart';
import '../../../SharedComponents/Model/StoreWorkingHours.dart';
import '../../../Utils/LocalStorage.dart';

class DataProvider extends ChangeNotifier {
  Store? _store;
  Store? get store => _store;
  set store(Store? value) {
    _store = value;
    notifyListeners();
  }

  List<StoreWorkingDay>? get storeWorkingDays {
    if (courts.isEmpty) {
      return null;
    }
    List<StoreWorkingDay> storeWorkingDays = [];
    for (var opDay in courts.first.operationDays) {
      var storeWorkingDay = StoreWorkingDay(
        weekday: opDay.weekday,
        isEnabled: opDay.prices.isNotEmpty,
      );
      if (storeWorkingDay.isEnabled) {
        storeWorkingDay.startingHour = opDay.prices
            .reduce((a, b) => a.startingHour.hour < b.startingHour.hour ? a : b)
            .startingHour;
        storeWorkingDay.endingHour = opDay.prices
            .reduce((a, b) => a.endingHour.hour > b.endingHour.hour ? a : b)
            .endingHour;
      }
      storeWorkingDays.add(
        storeWorkingDay,
      );
    }
    return storeWorkingDays;
  }

  List<Court> courts = [];

  List<Sport> availableSports = [];

  List<Hour> availableHours = [];

  List<AppMatch> matches = [];
  late DateTime matchesStartDate;
  late DateTime matchesEndDate;

  List<AppRecurrentMatch> recurrentMatches = [];

  List<Reward> rewards = [];

  final List<Employee> _employees = [];
  List<Employee> get employees {
    _employees.sort((a, b) {
      if (a.admin == b.admin &&
          a.registrationDate != null &&
          b.registrationDate != null) {
        return a.registrationDate!.compareTo(b.registrationDate!);
      } else {
        return 1;
      }
    });
    return _employees;
  }

  void setEmployeesFromResponse(BuildContext context, String body) {
    Map<String, dynamic> responseBody = json.decode(
      body,
    );
    _employees.clear();
    for (var employee in responseBody["Employees"]) {
      _employees.add(
        Employee.fromJson(
          employee,
        ),
      );
    }
    _employees
        .firstWhere((employee) => employee.email == loggedEmail)
        .isLoggedUser = true;
    notifyListeners();
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
    storeToken(responseBody['AccessToken']);

    for (var employee in responseBody['Store']['Employees']) {
      _employees.add(Employee.fromJson(employee));
    }
    _employees
        .firstWhere((employee) => employee.email == loggedEmail)
        .isLoggedUser = true;

    for (var sport in responseBody['Sports']) {
      availableSports.add(Sport.fromJson(sport));
    }

    for (var hour in responseBody['AvailableHours']) {
      availableHours.add(Hour.fromJson(hour));
    }

    store = Store.fromJson(responseBody['Store']);

    setCourts(responseBody);

    setMatches(responseBody);
    setRecurrentMatches(responseBody);
    setRewards(responseBody);

    matchesStartDate =
        DateFormat("dd/MM/yyyy").parse(responseBody['MatchesStartDate']);
    matchesEndDate =
        DateFormat("dd/MM/yyyy").parse(responseBody['MatchesEndDate']);

    notifyListeners();
  }

  void setCourts(Map<String, dynamic> responseBody) {
    courts.clear();
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
        newCourt.operationDays
            .firstWhere((opDay) => opDay.weekday == courtPrices["Day"])
            .prices
            .add(
              HourPrice(
                startingHour: availableHours.firstWhere(
                    (hour) => hour.hour == courtPrices["IdAvailableHour"]),
                price: courtPrices["Price"],
                recurrentPrice: courtPrices["RecurrentPrice"],
                endingHour: availableHours.firstWhere(
                    (hour) => hour.hour > courtPrices["IdAvailableHour"]),
              ),
            );
      }

      courts.add(newCourt);
    }
  }

  void setMatches(Map<String, dynamic> responseBody) {
    matches.clear();
    for (var match in responseBody['Matches']) {
      matches.add(
        AppMatch.fromJson(
          match,
          availableHours,
          availableSports,
        ),
      );
    }
  }

  void setRecurrentMatches(Map<String, dynamic> responseBody) {
    recurrentMatches.clear();
    for (var recurrentMatch in responseBody['RecurrentMatches']) {
      recurrentMatches.add(
        AppRecurrentMatch.fromJson(
          recurrentMatch,
          availableHours,
          availableSports,
        ),
      );
    }
  }

  void setRewards(Map<String, dynamic> responseBody) {
    rewards.clear();
    for (var reward in responseBody['Rewards']) {
      rewards.add(
        Reward.fromJson(reward),
      );
    }
  }
}
