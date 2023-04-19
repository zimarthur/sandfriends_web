import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/ForgotPassword/Repository/ForgotPasswordRepo.dart';
import 'package:sandfriends_web/Authentication/Login/View/LoginScreen.dart';

import '../../../Utils/PageStatus.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final _forgotPasswordRepo = ForgotPasswordRepo();

  PageStatus pageStatus = PageStatus.OK;
  String modalTitle = "";
  String modalDescription = "";
  VoidCallback modalCallback = () {};

  final forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController forgotPasswordEmailController = TextEditingController();

  void sendForgotPassword(BuildContext context) {
    _forgotPasswordRepo
        .forgotPassword(forgotPasswordEmailController.text)
        .then((value) {
      modalTitle = "Email enviado!";
      modalDescription = "Verifique sua caixa de email e crie uma nova senha";
      modalCallback = () {
        goToLogin(context);
      };
      pageStatus = PageStatus.SUCCESS;
      notifyListeners();
    }).onError((error, stackTrace) {
      modalTitle = error.toString();
      modalDescription = "";
      modalCallback = () {
        pageStatus = PageStatus.SUCCESS;
        notifyListeners();
      };
      pageStatus = PageStatus.ERROR;
      notifyListeners();
    });
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
