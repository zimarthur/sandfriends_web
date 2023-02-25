import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/CalendarScreen.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/SettingsScreen.dart';
import 'package:sandfriends_web/Dashboard/Model/DrawerItem.dart';
import 'package:sandfriends_web/Dashboard/Features/Finances/FinanceScreen.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/HomeScreen.dart';
import 'package:sandfriends_web/Dashboard/Features/Rewards/View/RewardsScreen.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';

import '../../Utils/PageStatus.dart';

class DashboardViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setModalLoading() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
  }

  void setModalSuccess() {
    pageStatus = PageStatus.SUCCESS;
    notifyListeners();
  }

  void setModalError(String title, String description) {
    modalTitle = title;
    modalDescription = description;
    modalCallback = () {
      setModalSuccess();
    };
    pageStatus = PageStatus.ERROR;
    notifyListeners();
  }

  void setModalAccomplished() {
    pageStatus = PageStatus.ACCOMPLISHED;
    notifyListeners();
  }

  void setModalForm(Widget widget) {
    modalFormWidget = widget;
    pageStatus = PageStatus.FORM;
    notifyListeners();
  }

  bool _isDrawerOpened = false;
  bool get isDrawerOpened => _isDrawerOpened;
  set isDrawerOpened(bool value) {
    _isDrawerOpened = value;
    notifyListeners();
  }

  int _indexSelectedDrawerTile = 0;
  int get indexSelectedDrawerTile => _indexSelectedDrawerTile;

  Widget _currentDashboardWidget = const RewardsScreen();
  Widget get currentDashboardWidget => _currentDashboardWidget;

  double getDashboardWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (Responsive.isMobile(context)) {
      width = width - 4 * defaultPadding;
    } else if (Responsive.isDesktop(context) || isDrawerOpened) {
      width = width - 250 - 4 * defaultPadding;
    } else {
      width = width - 80 - 4 * defaultPadding;
    }
    return width;
  }

  double getDashboardHeigth(BuildContext context) {
    return MediaQuery.of(context).size.height - 2 * defaultPadding;
  }

  final List<DrawerItem> _drawerItems = [
    DrawerItem(
      title: "Início",
      icon: r"assets/icon/home.svg",
    ),
    DrawerItem(
      title: "Calendário",
      icon: r"assets/icon/calendar.svg",
    ),
    DrawerItem(
      title: "Recompensas",
      icon: r"assets/icon/star.svg",
    ),
    DrawerItem(
      title: "Financeiro",
      icon: r"assets/icon/finance.svg",
    ),
    DrawerItem(
      title: "Minhas quadras",
      icon: r"assets/icon/court.svg",
    ),
  ];
  List<DrawerItem> get drawerItems => _drawerItems;

  void onTabClick(int index) {
    _indexSelectedDrawerTile = index;
    switch (index) {
      case 0:
        _currentDashboardWidget = const HomeScreen();
        break;
      case 1:
        _currentDashboardWidget = const CalendarScreen();
        break;
      case 2:
        _currentDashboardWidget = const RewardsScreen();
        break;
      case 3:
        _currentDashboardWidget = const FinanceScreen();
        break;
      case -1:
        _currentDashboardWidget = const SettingsScreen();
    }
    notifyListeners();
  }

  PageStatus pageStatus = PageStatus.SUCCESS;
  String modalTitle = "";
  String modalDescription = "";
  VoidCallback modalCallback = () {};
  Widget? modalFormWidget;

  int _selectedCalendarStyle = 0;
  int get selectedCalendarStyle => _selectedCalendarStyle;
  set selectedCalendarStyle(int value) {
    _selectedCalendarStyle = value;
  }

  bool isCalendarWeekly() {
    if (selectedCalendarStyle == 0) {
      return true;
    } else {
      return false;
    }
  }
}
