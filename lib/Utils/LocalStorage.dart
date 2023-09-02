import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/ViewModel/EnvironmentProvider.dart';

void storeToken(BuildContext context, String accessToken) {
  window.localStorage[
          "sfToken${Provider.of<EnvironmentProvider>(context, listen: false).envStorageKey()}"] =
      accessToken;
}

String? getToken(BuildContext context) {
  return window.localStorage[
      "sfToken${Provider.of<EnvironmentProvider>(context, listen: false).envStorageKey()}"];
}

void storeLastPage(BuildContext context, String pageName) {
  window.localStorage[
          "sfLastPageName${Provider.of<EnvironmentProvider>(context, listen: false).envStorageKey()}"] =
      pageName;
}

String? getLastPage(BuildContext context) {
  return window.localStorage[
      "sfLastPageName${Provider.of<EnvironmentProvider>(context, listen: false).envStorageKey()}"];
}
