import 'package:flutter/material.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';

import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../Repository/ChangePasswordRepoImp.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  void init(String tokenArg, bool isStoreRequestArg) {
    token = tokenArg;
    isStoreRequest = isStoreRequestArg;
    validateChangePassword();
  }

  final changePasswordRepo = ChangePasswordRepoImp();

  PageStatus pageStatus = PageStatus.LOADING;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
    onTap: () {},
    isHappy: true,
  );

  String token = "";
  bool isStoreRequest = true;

  final changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void validateChangePassword() {
    if (isStoreRequest) {
      validateChangePasswordTokenEmployee();
    } else {
      validateChangePasswordTokenUser();
    }
  }

  void changePassword(BuildContext context) {
    if (isStoreRequest) {
      changePasswordEmployee(context);
    } else {
      changePasswordUser();
    }
  }

  void validateChangePasswordTokenUser() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo.validateChangePasswordTokenUser(token).then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        pageStatus = PageStatus.OK;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          title: response.responseTitle!,
          onTap: () => validateChangePasswordTokenUser(),
          isHappy: false,
          buttonText: "Tentar novamente",
        );
        pageStatus = PageStatus.WARNING;
        notifyListeners();
      }
    });
  }

  void validateChangePasswordTokenEmployee() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .validateChangePasswordTokenEmployee(token)
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        pageStatus = PageStatus.OK;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          title: response.responseTitle!,
          description: response.responseDescription,
          onTap: () {},
          hideButton: true,
          isHappy: false,
        );
        pageStatus = PageStatus.WARNING;
        notifyListeners();
      }
    });
  }

  void changePasswordUser() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .changePasswordUser(token, newPasswordController.text)
        .then((response) {
      messageModal = SFMessageModal(
        title: response.responseTitle!,
        onTap: () {},
        isHappy: response.responseStatus == NetworkResponseStatus.alert,
        hideButton: true,
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
    });
  }

  void changePasswordEmployee(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .changePasswordEmployee(token, newPasswordController.text)
        .then((response) {
      messageModal = SFMessageModal(
        title: response.responseTitle!,
        description: response.responseDescription,
        onTap: () {
          if (response.responseStatus == NetworkResponseStatus.alert) {
            Navigator.pushNamed(context, '/login');
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
}
