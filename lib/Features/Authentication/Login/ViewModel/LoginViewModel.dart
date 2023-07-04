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
import 'dart:html';

import '../../../../Utils/LocalStorage.dart';

class LoginViewModel extends ChangeNotifier {
  final loginRepo = LoginRepoImp();

  PageStatus pageStatus = PageStatus.OK;
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

  void validateToken(BuildContext context) {
    String? storedToken = getToken();
    if (storedToken != null) {
      loginRepo.validateToken(storedToken).then((response) {
        if (response.responseStatus == NetworkResponseStatus.success) {
          Provider.of<DataProvider>(context, listen: false)
              .setLoginResponse(response.responseBody!, keepConnected);
          Navigator.pushNamed(context, '/home');
        } else {
          pageStatus = PageStatus.OK;
          notifyListeners();
        }
      });
    }
    pageStatus = PageStatus.OK;
    notifyListeners();
  }

  void onTapLogin(BuildContext context) {
    if (loginFormKey.currentState?.validate() == true) {
      pageStatus = PageStatus.LOADING;
      notifyListeners();

      loginRepo
          .login(userController.text, passwordController.text)
          .then((response) {
        if (response.responseStatus == NetworkResponseStatus.success) {
          Provider.of<DataProvider>(context, listen: false)
              .setLoginResponse(response.responseBody!, keepConnected);
          Navigator.pushNamed(context, '/home');
        } else {
          messageModal = SFMessageModal(
            title:
                "Não encontramos nenhuma quadra com este e-mail", //response.responseTitle!,
            description:
                "Se você é um jogador, realize o login diretamente pelo app", //response.responseDescription,
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
