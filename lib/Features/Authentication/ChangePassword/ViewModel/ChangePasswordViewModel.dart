import 'package:flutter/material.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';

import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../Repository/ChangePasswordRepoImp.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  void init(String tokenArg, bool isStoreRequestArg) {
    token = tokenArg;
    isStoreRequest = isStoreRequestArg;
    if (isStoreRequest) {
    } else {
      validateChangePasswordTokenUser();
    }
  }

  final changePasswordRepo = ChangePasswordRepoImp();

  PageStatus pageStatus = PageStatus.LOADING;
  SFMessageModal messageModal = SFMessageModal(
    message: "",
    onTap: () {},
    isHappy: true,
  );

  String token = "";
  bool isStoreRequest = true;

  final changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void validateChangePasswordTokenUser() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo.validateChangePasswordTokenUser(token).then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        pageStatus = PageStatus.OK;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          message: response.userMessage!,
          onTap: () => validateChangePasswordTokenUser(),
          isHappy: false,
          buttonText: "Tentar novamente",
        );
        pageStatus = PageStatus.WARNING;
        notifyListeners();
      }
    });
  }

  void changePassword() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .changePasswordUser(token, newPasswordController.text)
        .then((response) {
      messageModal = SFMessageModal(
        message: response.userMessage!,
        onTap: () {},
        isHappy: response.responseStatus == NetworkResponseStatus.alert,
        hideButton: true,
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
    });
  }
}
