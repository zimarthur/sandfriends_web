import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/Features/Coupons/View/Web/CouponsScreenWeb.dart';
import 'package:sandfriends_web/Features/Help/View/HelpScreen.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Features/Menu/Model/DrawerItem.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:sandfriends_web/SharedComponents/View/SFMessageModal.dart';
import 'package:sandfriends_web/SharedComponents/View/SFModalConfirmation.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';
import 'package:provider/provider.dart';
import '../../../Utils/LocalStorageWeb.dart'
    if (dart.library.io) '../../../Utils/LocalStorageMobile.dart';
import '../../../Utils/PageStatus.dart';
import 'package:collection/collection.dart';

import '../../Coupons/View/Mobile/CouponsScreenMobile.dart';
import '../../Home/View/Web/HomeScreenWeb.dart';
import '../../Home/View/Mobile/HomeScreenMobile.dart';
import '../../MyCourts/View/Web/MyCourtsScreenWeb.dart';
import '../../MyCourts/View/Mobile/MyCourtsScreenMobile.dart';
import '../../Finances/View/Web/FinancesScreenWeb.dart';
import '../../Finances/View/Mobile/FinancesScreenMobile.dart';
import '../../Calendar/View/Web/CalendarScreenWeb.dart';
import '../../Calendar/View/Mobile/CalendarScreenMobile.dart';
import '../../Players/View/Web/PlayersScreenWeb.dart';
import '../../Players/View/Mobile/PlayersScreenMobile.dart';
import '../../Rewards/View/Web/RewardsScreenWeb.dart';
import '../../Rewards/View/Mobile/RewardsScreenMobile.dart';
import '../../Settings/View/Web/SettingsScreenWeb.dart';
import '../../Settings/View/Mobile/SettingsScreenMobile.dart';

class MenuProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final loginRepo = LoginRepoImp();

  void controlMenu() {
    // if (!_scaffoldKey.currentState!.isDrawerOpen) {
    _scaffoldKey.currentState!.openDrawer();
    //}
  }

  void initHomeScreen(BuildContext context) {
    validateAuthentication(context);
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

  void validateAuthentication(BuildContext context) async {
    if (Provider.of<DataProvider>(context, listen: false).store == null) {
      pageStatus = PageStatus.LOADING;
      notifyListeners();
      String? storedToken = await getToken(context);
      if (storedToken != null) {
        loginRepo.validateToken(context, storedToken).then((response) {
          if (response.responseStatus == NetworkResponseStatus.success) {
            try {
              Provider.of<DataProvider>(context, listen: false)
                  .setLoginResponse(context, response.responseBody!, true);
            } catch (e) {
              print(e);
            }
            setIsEmployeeAdmin(Provider.of<DataProvider>(context, listen: false)
                .isLoggedEmployeeAdmin());
            setSelectedDrawerItem(mainDrawer.first);
            String? lastPage = getLastPage(context);
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

  Future<void> updateDataProvider(BuildContext context) async {
    String? storedToken = await getToken(context);
    if (storedToken != null) {
      pageStatus = PageStatus.LOADING;
      notifyListeners();
      NetworkResponse response =
          await loginRepo.validateToken(context, storedToken);
      if (response.responseStatus == NetworkResponseStatus.success) {
        Provider.of<DataProvider>(context, listen: false)
            .setLoginResponse(context, response.responseBody!, true);
        setIsEmployeeAdmin(Provider.of<DataProvider>(context, listen: false)
            .isLoggedEmployeeAdmin());
        setSelectedDrawerItem(mainDrawer.first);
      }
      pageStatus = PageStatus.OK;
      notifyListeners();
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

  void setMessageModal(String title, String? description, bool isHappy,
      {VoidCallback? onTap}) {
    messageModal = SFMessageModal(
      title: title,
      description: description,
      onTap: onTap ??
          () {
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
      VoidCallback onContinue, VoidCallback onReturn,
      {bool? isConfirmationPositive}) {
    modalFormWidget = SFModalConfirmation(
      title: title,
      description: description,
      onContinue: onContinue,
      onReturn: onReturn,
      isConfirmationPositive: isConfirmationPositive,
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
      widgetWeb: const HomeScreenWeb(),
      widgetMobile: const HomeScreenMobile(),
      mainDrawer: true,
      availableMobile: true,
    ),
    DrawerItem(
      title: "Calendário",
      icon: r"assets/icon/calendar.svg",
      requiresAdmin: false,
      widgetWeb: const CalendarScreenWeb(),
      widgetMobile: const CalendarScreenMobile(),
      mainDrawer: true,
      availableMobile: true,
    ),
    DrawerItem(
      title: "Recompensas",
      icon: r"assets/icon/star.svg",
      requiresAdmin: false,
      widgetWeb: RewardsScreenWeb(),
      widgetMobile: RewardsScreenMobile(),
      mainDrawer: true,
      availableMobile: true,
      isNew: true,
    ),
    DrawerItem(
      title: "Financeiro",
      icon: r"assets/icon/finance.svg",
      requiresAdmin: true,
      widgetWeb: FinancesScreenWeb(),
      widgetMobile: FinancesScreenMobile(),
      mainDrawer: true,
      availableMobile: true,
      isNew: true,
    ),
    DrawerItem(
      title: "Minhas quadras",
      icon: r"assets/icon/court.svg",
      requiresAdmin: false,
      widgetWeb: MyCourtsScreenWeb(),
      widgetMobile: MyCourtsScreenMobile(),
      mainDrawer: true,
    ),
    DrawerItem(
      title: "Jogadores",
      icon: r"assets/icon/user_group.svg",
      requiresAdmin: false,
      widgetWeb: PlayersScreenWeb(),
      widgetMobile: PlayersScreenMobile(),
      mainDrawer: true,
      availableMobile: true,
      isNew: true,
    ),
    DrawerItem(
      title: "Cupons de desconto",
      icon: r"assets/icon/discount.svg",
      requiresAdmin: true,
      widgetWeb: CouponsScreenWeb(),
      widgetMobile: CouponsScreenMobile(),
      mainDrawer: true,
      availableMobile: true,
      isNew: true,
    ),
    DrawerItem(
      title: "Meu perfil",
      icon: r"assets/icon/user.svg",
      requiresAdmin: false,
      widgetWeb: SettingsScreenWeb(),
      widgetMobile: SettingsScreenMobile(),
      mainDrawer: false,
    ),
    DrawerItem(
      title: "Ajuda",
      icon: r"assets/icon/help.svg",
      requiresAdmin: false,
      widgetWeb: HelpScreen(),
      widgetMobile: Container(),
      mainDrawer: false,
    ),
    DrawerItem(
      title: "Sair",
      icon: r"assets/icon/logout.svg",
      requiresAdmin: false,
      widgetWeb: Container(),
      widgetMobile: Container(),
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

  List<DrawerItem> get mobileDrawerItems =>
      mainDrawer.where((element) => element.availableMobile == true).toList();

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
    widgetMobile: Container(),
    widgetWeb: Container(),
  );
  DrawerItem get selectedDrawerItem => _selectedDrawerItem;
  void setSelectedDrawerItem(DrawerItem drawer) {
    _selectedDrawerItem = drawer;
    notifyListeners();
  }

  bool get isOnHome => selectedDrawerItem.title == "Início";

  void onTabClick(DrawerItem drawerItem, BuildContext context) {
    storeLastPage(context, drawerItem.title);
    setSelectedDrawerItem(drawerItem);
    if (drawerItem.logout) {
      logout(context);
    }
    scaffoldKey.currentState!.closeEndDrawer();
    notifyListeners();
  }

  void quickLinkHome(BuildContext context) {
    onTabClick(
      mainDrawer.firstWhere((element) => element.title == "Início"),
      context,
    );
  }

  void quickLinkSettings(BuildContext context) {
    onTabClick(
      _drawerItems.firstWhere((element) => element.title == "Meu perfil"),
      context,
    );
  }

  void quickLinkBrand(BuildContext context) {
    DrawerItem? drawer = permissionsDrawerItems
        .firstWhereOrNull((tab) => tab.title == "Meu Perfil");
    if (drawer != null) {
      onTabClick(
        drawer,
        context,
      );
    }
  }

  void quickLinkWorkingHours(BuildContext context) {
    DrawerItem? drawer = permissionsDrawerItems
        .firstWhereOrNull((tab) => tab.title == "Minhas quadras");
    if (drawer != null) {
      onTabClick(
        drawer,
        context,
      );
    }
  }

  void quickLinkMyCourts(BuildContext context) {
    onTabClick(
      mainDrawer.firstWhere((element) => element.title == "Minhas quadras"),
      context,
    );
  }

  void logout(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false).clearDataProvider();
    storeToken(context, "");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (Route<dynamic> route) => false,
    );
  }
}
