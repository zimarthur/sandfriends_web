import 'package:flutter/material.dart';
import 'package:sandfriends_web/Model/DrawerItem.dart';
import 'package:sandfriends_web/View/Finance/finance_screen.dart';
import 'package:sandfriends_web/View/Calendar/calendar_screen.dart';
import 'package:sandfriends_web/View/Calendar/calendar_week.dart';
import 'package:sandfriends_web/View/Components/drawer_list_tile.dart';
import 'package:sandfriends_web/View/Home/home_screen.dart';
import 'package:sandfriends_web/View/Rewards/rewards_screen.dart';
import 'package:sandfriends_web/responsive.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  bool _isDrawerOpened = false;
  bool get isDrawerOpened => _isDrawerOpened;
  set isDrawerOpened(bool value) {
    _isDrawerOpened = value;
    notifyListeners();
  }

  int _indexSelectedDrawerTile = 0;
  int get indexSelectedDrawerTile => _indexSelectedDrawerTile;

  Widget _currentDashboardWidget = HomeScreen();
  Widget get currentDashboardWidget => _currentDashboardWidget;

  double getDashboardWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (Responsive.isDesktop(context)) {
      width = width * 5 / 6;
    }
    return width;
  }

  double getDashboardHeigth(BuildContext context) {
    return MediaQuery.of(context).size.height - 60; //header = 60
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
        _currentDashboardWidget = HomeScreen();
        break;
      case 1:
        _currentDashboardWidget = CalendarScreen();
        break;
      case 2:
        _currentDashboardWidget = RewardsScreen();
        break;
      case 3:
        _currentDashboardWidget = FinanceScreen();
        break;
    }
    notifyListeners();
  }

  int _selectedCalendarStyle = 0;
  int get selectedCalendarStyle => _selectedCalendarStyle;
  set selectedCalendarStyle(int value) {
    _selectedCalendarStyle = value;
  }

  bool isCalendarWeekly() {
    if (selectedCalendarStyle == 0)
      return true;
    else
      return false;
  }
}
