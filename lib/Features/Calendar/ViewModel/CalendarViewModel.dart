import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Model/CalendarType.dart';
import 'package:sandfriends_web/Features/Calendar/Model/PeriodType.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Calendar/Model/CalendarWeeklyDayMatch.dart';
import 'package:sandfriends_web/Features/Calendar/Repository/CalendarRepoImp.dart';
import 'package:sandfriends_web/Features/Calendar/View/Modal/Match/CourtsAvailabilityWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Modal/Match/BlockHourWidget.dart';
import 'package:sandfriends_web/Features/Calendar/View/Modal/Match/MatchDetailsWidget.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppRecurrentMatch.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/StoreWorkingHours.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import '../../../SharedComponents/Model/AppMatch.dart';
import '../../../SharedComponents/Model/TabItem.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../../../SharedComponents/Model/Hour.dart';
import 'package:intl/intl.dart';

import '../Model/CalendarDailyCourtMatch.dart';
import '../Model/DayMatch.dart';
import '../View/Modal/Match/MatchCancelWidget.dart';
import '../View/Modal/RecurrentMatch/RecurrentBlockHourWidget.dart';
import '../View/Modal/RecurrentMatch/RecurrentCourtsAvailabilityWidget.dart';
import '../View/Modal/RecurrentMatch/RecurrentMatchCancelWidget.dart';
import '../View/Modal/RecurrentMatch/RecurrentMatchDetailsWidget.dart';

class CalendarViewModel extends ChangeNotifier {
  final calendarRepo = CalendarRepoImp();

  List<Court> courts = [];
  List<StoreWorkingDay> storeWorkingDays = [];
  List<Hour> availableHours = [];
  List<AppMatch> matches = [];
  List<AppRecurrentMatch> recurrentMatches = [];
  late DateTime matchesStartDate;
  late DateTime matchesEndDate;

  TextEditingController blockHourReasonController = TextEditingController();
  TextEditingController cancelMatchReasonController = TextEditingController();
  TextEditingController cancelRecurrentMatchReasonController =
      TextEditingController();

  void initCalendarViewModel(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).isDrawerExpanded = false;
    courts = Provider.of<DataProvider>(context, listen: false).courts;
    storeWorkingDays =
        Provider.of<DataProvider>(context, listen: false).storeWorkingDays !=
                null
            ? Provider.of<DataProvider>(context, listen: false)
                .storeWorkingDays!
                .map((workingDay) => StoreWorkingDay.copyFrom(workingDay))
                .toList()
            : [];

    availableHours =
        Provider.of<DataProvider>(context, listen: false).availableHours;
    matches = Provider.of<DataProvider>(context, listen: false)
        .matches
        .map((match) => AppMatch.copyWith(match))
        .toList();
    recurrentMatches = Provider.of<DataProvider>(context, listen: false)
        .recurrentMatches
        .map((recMatch) => AppRecurrentMatch.copyWith(recMatch))
        .toList();
    matchesStartDate =
        Provider.of<DataProvider>(context, listen: false).matchesStartDate;
    matchesEndDate =
        Provider.of<DataProvider>(context, listen: false).matchesEndDate;
    initTabs();
  }

  PeriodType _periodType = PeriodType.Daily;
  PeriodType get periodType => _periodType;
  set periodType(PeriodType newValue) {
    _periodType = newValue;
    notifyListeners();
  }

  CalendarType _calendarType = CalendarType.Match;
  CalendarType get calendarType => _calendarType;
  void setCalendarType(CalendarType newCalendarType) {
    _calendarType = newCalendarType;
    notifyListeners();
  }

  void initTabs() {
    tabItems = [
      SFTabItem(
        name: "Partidas",
        onTap: (newTab) {
          setCalendarType(CalendarType.Match);
          setSelectedTab(newTab);
        },
        displayWidget: Container(),
      ),
      SFTabItem(
        name: "Mensalistas",
        onTap: (newTab) {
          setCalendarType(CalendarType.RecurrentMatch);
          setSelectedWeekday(getSFWeekday(selectedDay.weekday));
          setSelectedTab(newTab);
        },
        displayWidget: Container(),
      ),
    ];
    _selectedTab = tabItems.first;
    notifyListeners();
  }

  List<SFTabItem> tabItems = [];

  SFTabItem _selectedTab =
      SFTabItem(name: "", displayWidget: Container(), onTap: (a) {});
  SFTabItem get selectedTab => _selectedTab;
  void setSelectedTab(SFTabItem newTab) {
    _selectedTab = newTab;
    notifyListeners();
  }

  int _selectedWeekday = 0;
  int get selectedWeekday => _selectedWeekday;
  void setSelectedWeekday(int newValue) {
    _selectedWeekday = newValue;
    notifyListeners();
  }

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  void setSelectedDay(BuildContext context, DateTime newSelectedDay) {
    if (newSelectedDay.isAfter(matchesEndDate) ||
        newSelectedDay.isBefore(matchesStartDate)) {
      Provider.of<MenuProvider>(context, listen: false).setModalLoading();
      calendarRepo
          .updateMatchesList(
              Provider.of<DataProvider>(context, listen: false)
                  .loggedAccessToken,
              newSelectedDay)
          .then((response) {
        if (response.responseStatus == NetworkResponseStatus.success) {
          Map<String, dynamic> responseBody = json.decode(
            response.responseBody!,
          );
          matches.clear();
          for (var match in responseBody['Matches']) {
            matches.add(
              AppMatch.fromJson(
                match,
                Provider.of<DataProvider>(context, listen: false)
                    .availableHours,
                Provider.of<DataProvider>(context, listen: false)
                    .availableSports,
              ),
            );
          }
          matchesStartDate =
              DateFormat("dd/MM/yyyy").parse(responseBody['MatchesStartDate']);
          matchesEndDate =
              DateFormat("dd/MM/yyyy").parse(responseBody['MatchesEndDate']);
          Provider.of<MenuProvider>(context, listen: false).closeModal();
          _selectedDay = newSelectedDay;
          notifyListeners();
        } else if (response.responseStatus ==
            NetworkResponseStatus.expiredToken) {
          Provider.of<MenuProvider>(context, listen: false).logout(context);
        } else {
          Provider.of<MenuProvider>(context, listen: false)
              .setMessageModalFromResponse(response);
        }
      });
    } else {
      _selectedDay = newSelectedDay;
      notifyListeners();
    }
  }

  List<DateTime> get selectedWeek {
    DateTime dayStart = _selectedDay
        .subtract(Duration(days: getSFWeekday(_selectedDay.weekday)));
    DateTime dayEnd = _selectedDay
        .add(Duration(days: 6 - getSFWeekday(_selectedDay.weekday)));
    List<DateTime> days = [];
    for (int i = 0; i <= dayEnd.difference(dayStart).inDays; i++) {
      days.add(dayStart.add(Duration(days: i)));
    }
    return days;
  }

  List<Hour> workingHoursFromDay(int weekDay) {
    StoreWorkingDay storeWorkingDay = storeWorkingDays
        .firstWhere((storeWorkingDay) => storeWorkingDay.weekday == weekDay);
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
    if (calendarType == CalendarType.Match) {
      return workingHoursFromDay(getSFWeekday(selectedDay.weekday));
    } else {
      return workingHoursFromDay(selectedWeekday);
    }
  }

  String get calendarDayTitle {
    if (calendarType == CalendarType.Match) {
      return "dia\n${DateFormat('dd/MM').format(selectedDay)}";
    } else {
      return weekdayRecurrent[selectedWeekday];
    }
  }

  List<CalendarDailyCourtMatch> get selectedDayMatches {
    List<CalendarDailyCourtMatch> selectedDayMatches = [];
    List<DayMatch> dayMatches = [];
    int jumpToHour = -1;
    if (calendarType == CalendarType.Match) {
      for (var court in courts) {
        dayMatches.clear();
        jumpToHour = -1;
        List<AppMatch> filteredMatches = matches
            .where((match) =>
                match.idStoreCourt == court.idStoreCourt &&
                areInTheSameDay(match.date, selectedDay))
            .toList();
        for (var hour in selectedDayWorkingHours) {
          AppMatch? match;
          AppRecurrentMatch? recMatch;
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
          } else if (recurrentMatches.any((recMatch) =>
              recMatch.weekday == getSFWeekday(selectedDay.weekday) &&
              recMatch.startingHour == hour &&
              recMatch.idStoreCourt == court.idStoreCourt)) {
            recMatch = recurrentMatches.firstWhere((recMatch) =>
                recMatch.weekday == getSFWeekday(selectedDay.weekday) &&
                recMatch.startingHour == hour &&
                recMatch.idStoreCourt == court.idStoreCourt);
            dayMatches.add(
              DayMatch(
                startingHour: hour,
                recurrentMatch: AppRecurrentMatch.copyWith(recMatch),
              ),
            );
            jumpToHour = recMatch.endingHour.hour;
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
    } else {
      for (var court in courts) {
        dayMatches.clear();
        jumpToHour = -1;
        List<AppRecurrentMatch> filteredRecurrentMatches = recurrentMatches
            .where((recMatch) =>
                recMatch.idStoreCourt == court.idStoreCourt &&
                recMatch.weekday == selectedWeekday)
            .toList();
        for (var hour in selectedDayWorkingHours) {
          AppRecurrentMatch? recMatch;
          if (filteredRecurrentMatches
              .any((element) => element.startingHour == hour)) {
            recMatch = filteredRecurrentMatches
                .firstWhere((element) => element.startingHour == hour);
            dayMatches.add(
              DayMatch(
                startingHour: hour,
                recurrentMatch: AppRecurrentMatch.copyWith(recMatch),
              ),
            );
            jumpToHour = recMatch.endingHour.hour;
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
    }

    return selectedDayMatches;
  }

  List<Hour> get minMaxHourRangeWeek {
    List<StoreWorkingDay> availableStoreWorkingDays = [];
    for (var storeDay in storeWorkingDays) {
      if (storeDay.isEnabled) {
        availableStoreWorkingDays.add(StoreWorkingDay.copyFrom(storeDay));
      }
    }

    Hour minHour = availableStoreWorkingDays
        .reduce((a, b) => a.startingHour!.hour <= b.startingHour!.hour ? a : b)
        .startingHour!;
    Hour maxHour = availableStoreWorkingDays
        .reduce((a, b) => a.endingHour!.hour >= b.endingHour!.hour ? a : b)
        .endingHour!;
    return availableHours
        .where((hour) => hour.hour >= minHour.hour && hour.hour < maxHour.hour)
        .toList();
  }

  List<CalendarWeeklyDayMatch> get selectedWeekMatches {
    List<CalendarWeeklyDayMatch> selectedWeekMatches = [];
    List<DayMatch> dayMatches = [];

    if (calendarType == CalendarType.Match) {
      for (var day in selectedWeek) {
        dayMatches.clear();

        for (var hour in minMaxHourRangeWeek) {
          List<AppMatch> filteredMatches = [];
          List<AppRecurrentMatch> filteredRecurrentMatches = [];

          for (var match in matches) {
            if (areInTheSameDay(match.date, day) &&
                hour.hour >= match.startingHour.hour &&
                hour.hour < match.endingHour.hour) {
              filteredMatches.add(AppMatch.copyWith(match));
            }
          }
          for (var recurrentMatch in recurrentMatches) {
            if (getSFWeekday(day.weekday) == recurrentMatch.weekday &&
                hour.hour >= recurrentMatch.startingHour.hour &&
                hour.hour < recurrentMatch.endingHour.hour) {
              filteredRecurrentMatches
                  .add(AppRecurrentMatch.copyWith(recurrentMatch));
            }
          }

          dayMatches.add(
            DayMatch(
              startingHour: hour,
              matches: filteredMatches,
              recurrentMatches: filteredRecurrentMatches,
              operationHour: storeWorkingDays
                      .firstWhere((workingDay) =>
                          workingDay.weekday == getSFWeekday(day.weekday))
                      .isEnabled &&
                  storeWorkingDays
                          .firstWhere((workingDay) =>
                              workingDay.weekday == getSFWeekday(day.weekday))
                          .startingHour!
                          .hour <=
                      hour.hour &&
                  storeWorkingDays
                          .firstWhere((workingDay) =>
                              workingDay.weekday == getSFWeekday(day.weekday))
                          .endingHour!
                          .hour >
                      hour.hour,
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
    } else {
      for (var day in selectedWeek) {
        dayMatches.clear();

        for (var hour in minMaxHourRangeWeek) {
          List<AppRecurrentMatch> filteredRecurrentMatches = [];

          for (var recurrentMatch in recurrentMatches) {
            if (recurrentMatch.weekday == getSFWeekday(day.weekday) &&
                hour.hour >= recurrentMatch.startingHour.hour &&
                hour.hour < recurrentMatch.endingHour.hour) {
              filteredRecurrentMatches
                  .add(AppRecurrentMatch.copyWith(recurrentMatch));
            }
          }

          dayMatches.add(
            DayMatch(
              startingHour: hour,
              recurrentMatches: filteredRecurrentMatches,
              operationHour: storeWorkingDays
                      .firstWhere((workingDay) =>
                          workingDay.weekday == getSFWeekday(day.weekday))
                      .isEnabled &&
                  storeWorkingDays
                          .firstWhere((workingDay) =>
                              workingDay.weekday == getSFWeekday(day.weekday))
                          .startingHour!
                          .hour <=
                      hour.hour &&
                  storeWorkingDays
                          .firstWhere((workingDay) =>
                              workingDay.weekday == getSFWeekday(day.weekday))
                          .endingHour!
                          .hour >
                      hour.hour,
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
    }

    return selectedWeekMatches;
  }

  void blockUnblockHour(
    BuildContext context,
    int idStoreCourt,
    DateTime date,
    Hour hour,
    bool block,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    calendarRepo
        .blockUnblockHour(
      Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
      idStoreCourt,
      date,
      hour.hour,
      block,
      blockHourReasonController.text,
    )
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        setMatchesFromResponse(context, response.responseBody!);
        blockHourReasonController.text = "";
        Provider.of<MenuProvider>(context, listen: false).closeModal();
      } else if (response.responseStatus ==
          NetworkResponseStatus.expiredToken) {
        Provider.of<MenuProvider>(context, listen: false).logout(context);
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(response);
      }
    });
  }

  void recurrentBlockUnblockHour(
    BuildContext context,
    int idStoreCourt,
    Hour hour,
    bool block,
    String name,
    int idSport,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    calendarRepo
        .recurrentBlockUnblockHour(
            Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
            idStoreCourt,
            selectedWeekday,
            hour.hour,
            block,
            name,
            idSport)
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        setRecurrentMatchesFromResponse(context, response.responseBody!);
        Provider.of<MenuProvider>(context, listen: false).closeModal();
      } else if (response.responseStatus ==
          NetworkResponseStatus.expiredToken) {
        Provider.of<MenuProvider>(context, listen: false).logout(context);
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(response);
      }
    });
  }

  void cancelMatch(
    BuildContext context,
    int idMatch,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    calendarRepo
        .cancelMatch(
      Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
      idMatch,
      cancelMatchReasonController.text,
    )
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        setMatchesFromResponse(context, response.responseBody!);

        cancelMatchReasonController.text = "";
        Provider.of<MenuProvider>(context, listen: false).closeModal();
      } else if (response.responseStatus ==
          NetworkResponseStatus.expiredToken) {
        Provider.of<MenuProvider>(context, listen: false).logout(context);
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(response);
      }
    });
  }

  void cancelRecurrentMatch(
    BuildContext context,
    int idRecurrentMatch,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    calendarRepo
        .cancelRecurrentMatch(
      Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
      idRecurrentMatch,
      cancelRecurrentMatchReasonController.text,
    )
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        setRecurrentMatchesFromResponse(context, response.responseBody!);

        cancelRecurrentMatchReasonController.text = "";
        Provider.of<MenuProvider>(context, listen: false).closeModal();
      } else if (response.responseStatus ==
          NetworkResponseStatus.expiredToken) {
        Provider.of<MenuProvider>(context, listen: false).logout(context);
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(response);
      }
    });
  }

  void setMatchesFromResponse(
    BuildContext context,
    String response,
  ) {
    Map<String, dynamic> responseBody = json.decode(
      response,
    );
    if (matchesStartDate ==
        Provider.of<DataProvider>(context, listen: false).matchesStartDate) {
      Provider.of<DataProvider>(context, listen: false)
          .setMatches(responseBody);
    }
    matches.clear();
    for (var match in responseBody['Matches']) {
      matches.add(
        AppMatch.fromJson(
          match,
          Provider.of<DataProvider>(context, listen: false).availableHours,
          Provider.of<DataProvider>(context, listen: false).availableSports,
        ),
      );
    }
  }

  void setRecurrentMatchesFromResponse(
    BuildContext context,
    String response,
  ) {
    Map<String, dynamic> responseBody = json.decode(
      response,
    );

    Provider.of<DataProvider>(context, listen: false)
        .setRecurrentMatches(responseBody);

    recurrentMatches.clear();
    for (var recurrentMatch in responseBody['RecurrentMatches']) {
      recurrentMatches.add(
        AppRecurrentMatch.fromJson(
          recurrentMatch,
          Provider.of<DataProvider>(context, listen: false).availableHours,
          Provider.of<DataProvider>(context, listen: false).availableSports,
        ),
      );
    }
  }

  void setBlockHourWidget(BuildContext context, Court court, Hour hour) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      BlockHourWidget(
        court: court,
        day: selectedDay,
        hour: hour,
        onBlock: () => blockUnblockHour(
          context,
          court.idStoreCourt!,
          selectedDay,
          hour,
          true,
        ),
        onReturn: () => returnMainView(context),
        controller: blockHourReasonController,
      ),
    );
  }

  void setRecurrentBlockHourWidget(
      BuildContext context, Court court, Hour hour) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      RecurrentBlockHourWidget(
        court: court,
        day: selectedDay,
        sports:
            Provider.of<DataProvider>(context, listen: false).availableSports,
        hour: hour,
        onBlock: (name, idSport) => recurrentBlockUnblockHour(
          context,
          court.idStoreCourt!,
          hour,
          true,
          name,
          idSport,
        ),
        onReturn: () => returnMainView(context),
      ),
    );
  }

  void setMatchDetailsWidget(BuildContext context, AppMatch match) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      MatchDetailsWidget(
        match: match,
        onReturn: () => returnMainView(context),
        onCancel: () => setMatchCancelWidget(
          context,
          match,
        ),
      ),
    );
  }

  void setRecurrentMatchDetailsWidget(
      BuildContext context, AppRecurrentMatch recurrentMatch) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      RecurrentMatchDetailsWidget(
        recurrentMatch: recurrentMatch,
        onReturn: () => returnMainView(context),
        onCancel: () => setRecurrentMatchCancelWidget(
          context,
          recurrentMatch,
        ),
      ),
    );
  }

  void setCourtsAvailabilityWidget(
    BuildContext context,
    DateTime day,
    Hour hour,
    List<AppMatch> matches,
    List<AppRecurrentMatch> recurrentMatches,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      CourtsAvailabilityWidget(
        viewModel: this,
        day: day,
        hour: hour,
        matches: matches,
        recurrentMatches: recurrentMatches,
      ),
    );
  }

  void setRecurrentCourtsAvailabilityWidget(
    BuildContext context,
    String day,
    Hour hour,
    List<AppRecurrentMatch> recurrentMatches,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      RecurrentCourtsAvailabilityWidget(
        viewModel: this,
        day: day,
        hour: hour,
        recurrentMatches: recurrentMatches,
      ),
    );
  }

  void setMatchCancelWidget(
    BuildContext context,
    AppMatch match,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      MatchCancelWidget(
        match: match,
        controller: cancelMatchReasonController,
        onReturn: () => returnMainView(context),
        onCancel: () => cancelMatch(context, match.idMatch),
      ),
    );
  }

  void setRecurrentMatchCancelWidget(
    BuildContext context,
    AppRecurrentMatch recurrentMatch,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      RecurrentMatchCancelWidget(
        recurrentMatch: recurrentMatch,
        controller: cancelRecurrentMatchReasonController,
        onReturn: () => returnMainView(context),
        onCancel: () =>
            cancelRecurrentMatch(context, recurrentMatch.idRecurrentMatch),
      ),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).closeModal();
  }
}
