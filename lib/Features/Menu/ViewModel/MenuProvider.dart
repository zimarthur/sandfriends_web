import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/Features/Calendar/View/CalendarScreen.dart';
import 'package:sandfriends_web/Features/Help/View/HelpScreen.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Features/MyCourts/View/MyCourtsScreen.dart';
import 'package:sandfriends_web/Features/Settings/View/SettingsScreen.dart';
import 'package:sandfriends_web/Features/Menu/Model/DrawerItem.dart';
import 'package:sandfriends_web/Features/Finances/View/FinancesScreen.dart';
import 'package:sandfriends_web/Features/Home/View/HomeScreen.dart';
import 'package:sandfriends_web/Features/Rewards/View/RewardsScreen.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:sandfriends_web/SharedComponents/View/SFMessageModal.dart';
import 'package:sandfriends_web/SharedComponents/View/SFModalConfirmation.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';
import 'package:provider/provider.dart';
import '../../../Utils/LocalStorage.dart';
import '../../../Utils/PageStatus.dart';

class MenuProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final loginRepo = LoginRepoImp();

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  PageStatus pageStatus = PageStatus.OK;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
    onTap: () {},
    isHappy: true,
  );

  Widget? modalFormWidget;

  void validateAuthentication(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).store == null) {
      pageStatus = PageStatus.LOADING;
      notifyListeners();
      String? storedToken = getToken();
      if (storedToken != null) {
        loginRepo.validateToken(storedToken).then((response) {
          if (response.responseStatus == NetworkResponseStatus.success) {
            Provider.of<DataProvider>(context, listen: false)
                .setLoginResponse(response.responseBody!, true);
            Navigator.pushNamed(context, '/home');
          } else {
            pageStatus = PageStatus.OK;
            notifyListeners();
          }
        });
      }
    }
  }

  void setModalLoading() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
  }

  void closeModal() {
    pageStatus = PageStatus.OK;
    notifyListeners();
  }

  void setMessageModal(String title, String? description, bool isHappy) {
    messageModal = SFMessageModal(
      title: title,
      description: description,
      onTap: () {
        closeModal();
      },
      isHappy: isHappy,
    );
    pageStatus = PageStatus.WARNING;
    notifyListeners();
  }

  void setMessageModalFromResponse(NetworkResponse response) {
    setMessageModal(
      response.responseTitle!,
      response.responseDescription,
      response.responseStatus == NetworkResponseStatus.alert,
    );
  }

  void setModalForm(Widget widget) {
    modalFormWidget = widget;
    pageStatus = PageStatus.FORM;
    notifyListeners();
  }

  void setModalConfirmation(String title, String description,
      VoidCallback onContinue, VoidCallback onReturn) {
    modalFormWidget = SFModalConfirmation(
      title: title,
      description: description,
      onContinue: onContinue,
      onReturn: onReturn,
    );
    pageStatus = PageStatus.FORM;
    notifyListeners();
  }

  bool _isDrawerOpened = false;
  bool get isDrawerOpened => _isDrawerOpened;
  set isDrawerOpened(bool value) {
    _isDrawerOpened = value;
    notifyListeners();
  }

  bool _isDrawerExpanded = true;
  bool get isDrawerExpanded => _isDrawerExpanded;
  set isDrawerExpanded(bool value) {
    _isDrawerExpanded = value;
    notifyListeners();
  }

  int _indexSelectedDrawerTile = 0;
  int get indexSelectedDrawerTile => _indexSelectedDrawerTile;

  Widget _currentMenuWidget = const HomeScreen();
  Widget get currentMenuWidget => _currentMenuWidget;

  double getScreenWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (Responsive.isMobile(context)) {
      width = width - 4 * defaultPadding;
    } else if ((Responsive.isDesktop(context) && isDrawerExpanded) ||
        isDrawerExpanded) {
      width = width - 250 - 4 * defaultPadding;
    } else {
      width = width - 82 - 4 * defaultPadding;
    }
    return width;
  }

  double getScreenHeight(BuildContext context) {
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
        _currentMenuWidget = const HomeScreen();
        break;
      case 1:
        _currentMenuWidget = const CalendarScreen();
        break;
      case 2:
        _currentMenuWidget = const RewardsScreen();
        break;
      case 3:
        _currentMenuWidget = const FinanceScreen();
        break;
      case 4:
        _currentMenuWidget = MyCourtsScreen();
        break;
      case -1:
        _currentMenuWidget = SettingsScreen();
        break;
      case -2:
        _currentMenuWidget = const HelpScreen();
        break;
    }
    notifyListeners();
  }

  void quickLinkBrand() {
    _indexSelectedDrawerTile = -1;
    _currentMenuWidget = SettingsScreen(
      initForm: 1,
    );
    notifyListeners();
  }

  void quickLinkFinanceSettings() {
    _indexSelectedDrawerTile = -1;
    _currentMenuWidget = SettingsScreen(
      initForm: 2,
    );
    notifyListeners();
  }

  void quickLinkWorkingHours() {
    _indexSelectedDrawerTile = 4;
    _currentMenuWidget = MyCourtsScreen(
      showWorkingHours: true,
    );
    notifyListeners();
  }
}
