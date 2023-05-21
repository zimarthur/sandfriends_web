import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';

class HomeViewModel extends ChangeNotifier {
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
    if (opDaysSet(context) &&
        courtsSet(context) &&
        brandingSet(context) &&
        storeDescriptionSet(context) &&
        financeSettingsSet(context)) {
      return false;
    } else {
      return true;
    }
  }

  bool opDaysSet(BuildContext context) {
    return Provider.of<DataProvider>(context, listen: false).storeWorkingDays ==
        null;
  }

  bool courtsSet(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).courts.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool brandingSet(BuildContext context) {
    if (Provider.of<DataProvider>(context, listen: false).store!.logo != null &&
        Provider.of<DataProvider>(context, listen: false)
            .store!
            .logo!
            .isEmpty &&
        Provider.of<DataProvider>(context, listen: false)
            .store!
            .photos
            .isNotEmpty) {
      return true;
    } else {
      return false;
    }
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
    return false;
  }
}
