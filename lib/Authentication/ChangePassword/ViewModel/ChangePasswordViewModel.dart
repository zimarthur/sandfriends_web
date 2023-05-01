import 'package:flutter/material.dart';

import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../Utils/PageStatus.dart';
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
    title: "",
    description: "",
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
      if (response == null) return;
      if (response.requestSuccess) {
        pageStatus = PageStatus.OK;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          title: response.errorMessage!,
          description: "",
          onTap: () => validateChangePasswordTokenUser(),
          isHappy: false,
          buttonText: "Tentar novamente",
        );
        pageStatus = PageStatus.ERROR;
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
      if (response == null) return;
      if (response.requestSuccess) {
        messageModal = SFMessageModal(
          title: response.responseBody,
          description: "",
          onTap: () {},
          isHappy: true,
          hideButton: true,
        );
        pageStatus = PageStatus.SUCCESS;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          title: response.errorMessage!,
          description: "",
          onTap: () {
            pageStatus = PageStatus.OK;
            notifyListeners();
          },
          isHappy: false,
        );
        pageStatus = PageStatus.ERROR;
        notifyListeners();
      }
    });
  }
}
