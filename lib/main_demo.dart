import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:sandfriends_web/app.dart';

void main() {
  configureApp();
  runApp(const App(
    flavor: "demo",
  ));
}

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}
