import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/Employee.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/Model/Store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';
import '../../../../SharedComponents/View/SFMessageModal.dart';
import 'package:tuple/tuple.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../../Utils/LocalStorageWeb.dart'
    if (dart.library.io) '../../../../Utils/LocalStorageMobile.dart';
import '../../../../Utils/Responsive.dart';

class LoginViewModel extends ChangeNotifier {
  final loginRepo = LoginRepoImp();

  PageStatus pageStatus = PageStatus.LOADING;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
    onTap: () {},
    isHappy: true,
  );

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  bool _keepConnected = true;
  bool get keepConnected => _keepConnected;
  set keepConnected(bool newValue) {
    _keepConnected = newValue;
    notifyListeners();
  }

  Tuple2<bool, String?>? notificationsConfig;

  Future<void> configureNotifications() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("ARTHUR token is : $fcmToken");
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    bool? authorization =
        settings.authorizationStatus == AuthorizationStatus.authorized
            ? true
            : settings.authorizationStatus == AuthorizationStatus.denied
                ? false
                : null;
    notificationsConfig = authorization != null
        ? Tuple2<bool, String?>(authorization, fcmToken)
        : null;
  }

  void validateToken(BuildContext context) async {
    String? storedToken = await getToken(context);
    if (storedToken != null && storedToken.isNotEmpty) {
      loginRepo.validateToken(context, storedToken).then((response) {
        if (response.responseStatus == NetworkResponseStatus.success) {
          Provider.of<DataProvider>(context, listen: false)
              .setLoginResponse(context, response.responseBody!, keepConnected);
          Navigator.pushNamed(context, '/home');
        } else {
          pageStatus = PageStatus.OK;
          notifyListeners();
          if (!kIsWeb) {
            configureNotifications().then((notificationCOnfigs) {});
          }
        }
      });
    } else {
      pageStatus = PageStatus.OK;
      notifyListeners();
      if (!kIsWeb) {
        configureNotifications().then((notificationCOnfigs) {});
      }
    }
  }

  void onTapLogin(BuildContext context) {
    if (loginFormKey.currentState?.validate() == true) {
      pageStatus = PageStatus.LOADING;
      notifyListeners();

      loginRepo
          .login(
        context,
        userController.text,
        passwordController.text,
        notificationsConfig,
      )
          .then((response) {
        if (response.responseStatus == NetworkResponseStatus.success) {
          Provider.of<DataProvider>(context, listen: false)
              .setLoginResponse(context, response.responseBody!, keepConnected);
          Navigator.pushNamed(context, '/home');
        } else {
          messageModal = SFMessageModal(
            title: response.responseTitle!,
            description: response.responseDescription,
            onTap: () {
              pageStatus = PageStatus.OK;
              notifyListeners();
            },
            isHappy: response.responseStatus == NetworkResponseStatus.alert,
          );
          pageStatus = PageStatus.WARNING;
          notifyListeners();
        }
      });
    }
  }

  void onTapForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forgot_password');
  }

  void onTapCreateAccount(BuildContext context) {
    Navigator.pushNamed(context, '/create_account');
  }
}
