import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/View/CreateAccountScreen.dart';
import 'package:sandfriends_web/Authentication/ForgotPassword/View/ForgotPasswordScreen.dart';
import 'package:sandfriends_web/Dashboard/Features/Rewards/ViewModel/RewardsViewModel.dart';
import 'package:sandfriends_web/Dashboard/View/DashboardScreen.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DashboardViewModel.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Authentication/Login/View/LoginScreen.dart';
import 'package:sandfriends_web/Terms/PrivacyScreen.dart';
import 'package:sandfriends_web/Terms/TermsScreen.dart';
import 'Authentication/CreateAccountEmployee/View/CreateAccountEmployeeScreen.dart';
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('en'),
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
          //'/new_password': (BuildContext context) => const NewPasswordScreen(),
          '/login': (BuildContext context) => const LoginScreen(),
          '/create_account': (BuildContext context) =>
              const CreateAccountScreen(),
          '/create_account_employee': (BuildContext context) =>
              const CreateAccountEmployeeScreen(),
          '/forgot_password': (BuildContext context) =>
              const ForgotPasswordScreen(),
          '/home': (BuildContext context) => const DashboardScreen(),
          '/terms': (BuildContext context) => const TermsScreen(),
          '/privacy': (BuildContext context) => const PrivacyScreen(),
        },
        initialRoute: '/login',
      ),
    );
  }
}
