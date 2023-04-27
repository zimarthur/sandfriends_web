import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/View/CreateAccountScreen.dart';
import 'package:sandfriends_web/Authentication/ForgotPassword/View/ForgotPasswordScreen.dart';
import 'package:sandfriends_web/Rewards/ViewModel/RewardsViewModel.dart';
import 'package:sandfriends_web/Menu/ViewModel/MenuProvider.dart';
import 'package:sandfriends_web/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Authentication/Login/View/LoginScreen.dart';
import 'package:sandfriends_web/Terms/PrivacyScreen.dart';
import 'package:sandfriends_web/Terms/TermsScreen.dart';
import 'Authentication/CreateAccountEmployee/View/CreateAccountEmployeeScreen.dart';
import 'Menu/View/MenuScreen.dart';
import 'Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  configureApp();
  runApp(const MyApp());
}

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuProvider(),
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
        onGenerateRoute: (settings) {
          String newAccountEmployee = '/create_account_employee';
          if (settings.name!.startsWith(newAccountEmployee)) {
            return MaterialPageRoute(
              builder: (context) {
                return CreateAccountEmployeeScreen(
                  token: settings.name!.split(newAccountEmployee)[1],
                );
              },
            );
          }
        },
        routes: {
          //'/new_password': (BuildContext context) => const NewPasswordScreen(),
          '/login': (BuildContext context) => const LoginScreen(),
          '/create_account': (BuildContext context) =>
              const CreateAccountScreen(),
          // '/create_account_employee': (BuildContext context) {
          //   final uri = Uri.base;
          //   final token = uri.queryParameters['token'] ?? '';
          //   return CreateAccountEmployeeScreen(token: token);
          // },
          '/forgot_password': (BuildContext context) =>
              const ForgotPasswordScreen(),
          '/home': (BuildContext context) => const MenuScreen(),
          '/terms': (BuildContext context) => const TermsScreen(),
          '/privacy': (BuildContext context) => const PrivacyScreen(),
        },
        initialRoute: '/login',
      ),
    );
  }
}
