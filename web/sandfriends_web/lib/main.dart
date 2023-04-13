import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Rewards/ViewModel/RewardsViewModel.dart';
import 'package:sandfriends_web/Dashboard/View/DashboardScreen.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DashboardViewModel.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Login/View/LoginScreen.dart';
import 'package:sandfriends_web/Login/View/NewPasswordScreen.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'Dashboard/Features/Settings/ViewModel/SettingsViewModel.dart';
import 'Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => RewardsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', 'BR'),
          const Locale('en'),
        ],
        locale: const Locale('pt', 'BR'),
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
          '/new_password': (BuildContext context) => const NewPasswordScreen(),
          '/login': (BuildContext context) => const LoginScreen(),
          '/dashboard': (BuildContext context) => const DashboardScreen(),
        },
        initialRoute: '/dashboard',
      ),
    );
  }
}
