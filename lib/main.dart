import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/ChangePassword/View/ChangePasswordScreen.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/CreateAccountScreen.dart';
import 'package:sandfriends_web/Features/Authentication/EmailConfirmation/View/EmailConfirmationScreen.dart';
import 'package:sandfriends_web/Features/Authentication/ForgotPassword/View/ForgotPasswordScreen.dart';
import 'package:sandfriends_web/Features/Rewards/ViewModel/RewardsViewModel.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/MenuProvider.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Features/Authentication/Login/View/LoginScreen.dart';
import 'package:sandfriends_web/Features/Terms/PrivacyScreen.dart';
import 'package:sandfriends_web/Features/Terms/TermsScreen.dart';
import 'Features/Authentication/CreateAccountEmployee/View/CreateAccountEmployeeScreen.dart';
import 'Features/Menu/View/MenuScreen.dart';
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
          String emailConfirmation = '/emcf';
          String changePassword = '/cgpw';

          if (settings.name!.startsWith(newAccountEmployee)) {
            return MaterialPageRoute(
              builder: (context) {
                return CreateAccountEmployeeScreen(
                  token: settings.name!.split(newAccountEmployee)[1],
                );
              },
            );
          } else if (settings.name!.startsWith(emailConfirmation)) {
            bool isStoreRequest = true;
            String token = "";
            final arguments = settings.name!.split("?")[1].split("&");
            for (var argument in arguments) {
              if (argument.startsWith("str")) {
                isStoreRequest = argument.split("=")[1] == "1";
              } else {
                token = argument.split("=")[1];
              }
            }
            return MaterialPageRoute(
              builder: (context) {
                return EmailConfirmationScreen(
                  token: token,
                  isStoreRequest: isStoreRequest,
                );
              },
            );
          } else if (settings.name!.startsWith(changePassword)) {
            bool isStoreRequest = true;
            String token = "";
            final arguments = settings.name!.split("?")[1].split("&");
            for (var argument in arguments) {
              if (argument.startsWith("str")) {
                isStoreRequest = argument.split("=")[1] == "1";
              } else {
                token = argument.split("=")[1];
              }
            }
            return MaterialPageRoute(
              builder: (context) {
                return ChangePasswordScreen(
                  token: token,
                  isStoreRequest: isStoreRequest,
                );
              },
            );
          }
          return null;
        },
        routes: {
          //'/new_password': (BuildContext context) => const NewPasswordScreen(),
          '/login': (BuildContext context) => const LoginScreen(),
          '/create_account': (BuildContext context) =>
              const CreateAccountScreen(),
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
