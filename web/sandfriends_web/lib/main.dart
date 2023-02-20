import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/View/DashboardScreen.dart';
import 'package:sandfriends_web/Login/View/LoginScreen.dart';
import 'Utils/Constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      title: 'Sandfriends Web',
      theme: ThemeData(
        scaffoldBackgroundColor: secondaryBack,
        fontFamily: "Lexend",
      ),
      routes: {
        '/login': (BuildContext context) => const LoginScreen(),
        '/dashboard': (BuildContext context) => const DashboardScreen(),
      },
      initialRoute: '/dashboard',
    );
  }
}
