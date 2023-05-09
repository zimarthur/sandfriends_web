import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/EmailConfirmation/Repository/EmailConfirmationRepoImp.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:sandfriends_web/SharedComponents/View/SFMessageModal.dart';

import '../../../../Utils/PageStatus.dart';

class EmailConfirmationViewModel extends ChangeNotifier {
  void initEmailConfirmationViewModel(String tokenUrl, bool isStoreRequestUrl) {
    token = tokenUrl;
    isStoreRequest = isStoreRequestUrl;
    if (isStoreRequest) {
      validateTokenStore();
    } else {
      validateTokenUser();
    }
  }

  final emailConfirmationRepo = EmailConfirmationRepoImp();

  PageStatus pageStatus = PageStatus.LOADING;
  SFMessageModal messageModal = SFMessageModal(
    message: "",
    onTap: () {},
    isHappy: true,
  );

  String token = "";
  bool isStoreRequest = true;

  void validateTokenUser() {
    emailConfirmationRepo.emailConfirmationUser(token).then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        pageStatus = PageStatus.OK;
      } else {
        messageModal = SFMessageModal(
          message: response.userMessage!,
          onTap: () {},
          isHappy: false,
          hideButton: true,
        );
        pageStatus = PageStatus.WARNING;
      }
      notifyListeners();
    });
  }

  void validateTokenStore() {
    emailConfirmationRepo.emailConfirmationStore(token).then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        pageStatus = PageStatus.OK;
      } else {
        messageModal = SFMessageModal(
          message: response.userMessage!,
          onTap: () {},
          isHappy: false,
          hideButton: true,
        );
        pageStatus = PageStatus.WARNING;
      }
      notifyListeners();
    });
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
