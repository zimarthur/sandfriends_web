import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Model/CalendarType.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/BlockedHourWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/MatchCancelWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/MatchDetailsWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/NoMatchReservedWidget.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/StoreWorkingHours.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import '../../../SharedComponents/Model/CourtDayMatch.dart';
import '../../../SharedComponents/Model/DayMatch.dart';
import '../../../SharedComponents/Model/AppMatch.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../../../SharedComponents/Model/Hour.dart';
import 'package:intl/intl.dart';

class CalendarViewModel extends ChangeNotifier {
  List<Court> courts = [];
  List<StoreWorkingDay> storeWorkingDays = [];
  List<Hour> availableHours = [];
  List<AppMatch> matches = [];

  void initCalendarViewModel(BuildContext context) {
    courts = Provider.of<DataProvider>(context, listen: false).courts;
    storeWorkingDays =
        Provider.of<DataProvider>(context, listen: false).storeWorkingDays ??
            [];
    availableHours =
        Provider.of<DataProvider>(context, listen: false).availableHours;
    matches = Provider.of<DataProvider>(context, listen: false).matches;
  }

  CalendarType _calendarView = CalendarType.Daily;
  CalendarType get calendarView => _calendarView;
  set calendarView(CalendarType newValue) {
    _calendarView = newValue;
    notifyListeners();
  }

  int _matchRecurrentView = 0;
  int get matchRecurrentView => _matchRecurrentView;
  set matchRecurrentView(int newValue) {
    _matchRecurrentView = newValue;
    notifyListeners();
  }

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  void setSelectedDay(DateTime newSelectedDay) {
    _selectedDay = newSelectedDay;
    notifyListeners();
  }

  List<DateTime> get selectedWeek {
    DateTime dayStart = _selectedDay
        .subtract(Duration(days: getBRWeekday(_selectedDay.weekday)));
    DateTime dayEnd = _selectedDay
        .add(Duration(days: 6 - getBRWeekday(_selectedDay.weekday)));
    List<DateTime> days = [];
    for (int i = 0; i <= dayEnd.difference(dayStart).inDays; i++) {
      days.add(dayStart.add(Duration(days: i)));
    }
    return days;
  }

  List<Hour> get selectedDayWorkingHours {
    StoreWorkingDay storeWorkingDay = storeWorkingDays.firstWhere(
        (storeWorkingDay) =>
            storeWorkingDay.weekday == getBRWeekday(selectedDay.weekday));
    if (!storeWorkingDay.isEnabled) {
      return [];
    }
    return availableHours
        .where((hour) =>
            hour.hour >= storeWorkingDay.startingHour!.hour &&
            hour.hour < storeWorkingDay.endingHour!.hour)
        .toList();
  }

  List<CourtDayMatch> get selectedDayMatches {
    List<CourtDayMatch> selectedDayMatches = [];
    List<DayMatch> dayMatches = [];
    int jumpToHour = -1;
    for (var court in courts) {
      dayMatches.clear();
      List<AppMatch> filteredMatches = matches
          .where((match) =>
              match.idStoreCourt == court.idStoreCourt &&
              areTheSameDate(match.date, selectedDay))
          .toList();
      for (var hour in selectedDayWorkingHours) {
        AppMatch? match;
        if (filteredMatches.any((element) => element.startingHour == hour)) {
          match = filteredMatches
              .firstWhere((element) => element.startingHour == hour);
          dayMatches.add(
            DayMatch(
              startingHour: hour,
              match: match,
            ),
          );
          jumpToHour = match.endingHour.hour;
        }
        if (hour.hour >= jumpToHour) {
          dayMatches.add(
            DayMatch(
              startingHour: hour,
            ),
          );
        }
      }
      selectedDayMatches.add(
        CourtDayMatch(
          court: court,
          dayMatches: dayMatches,
        ),
      );
    }
    return selectedDayMatches;
  }

  bool isHourPast(Hour hour) {
    DateTime fullDateTime = DateTime(selectedDay.year, selectedDay.month,
        selectedDay.day, DateFormat('HH:mm').parse("${hour.hourString}").hour);

    return fullDateTime.isBefore(DateTime.now());
  }

  void setMatchDetailsWidget(
      BuildContext context, CalendarViewModel viewModel) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      MatchDetailsWidget(viewModel: viewModel),
    );
  }

  void setBlockedHourWidget(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      BlockedHourWidget(viewModel: this),
    );
  }

  void setNoMatchReservedWidget(
      BuildContext context, CalendarViewModel viewModel) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      NoMatchReservedWidget(viewModel: viewModel),
    );
  }

  void setMatchCancelWidget(BuildContext context, CalendarViewModel viewModel) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      MatchCancelWidget(viewModel: viewModel),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).closeModal();
  }
}
