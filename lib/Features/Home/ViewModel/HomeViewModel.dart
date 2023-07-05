import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppNotification.dart';

class HomeViewModel extends ChangeNotifier {
  List<AppNotification> notifications = [];

  void initHomeScreen(BuildContext context) {
    notifications =
        Provider.of<DataProvider>(context, listen: false).notifications;
    notifyListeners();
  }

  String get welcomeTitle {
    int hourNow = DateTime.now().hour;
    if (hourNow < 12) {
      return "Bom dia, Beach Brasil!";
    } else if (hourNow < 18) {
      return "Boa tarde, Beach Brasil!";
    } else {
      return "Boa noite, Beach Brasil!";
    }
  }

  bool needsOnboarding(BuildContext context) {
    if (courtsSet(context) &&
        logoSet(context) &&
        photosSet(context) &&
        storeDescriptionSet(context) &&
        financeSettingsSet(context)) {
      return false;
    } else {
      return true;
    }
  }

  bool courtsSet(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).courts.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool logoSet(BuildContext context) {
    return Provider.of<DataProvider>(context, listen: false).store!.logo !=
        null;
  }

  bool photosSet(BuildContext context) {
    return Provider.of<DataProvider>(context, listen: false)
            .store!
            .photos
            .length >=
        2;
  }

  bool storeDescriptionSet(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).store!.description !=
            null &&
        Provider.of<DataProvider>(context, listen: false)
            .store!
            .description!
            .isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool financeSettingsSet(BuildContext context) {
    return Provider.of<DataProvider>(context, listen: false)
                .store!
                .bankAccount !=
            null &&
        Provider.of<DataProvider>(context, listen: false)
            .store!
            .bankAccount!
            .isNotEmpty;
  }
}
