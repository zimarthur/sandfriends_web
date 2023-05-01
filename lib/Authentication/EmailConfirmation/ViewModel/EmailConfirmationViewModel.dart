import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/EmailConfirmation/Repository/EmailConfirmationRepoImp.dart';
import 'package:sandfriends_web/SharedComponents/View/SFMessageModal.dart';

import '../../../Utils/PageStatus.dart';

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
    title: "",
    description: "",
    onTap: () {},
    isHappy: true,
  );

  String token = "";
  bool isStoreRequest = true;

  void validateTokenUser() {
    emailConfirmationRepo.emailConfirmationUser(token).then((response) {
      if (response == null) return;
      if (response.requestSuccess) {
        pageStatus = PageStatus.SUCCESS;
      } else {
        messageModal = SFMessageModal(
          title: response.errorMessage!,
          description: "",
          onTap: () {},
          isHappy: false,
          hideButton: true,
        );
        pageStatus = PageStatus.ERROR;
      }
      notifyListeners();
    });
  }

  void validateTokenStore() {
    emailConfirmationRepo.emailConfirmationStore(token).then((response) {
      if (response == null) return;
      if (response.requestSuccess) {
        pageStatus = PageStatus.SUCCESS;
      } else {
        messageModal = SFMessageModal(
          title: response.errorMessage!,
          description: "",
          onTap: () {},
          isHappy: false,
          hideButton: true,
        );
        pageStatus = PageStatus.ERROR;
      }
      notifyListeners();
    });
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
