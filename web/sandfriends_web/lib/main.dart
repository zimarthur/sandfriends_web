import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/View/Components/dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Login/View/login_screen.dart';
import 'constants.dart';
import 'controllers/MenuController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MaterialScrollBehavior().copyWith(
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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginViewModel(),
          ),
        ],
        child: LoginScreen(),
      ),
    );
  }
}
