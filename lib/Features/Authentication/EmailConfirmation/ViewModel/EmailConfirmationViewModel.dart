import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/EmailConfirmation/Repository/EmailConfirmationRepoImp.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:sandfriends_web/SharedComponents/View/SFMessageModal.dart';

import '../../../../Utils/PageStatus.dart';

class EmailConfirmationViewModel extends ChangeNotifier {
  void initEmailConfirmationViewModel(
      BuildContext context, String tokenUrl, bool isStoreRequestUrl) {
    token = tokenUrl;
    isStoreRequest = isStoreRequestUrl;
    if (isStoreRequest) {
      validateTokenStore(context);
    } else {
      validateTokenUser();
    }
  }

  final emailConfirmationRepo = EmailConfirmationRepoImp();

  PageStatus pageStatus = PageStatus.LOADING;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
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
          title: response.responseTitle!,
          description: response.responseDescription,
          onTap: () {
            pageStatus = PageStatus.OK;
            notifyListeners();
          },
          isHappy: response.responseStatus == NetworkResponseStatus.alert,
          hideButton: response.responseStatus == NetworkResponseStatus.error,
        );
        pageStatus = PageStatus.WARNING;
      }
      notifyListeners();
    });
  }

  void validateTokenStore(BuildContext context) {
    emailConfirmationRepo.emailConfirmationStore(token).then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        pageStatus = PageStatus.OK;
      } else {
        messageModal = SFMessageModal(
          title: response.responseTitle!,
          description: response.responseDescription!,
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          isHappy: response.responseStatus == NetworkResponseStatus.alert,
          buttonText: "login",
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
