import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/ForgotPassword/Repository/ForgotPasswordRepo.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../Repository/ForgotPasswordRepoImp.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final forgotPasswordRepo = ForgotPasswordRepoImp();

  PageStatus pageStatus = PageStatus.OK;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
    onTap: () {},
    isHappy: true,
  );

  final forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController forgotPasswordEmailController = TextEditingController();

  void sendForgotPassword(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    forgotPasswordRepo
        .forgotPassword(
      context,
      forgotPasswordEmailController.text,
    )
        .then((response) {
      messageModal = SFMessageModal(
        title: response.responseTitle!,
        description: response.responseDescription,
        onTap: () {
          if (response.responseStatus == NetworkResponseStatus.alert) {
            goToLogin(context);
          } else {
            pageStatus = PageStatus.OK;
            notifyListeners();
          }
        },
        isHappy: response.responseStatus == NetworkResponseStatus.alert,
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
    });
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
