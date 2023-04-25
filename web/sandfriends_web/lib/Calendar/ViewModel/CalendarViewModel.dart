import 'package:flutter/material.dart';
import 'package:sandfriends_web/Calendar/Model/CalendarType.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Calendar/View/Match/BlockedHourWidget.dart';
import 'package:sandfriends_web/Calendar/View/Match/MatchCancelWidget.dart';
import 'package:sandfriends_web/Calendar/View/Match/MatchDetailsWidget.dart';
import 'package:sandfriends_web/Calendar/View/Match/NoMatchReservedWidget.dart';
import 'package:sandfriends_web/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../../SharedComponents/Model/Hour.dart';

class CalendarViewModel extends ChangeNotifier {
  void initCalendarViewModel(BuildContext context) {
    setWorkingHours(
        Provider.of<DataProvider>(context, listen: false).operationDays,
        Provider.of<DataProvider>(context, listen: false).availableHours);
  }

  CalendarType _calendarView = CalendarType.Weekly;
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
  set selectedDay(DateTime newDate) {
    _selectedDay = newDate;
    notifyListeners();
  }

  void setSelectedDay(DateTime newSelectedDay) {
    selectedDay = newSelectedDay;
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

  List<Hour> _workingHours = [];
  List<Hour> get workingHours => _workingHours;
  void setWorkingHours(List<OperationDay> hours, List<Hour> availableHours) {
    Hour minHour = hours
        .reduce((a, b) => a.startingHour.hour < b.startingHour.hour ? a : b)
        .startingHour;
    Hour maxHour = hours
        .reduce((a, b) => a.endingHour.hour > b.endingHour.hour ? a : b)
        .endingHour;
    _workingHours = availableHours
        .where(
            (hour) => (hour.hour >= minHour.hour && hour.hour <= maxHour.hour))
        .toList();
    notifyListeners();
  }

  void setMatchDetailsWidget(
      BuildContext context, CalendarViewModel viewModel) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      MatchDetailsWidget(viewModel: viewModel),
    );
  }

  void setBlockedHourWidget(BuildContext context, CalendarViewModel viewModel) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      BlockedHourWidget(viewModel: viewModel),
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
