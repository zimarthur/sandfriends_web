import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Home/Model/CourtOccupation.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppMatch.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppNotification.dart';
import 'package:sandfriends_web/SharedComponents/Model/Reward.dart';
import 'package:sandfriends_web/SharedComponents/Model/StoreWorkingHours.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../../SharedComponents/Model/Court.dart';
import '../../../SharedComponents/Model/Hour.dart';

class HomeViewModel extends ChangeNotifier {
  List<AppNotification> notifications = [];
  List<Reward> rewards = [];
  List<Hour> availableHours = [];
  List<AppMatch> matches = [];
  List<Court> courts = [];
  List<CourtOccupation> courtsOccupation = [];

  late double averageOccupation;

  late Hour displayedHour;

  bool storeClosedToday = false;

  void setOccupationValues() {
    courtsOccupation.clear();
    for (var court in courts) {
      int hoursPlayed = matches
          .where((match) => match.idStoreCourt == court.idStoreCourt)
          .toList()
          .fold(
              0,
              (previousValue, element) =>
                  previousValue + element.matchDuration);
      print(court.description);
      print(hoursPlayed);
      print(availableHours.length);
      courtsOccupation.add(
        CourtOccupation(
          court: court,
          occupationPercentage: hoursPlayed / availableHours.length,
        ),
      );
    }
    averageOccupation = courtsOccupation.fold(
            0.0,
            (previousValue, element) =>
                previousValue + element.occupationPercentage) /
        courtsOccupation.length;
  }

  void initHomeScreen(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).storeWorkingDays ==
        null) {
      availableHours =
          Provider.of<DataProvider>(context, listen: false).availableHours;
    } else {
      StoreWorkingDay workingDay =
          Provider.of<DataProvider>(context, listen: false)
              .storeWorkingDays!
              .firstWhere((workingDay) =>
                  workingDay.weekday == getSFWeekday(DateTime.now().weekday));
      if (workingDay.isEnabled == false) {
        storeClosedToday = true;
      } else {
        availableHours = Provider.of<DataProvider>(context, listen: false)
            .availableHours
            .where((avHour) =>
                avHour.hour >= workingDay.startingHour!.hour &&
                avHour.hour < workingDay.endingHour!.hour)
            .toList();
      }
    }

    displayedHour =
        availableHours.firstWhere((hour) => DateTime.now().hour == hour.hour);

    setOccupationValues();
    notifications =
        Provider.of<DataProvider>(context, listen: false).notifications;
    courts = Provider.of<DataProvider>(context, listen: false).courts;
    matches = Provider.of<DataProvider>(context, listen: false)
        .matches
        .where((match) => (areInTheSameDay(match.date, DateTime.now())))
        .toList();
    rewards = Provider.of<DataProvider>(context, listen: false).rewards;
    notifyListeners();
  }

  void increaseHour() {
    displayedHour = availableHours
        .firstWhere((hour) => hour.hour == displayedHour.hour + 1);
    notifyListeners();
  }

  void decreaseHour() {
    displayedHour = availableHours
        .firstWhere((hour) => hour.hour == displayedHour.hour - 1);
    notifyListeners();
  }

  int get todaysProfit =>
      matches.fold(0, (previousValue, element) => previousValue + element.cost);

  List<AppMatch> get matchesOnDisplayesHour {
    List<AppMatch> filteredMatches = [];
    filteredMatches = matches
        .where((match) =>
            (match.startingHour.hour == displayedHour.hour) ||
            (match.startingHour.hour < displayedHour.hour &&
                match.endingHour.hour > displayedHour.hour))
        .toList();
    return filteredMatches;
  }

  bool get isLowestHour =>
      displayedHour.hour ==
      availableHours.reduce((a, b) => a.hour < b.hour ? a : b).hour;

  bool get isHighestHour =>
      displayedHour.hour ==
      availableHours.reduce((a, b) => a.hour > b.hour ? a : b).hour;

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

  bool needsOnboarding(BuildContext context) {
    if (courtsSet(context) &&
        logoSet(context) &&
        photosSet(context) &&
        storeDescriptionSet(context) &&
        financeSettingsSet(context)) {
      return false;
    } else {
      return true;
    }
  }

  bool courtsSet(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).courts.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool logoSet(BuildContext context) {
    return Provider.of<DataProvider>(context, listen: false).store!.logo !=
        null;
  }

  bool photosSet(BuildContext context) {
    return Provider.of<DataProvider>(context, listen: false)
            .store!
            .photos
            .length >=
        2;
  }

  bool storeDescriptionSet(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).store!.description !=
            null &&
        Provider.of<DataProvider>(context, listen: false)
            .store!
            .description!
            .isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool financeSettingsSet(BuildContext context) {
    return Provider.of<DataProvider>(context, listen: false)
                .store!
                .bankAccount !=
            null &&
        Provider.of<DataProvider>(context, listen: false)
            .store!
            .bankAccount!
            .isNotEmpty;
  }
}
