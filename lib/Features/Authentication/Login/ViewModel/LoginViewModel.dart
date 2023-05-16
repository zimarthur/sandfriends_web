import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/Employee.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/Model/Store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';
import '../../../../SharedComponents/View/SFMessageModal.dart';
import 'dart:html';

class LoginViewModel extends ChangeNotifier {
  final loginRepo = LoginRepoImp();

  PageStatus pageStatus = PageStatus.LOADING;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
    onTap: () {},
    isHappy: true,
  );

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _keepConnected = true;
  bool get keepConnected => _keepConnected;
  set keepConnected(bool newValue) {
    _keepConnected = newValue;
    notifyListeners();
  }

  void validateToken(BuildContext context) {
    String? storedToken = getToken();
    if (storedToken != null) {
      loginRepo.validateToken(storedToken).then((response) {
        if (response.responseStatus == NetworkResponseStatus.success) {
          setLoginResponse(context, response.responseBody!);
          Navigator.pushNamed(context, '/home');
        } else {
          pageStatus = PageStatus.OK;
          notifyListeners();
        }
      });
    }
    pageStatus = PageStatus.OK;
    notifyListeners();
  }

  void onTapLogin(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();

    loginRepo
        .login(userController.text, passwordController.text)
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        setLoginResponse(context, response.responseBody!);
        Navigator.pushNamed(context, '/home');
      } else {
        messageModal = SFMessageModal(
          title: response.responseTitle!,
          description: response.responseDescription,
          onTap: () {
            pageStatus = PageStatus.OK;
            notifyListeners();
          },
          isHappy: response.responseStatus == NetworkResponseStatus.alert,
        );
        pageStatus = PageStatus.WARNING;
        notifyListeners();
      }
    });
  }

  void storeToken(String accessToken) {
    window.localStorage["sfToken"] = accessToken;
  }

  String? getToken() {
    return window.localStorage["sfToken"];
  }

  void setLoginResponse(BuildContext context, String response) {
    Map<String, dynamic> responseBody = json.decode(
      response,
    );
    setLoggedUser(context, responseBody);
    setEmployees(context, responseBody);
    setSports(context, responseBody);
    setAvailableHours(context, responseBody);
    setStore(context, responseBody);
    setCourts(context, responseBody);
  }

  void setLoggedUser(BuildContext context, Map<String, dynamic> responseBody) {
    Provider.of<DataProvider>(context, listen: false).loggedAccessToken =
        responseBody["AccessToken"];
    Provider.of<DataProvider>(context, listen: false).loggedEmail =
        responseBody["LoggedEmail"];
    if (keepConnected) {
      storeToken(responseBody['AccessToken']);
    }
  }

  void setEmployees(BuildContext context, Map<String, dynamic> responseBody) {
    final loggedEmail =
        Provider.of<DataProvider>(context, listen: false).loggedEmail;

    for (var employee in responseBody['Store']['Employees']) {
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
        newCourt.prices.add(
          HourPrice(
            startingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere(
                    (hour) => hour.hour == courtPrices["IdAvailableHour"]),
            weekday: courtPrices["Day"],
            allowReccurrent: courtPrices["AllowRecurrent"],
            price: courtPrices["Price"],
            recurrentPrice:
                courtPrices["RecurrentPrice"] ?? courtPrices["Price"],
            endingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere(
                    (hour) => hour.hour > courtPrices["IdAvailableHour"]),
          ),
        );
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
