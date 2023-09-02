import 'package:flutter/material.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';

import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../Repository/ChangePasswordRepoImp.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  void init(BuildContext context, String tokenArg, bool isStoreRequestArg) {
    token = tokenArg;
    isStoreRequest = isStoreRequestArg;
    validateChangePassword(
      context,
    );
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

  void validateChangePassword(
    BuildContext context,
  ) {
    if (isStoreRequest) {
      validateChangePasswordTokenEmployee(context);
    } else {
      validateChangePasswordTokenUser(context);
    }
  }

  void changePassword(BuildContext context) {
    if (isStoreRequest) {
      changePasswordEmployee(context);
    } else {
      changePasswordUser(context);
    }
  }

  void validateChangePasswordTokenUser(
    BuildContext context,
  ) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .validateChangePasswordTokenUser(context, token)
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        pageStatus = PageStatus.OK;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          title: response.responseTitle!,
          onTap: () => validateChangePasswordTokenUser(context),
          isHappy: false,
          buttonText: "Tentar novamente",
        );
        pageStatus = PageStatus.WARNING;
        notifyListeners();
      }
    });
  }

  void validateChangePasswordTokenEmployee(
    BuildContext context,
  ) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .validateChangePasswordTokenEmployee(context, token)
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

  void changePasswordUser(
    BuildContext context,
  ) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .changePasswordUser(context, token, newPasswordController.text)
        .then((response) {
      messageModal = SFMessageModal(
        title: response.responseTitle!,
        onTap: () {
          pageStatus = PageStatus.OK;
          notifyListeners();
        },
        isHappy: response.responseStatus == NetworkResponseStatus.alert,
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
    });
  }

  void changePasswordEmployee(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    changePasswordRepo
        .changePasswordEmployee(context, token, newPasswordController.text)
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
