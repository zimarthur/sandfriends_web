import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/View/create_account_court_widget.dart';
import 'package:sandfriends_web/Login/View/create_account_owner_widget.dart';
import 'package:sandfriends_web/Login/View/create_account_widget.dart';
import 'package:sandfriends_web/Login/View/login_error_widget.dart';
import 'package:sandfriends_web/Login/View/login_success_widget.dart';
import 'package:sandfriends_web/View/Components/dashboard_screen.dart';

import '../View/forgot_password_widget.dart';
import '../View/login_widget.dart';

class LoginViewModel extends ChangeNotifier {
  Widget _loginWidget = LoginWidget();
  Widget get loginWidget => _loginWidget;

  //LOGIN SCREEN
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool keepConnected = true;

  void onTapLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void onTapForgotPassword() {
    _loginWidget = ForgotPasswordWidget();
    notifyListeners();
  }

  void onTapCreateAccount() {
    _loginWidget = CreateAccountWidget();
    notifyListeners();
  }

  void onTapGoToLoginWidget() {
    _loginWidget = LoginWidget();
    notifyListeners();
  }

  //FORGOT PASSWORD
  TextEditingController forgotPasswordEmailController = TextEditingController();

  void sendForgotPassword() {
    //TODO

    _loginWidget = LoginSuccessWidget();
    notifyListeners();
  }

  //CREATE ACCOUNT
  TextEditingController cnpjController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressNumberController = TextEditingController();
  bool noCnpj = false;

  List<Widget> _createAccountForms = [
    CreateAccountCourtWidget(),
    CreateAccountOwnerWidget()
  ];
  int _currentCreateAccountFormIndex = 0;
  Widget get createAccountForm =>
      _createAccountForms[_currentCreateAccountFormIndex];

  void returnForm() {
    if (_currentCreateAccountFormIndex == 0) {
      onTapGoToLoginWidget();
    } else {
      _currentCreateAccountFormIndex--;
    }
    notifyListeners();
  }

  void nextForm() {
    if (_currentCreateAccountFormIndex == _createAccountForms.length - 1) {
    } else {
      _currentCreateAccountFormIndex++;
    }
    notifyListeners();
  }
}
