import 'package:flutter/material.dart';

import '../../Remote/Url.dart';

class EnvironmentProvider extends ChangeNotifier {
  Environment currentEnvironment = Environment.Prod;
  setEnvironment(String rawEnvironment) {
    if (rawEnvironment == "prod") {
      currentEnvironment = Environment.Prod;
    } else if (rawEnvironment == "dev") {
      currentEnvironment = Environment.Dev;
    } else {
      currentEnvironment = Environment.Demo;
    }
    notifyListeners();
  }

  bool isDev() {
    return currentEnvironment == Environment.Dev;
  }

  String urlBuilder(String endPoint, {bool isImage = false}) {
    String addReq = "";
    if (!isImage) {
      addReq = "/req";
    }
    String finalUrl = "";
    if (currentEnvironment == Environment.Prod) {
      finalUrl = sandfriendsProd + addReq + endPoint;
    } else if (currentEnvironment == Environment.Dev) {
      finalUrl = sandfriendsDev + addReq + endPoint;
    } else {
      finalUrl = sandfriendsDemo + addReq + endPoint;
    }
    return finalUrl;
  }

  String envStorageKey() {
    switch (currentEnvironment) {
      case Environment.Prod:
        return "Prod";
      case Environment.Demo:
        return "Demo";
      default:
        return "Dev";
    }
  }
}

enum Environment { Prod, Dev, Demo }
