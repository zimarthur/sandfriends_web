import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Model/CalendarType.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Calendar/Model/CalendarWeeklyDayMatch.dart';
import 'package:sandfriends_web/Features/Calendar/View/Calendar/Day/CourtsAvailabilityWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/BlockHourWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/MatchCancelWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/MatchDetailsWidget.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/StoreWorkingHours.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import '../../../SharedComponents/Model/AppMatch.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../../../SharedComponents/Model/Hour.dart';
import 'package:intl/intl.dart';

import '../Model/CalendarDailyCourtMatch.dart';
import '../Model/DayMatch.dart';

class CalendarViewModel extends ChangeNotifier {
  List<Court> courts = [];
  List<StoreWorkingDay> storeWorkingDays = [];
  List<Hour> availableHours = [];
  List<AppMatch> matches = [];

  TextEditingController blockHourReasonController = TextEditingController();

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

  List<Hour> workingHoursFromDay(DateTime day) {
    StoreWorkingDay storeWorkingDay = storeWorkingDays.firstWhere(
        (storeWorkingDay) =>
            storeWorkingDay.weekday == getBRWeekday(day.weekday));
    if (!storeWorkingDay.isEnabled) {
      return [];
    }
    return availableHours
        .where((hour) =>
            hour.hour >= storeWorkingDay.startingHour!.hour &&
            hour.hour < storeWorkingDay.endingHour!.hour)
        .toList();
  }

  List<Hour> get selectedDayWorkingHours {
    return workingHoursFromDay(selectedDay);
  }

  List<CalendarDailyCourtMatch> get selectedDayMatches {
    List<CalendarDailyCourtMatch> selectedDayMatches = [];
    List<DayMatch> dayMatches = [];
    int jumpToHour = -1;
    for (var court in courts) {
      dayMatches.clear();
      jumpToHour = -1;
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
              match: AppMatch.copyWith(match),
            ),
          );
          jumpToHour = match.endingHour.hour;
        } else if (hour.hour >= jumpToHour) {
          dayMatches.add(
            DayMatch(
              startingHour: hour,
            ),
          );
        }
      }
      selectedDayMatches.add(
        CalendarDailyCourtMatch(
          court: court,
          dayMatches: dayMatches
              .map((dayMatch) => DayMatch.copyWith(dayMatch))
              .toList(),
        ),
      );
    }

    return selectedDayMatches;
  }

  List<CalendarWeeklyDayMatch> get selectedWeekMatches {
    List<CalendarWeeklyDayMatch> selectedWeekMatches = [];
    List<DayMatch> dayMatches = [];

    for (var day in selectedWeek) {
      dayMatches.clear();
      for (var hour in workingHoursFromDay(day)) {
        List<AppMatch> filteredMatches = [];

        for (var match in matches) {
          if (areTheSameDate(match.date, day) &&
              hour.hour >= match.startingHour.hour &&
              hour.hour < match.endingHour.hour) {
            filteredMatches.add(AppMatch.copyWith(match));
          }
        }

        dayMatches.add(
          DayMatch(
            startingHour: hour,
            matches: filteredMatches,
          ),
        );
      }
      selectedWeekMatches.add(
        CalendarWeeklyDayMatch(
          date: day,
          dayMatches: dayMatches
              .map((dayMatch) => DayMatch.copyWith(dayMatch))
              .toList(),
        ),
      );
    }
    return selectedWeekMatches;
  }

  void setBlockHourWidget(BuildContext context, int idStoreCourt, Hour hour) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      BlockHourWidget(
        viewModel: this,
        idStoreCourt: idStoreCourt,
        day: selectedDay,
        hour: hour,
      ),
    );
  }

  void setMatchDetailsWidget(BuildContext context, AppMatch match) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      MatchDetailsWidget(viewModel: this, match: match),
    );
  }

  void setCourtsAvailabilityWidget(
    BuildContext context,
    DateTime day,
    Hour hour,
    List<AppMatch> matches,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      CourtsAvailabilityWidget(
        viewModel: this,
        day: day,
        hour: hour,
        matches: matches,
      ),
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

  void blockHour(
      BuildContext context, int idStoreCourt, DateTime day, Hour hour) {}
}
