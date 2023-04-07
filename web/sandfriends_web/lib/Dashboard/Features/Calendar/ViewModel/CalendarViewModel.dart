import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/Model/CalendarType.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/View/Match/BlockedHourWidget.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/View/Match/MatchCancelWidget.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/View/Match/MatchDetailsWidget.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/View/Match/NoMatchReservedWidget.dart';

import '../../../ViewModel/DashboardViewModel.dart';

class CalendarViewModel extends ChangeNotifier {
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

  void setMatchDetailsWidget(
      BuildContext context, CalendarViewModel viewModel) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      MatchDetailsWidget(viewModel: viewModel),
    );
  }

  void setBlockedHourWidget(BuildContext context, CalendarViewModel viewModel) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      BlockedHourWidget(viewModel: viewModel),
    );
  }

  void setNoMatchReservedWidget(
      BuildContext context, CalendarViewModel viewModel) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      NoMatchReservedWidget(viewModel: viewModel),
    );
  }

  void setMatchCancelWidget(BuildContext context, CalendarViewModel viewModel) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      MatchCancelWidget(viewModel: viewModel),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalSuccess();
  }
}
