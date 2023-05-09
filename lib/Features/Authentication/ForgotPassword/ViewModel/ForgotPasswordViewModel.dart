import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/ForgotPassword/Repository/ForgotPasswordRepo.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../Repository/ForgotPasswordRepoImp.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final _forgotPasswordRepo = ForgotPasswordRepoImp();

  PageStatus pageStatus = PageStatus.OK;
  SFMessageModal messageModal = SFMessageModal(
    message: "",
    onTap: () {},
    isHappy: true,
  );

  final forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController forgotPasswordEmailController = TextEditingController();

  void sendForgotPassword(BuildContext context) {
    _forgotPasswordRepo
        .forgotPassword(forgotPasswordEmailController.text)
        .then((response) {
      messageModal = SFMessageModal(
        message:
            "Email enviado! ${titleDescriptionSeparator}Verifique sua caixa de email e crie uma nova senha",
        onTap: () {
          goToLogin(context);
        },
        isHappy: response.responseStatus == NetworkResponseStatus.alert,
      );
      pageStatus = PageStatus.OK;
      notifyListeners();
    });
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
