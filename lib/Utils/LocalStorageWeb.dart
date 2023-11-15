import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/ViewModel/EnvironmentProvider.dart';

Future storeToken(BuildContext context, String accessToken) async {
  window.localStorage[
          "sfToken${Provider.of<EnvironmentProvider>(context, listen: false).envStorageKey()}"] =
      accessToken;
}

Future<String?> getToken(BuildContext context) async {
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
