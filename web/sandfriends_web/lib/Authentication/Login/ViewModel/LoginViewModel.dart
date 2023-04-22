import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Authentication/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/Employee.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import '../../../SharedComponents/Model/Store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final _loginRepo = LoginRepoImp();

  PageStatus pageStatus = PageStatus.LOADING;
  String modalTitle = "";
  String modalDescription = "";
  VoidCallback modalCallback = () {};

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool keepConnected = true;

  Future<void> validateToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("AccessToken");
    if (accessToken != null) {
      _loginRepo.validateLogin(accessToken).then((response) {
        setLoginResponse(context, response);
        Navigator.pushNamed(context, '/home');
      }).onError((error, stackTrace) {
        print("eero");
      });
    }
    pageStatus = PageStatus.OK;
    notifyListeners();
  }

  void onTapLogin(BuildContext context) async {
    pageStatus = PageStatus.LOADING;
    notifyListeners();

    _loginRepo
        .login(userController.text, passwordController.text)
        .then((response) {
      setLoginResponse(context, response);
      Navigator.pushNamed(context, '/home');
    }).onError((error, stackTrace) {
      modalTitle = error.toString();
      modalDescription = "";
      modalCallback = () {
        pageStatus = PageStatus.SUCCESS;
        notifyListeners();
      };
      pageStatus = PageStatus.ERROR;
      notifyListeners();
    });
  }

  void setLoginResponse(BuildContext context, Map<String, dynamic> response) {
    //setLoggedEmail(context, response);
    //setEmployees(context, response);
    setSports(context, response);
    setAvailableHours(context, response);
    setStore(context, response);
    setCourts(context, response);

    rootBundle.loadString(r'assets/fakeJson/loggedEmail.json').then((value) {
      setLoggedEmail(context, json.decode(value));
    });
    rootBundle.loadString(r'assets/fakeJson/employee.json').then((value) {
      setEmployees(context, json.decode(value));
    });

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("AccessToken", response['AccessToken']);
    });
  }

  void setLoggedEmail(BuildContext context, Map<String, dynamic> responseBody) {
    Provider.of<DataProvider>(context, listen: false).loggedEmail =
        responseBody["LoggedEmail"];
  }

  void setEmployees(BuildContext context, Map<String, dynamic> responseBody) {
    final store = Provider.of<DataProvider>(context, listen: false).store!;
    final loggedEmail =
        Provider.of<DataProvider>(context, listen: false).loggedEmail;
    Provider.of<DataProvider>(context, listen: false).employees.add(
          Employee(
            firstName: store.ownerName,
            lastName: "",
            email: store.email,
            admin: true,
            registrationDate: store.approvalDate,
            isCourtOwner: true,
          ),
        );
    for (var employee in responseBody['Employees']) {
      Provider.of<DataProvider>(context, listen: false)
          .employees
          .add(Employee.fromJson(employee));
    }
    Provider.of<DataProvider>(context, listen: false)
        .employees
        .firstWhere(
          (employee) => employee.email == loggedEmail,
        )
        .isLoggedUser = true;
  }

  void setSports(BuildContext context, Map<String, dynamic> responseBody) {
    for (var sport in responseBody['Sports']) {
      Provider.of<DataProvider>(context, listen: false)
          .availableSports
          .add(Sport.fromJson(sport));
    }
  }

  void setAvailableHours(
      BuildContext context, Map<String, dynamic> responseBody) {
    for (var hour in responseBody['AvailableHours']) {
      Provider.of<DataProvider>(context, listen: false)
          .availableHours
          .add(Hour.fromJson(hour));
    }
  }

  void setStore(BuildContext context, Map<String, dynamic> responseBody) {
    Provider.of<DataProvider>(context, listen: false).store =
        Store.fromJson(responseBody['Store']);
  }

  void setCourts(BuildContext context, Map<String, dynamic> responseBody) {
    for (var court in responseBody['Courts']) {
      var newCourt = Court.fromJson(court);
      for (var sport in Provider.of<DataProvider>(context, listen: false)
          .availableSports) {
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
        newCourt.prices.add(HourPrice(
          startingHour: Provider.of<DataProvider>(context, listen: false)
              .availableHours
              .firstWhere(
                  (hour) => hour.hour == courtPrices["IdAvailableHour"]),
          weekday: courtPrices["Day"],
          allowReccurrent: courtPrices["AllowRecurrent"],
          price: courtPrices["Price"],
          recurrentPrice: courtPrices["RecurrentPrice"] ?? courtPrices["Price"],
          endingHour: Provider.of<DataProvider>(context, listen: false)
              .availableHours
              .firstWhere((hour) => hour.hour > courtPrices["IdAvailableHour"]),
        ));
      }

      Provider.of<DataProvider>(context, listen: false).courts.add(newCourt);
    }
    if (Provider.of<DataProvider>(context, listen: false).courts.isNotEmpty) {
      List<HourPrice> courtPrices =
          Provider.of<DataProvider>(context, listen: false).courts.first.prices;
      if (courtPrices.isNotEmpty) {
        for (int weekday = 0; weekday < 7; weekday++) {
          List<HourPrice> filteredPrices = courtPrices
              .where((hourPrice) => hourPrice.weekday == weekday)
              .toList();
          Provider.of<DataProvider>(context, listen: false).operationDays.add(
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
  }

  void onTapForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forgot_password');
  }

  void onTapCreateAccount(BuildContext context) {
    Navigator.pushNamed(context, '/create_account');
  }
}
