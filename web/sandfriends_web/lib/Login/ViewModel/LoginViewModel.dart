import 'package:flutter/material.dart';
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
}
