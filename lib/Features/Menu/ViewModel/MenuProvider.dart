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

  bool _isEmployeeAdmin = false;
  bool get isEmployeeAdmin => _isEmployeeAdmin;
  void setIsEmployeeAdmin(bool newValue) {
    _isEmployeeAdmin = newValue;
    notifyListeners();
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
            setIsEmployeeAdmin(Provider.of<DataProvider>(context, listen: false)
                .isLoggedEmployeeAdmin());
            setSelectedDrawerItem(mainDrawer.first);
            String? lastPage = getLastPage();
            if (lastPage != null &&
                permissionsDrawerItems
                    .any((drawer) => drawer.title == lastPage)) {
              onTabClick(
                  permissionsDrawerItems
                      .firstWhere((drawer) => drawer.title == lastPage),
                  context);
            } else {
              Navigator.pushNamed(context, '/home');
            }
          } else {
            Navigator.pushNamed(context, "/login");
          }
          pageStatus = PageStatus.OK;
          notifyListeners();
        });
      } else {
        Navigator.pushNamed(context, "/login");
      }
    } else {
      setIsEmployeeAdmin(Provider.of<DataProvider>(context, listen: false)
          .isLoggedEmployeeAdmin());
      setSelectedDrawerItem(mainDrawer.first);
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

  String _hoveredDrawerTitle = "";
  String get hoveredDrawerTitle => _hoveredDrawerTitle;
  void setHoveredDrawerTitle(String newTitle) {
    _hoveredDrawerTitle = newTitle;
    notifyListeners();
  }

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
      requiresAdmin: false,
      widget: HomeScreen(),
      mainDrawer: true,
    ),
    DrawerItem(
      title: "Calendário",
      icon: r"assets/icon/calendar.svg",
      requiresAdmin: false,
      widget: CalendarScreen(),
      mainDrawer: true,
    ),
    DrawerItem(
      title: "Recompensas",
      icon: r"assets/icon/star.svg",
      requiresAdmin: false,
      widget: RewardsScreen(),
      mainDrawer: true,
    ),
    DrawerItem(
      title: "Financeiro",
      icon: r"assets/icon/finance.svg",
      requiresAdmin: true,
      widget: FinanceScreen(),
      mainDrawer: true,
    ),
    DrawerItem(
      title: "Minhas quadras",
      icon: r"assets/icon/court.svg",
      requiresAdmin: false,
      widget: MyCourtsScreen(),
      mainDrawer: true,
    ),
    DrawerItem(
      title: "Meu perfil",
      icon: r"assets/icon/profile.svg",
      requiresAdmin: false,
      widget: SettingsScreen(),
      mainDrawer: false,
    ),
    DrawerItem(
      title: "Ajuda",
      icon: r"assets/icon/help.svg",
      requiresAdmin: false,
      widget: HelpScreen(),
      mainDrawer: false,
    ),
    DrawerItem(
      title: "Sair",
      icon: r"assets/icon/logout.svg",
      requiresAdmin: false,
      widget: Container(),
      mainDrawer: false,
      color: Colors.red,
      logout: true,
    ),
  ];
  List<DrawerItem> get permissionsDrawerItems {
    if (isEmployeeAdmin) {
      return _drawerItems;
    } else {
      return _drawerItems
          .where((drawer) => drawer.requiresAdmin == false)
          .toList();
    }
  }

  List<DrawerItem> get mainDrawer {
    return permissionsDrawerItems.where((drawer) => drawer.mainDrawer).toList();
  }

  List<DrawerItem> get secondaryDrawer {
    return permissionsDrawerItems
        .where((drawer) => !drawer.mainDrawer)
        .toList();
  }

  DrawerItem _selectedDrawerItem = DrawerItem(
      title: "title",
      icon: "",
      requiresAdmin: false,
      mainDrawer: false,
      widget: Container());
  DrawerItem get selectedDrawerItem => _selectedDrawerItem;
  void setSelectedDrawerItem(DrawerItem drawer) {
    _selectedDrawerItem = drawer;
    notifyListeners();
  }

  void onTabClick(DrawerItem drawerItem, BuildContext context) {
    storeLastPage(drawerItem.title);
    setSelectedDrawerItem(drawerItem);
    if (drawerItem.logout) {
      logout(context);
    }

    notifyListeners();
  }

  void quickLinkHome(BuildContext context) {
    onTabClick(
      mainDrawer.firstWhere((element) => element.title == "Início"),
      context,
    );
  }

  void quickLinkBrand(BuildContext context) {
    onTabClick(
      DrawerItem(
        title: "Meu perfil",
        icon: r"assets/icon/profile.svg",
        requiresAdmin: false,
        widget: SettingsScreen(
          initForm: "Marca",
        ),
        mainDrawer: false,
      ),
      context,
    );
  }

  void quickLinkFinanceSettings(BuildContext context) {
    onTabClick(
      DrawerItem(
        title: "",
        icon: r"assets/icon/profile.svg",
        requiresAdmin: false,
        widget: SettingsScreen(
          initForm: "Dados financeiros",
        ),
        mainDrawer: false,
      ),
      context,
    );
  }

  void quickLinkWorkingHours(BuildContext context) {
    onTabClick(
      DrawerItem(
        title: "Minhas quadras",
        icon: r"assets/icon/court.svg",
        requiresAdmin: false,
        widget: MyCourtsScreen(
          quickLinkWorkingHours: true,
        ),
        mainDrawer: true,
      ),
      context,
    );
  }

  void quickLinkMyCourts(BuildContext context) {
    onTabClick(
      mainDrawer.firstWhere((element) => element.title == "Minhas quadras"),
      context,
    );
  }

  void logout(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false).clearDataProvider();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (Route<dynamic> route) => false,
    );
  }
}
