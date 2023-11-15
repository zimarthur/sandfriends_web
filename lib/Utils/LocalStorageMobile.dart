import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/ViewModel/EnvironmentProvider.dart';

Future storeToken(BuildContext context, String accessToken) async {
  const storage = FlutterSecureStorage();
  await storage.write(
      key:
          "sfToken${Provider.of<EnvironmentProvider>(context, listen: false).envStorageKey()}",
      value: accessToken);
}

Future<String?> getToken(BuildContext context) async {
  const storage = FlutterSecureStorage();
  return await storage.read(
      key:
          "sfToken${Provider.of<EnvironmentProvider>(context, listen: false).envStorageKey()}");
}

void storeLastPage(BuildContext context, String pageName) {}

String? getLastPage(BuildContext context) {
  return null;
}
