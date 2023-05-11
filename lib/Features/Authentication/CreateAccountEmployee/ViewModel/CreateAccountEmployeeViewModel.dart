import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccountEmployee/Repository/CreateAccountEmployeeRepoImp.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';

import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../Repository/CreateAccountEmployeeRepo.dart';

class CreateAccountEmployeeViewModel extends ChangeNotifier {
  final _createAccountEmployeeRepo = CreateAccountEmployeeRepoImp();

  PageStatus pageStatus = PageStatus.OK;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
    onTap: () {},
    isHappy: true,
  );

  String addEmployeeToken = "";
  String email = "";
  String storeName = "";

  TextEditingController createAccountEmployeeFirstNameController =
      TextEditingController();
  TextEditingController createAccountEmployeeLastNameController =
      TextEditingController();
  TextEditingController createAccountEmployeePasswordController =
      TextEditingController();
  TextEditingController createAccountEmployeePasswordConfirmController =
      TextEditingController();
  bool isAbove18 = true;
  bool termsAgree = true;

  final createAccountEmployeeFormKey = GlobalKey<FormState>();

  void initCreateAccountEmployeeViewModel(BuildContext context, String token) {
    addEmployeeToken = token;
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    _createAccountEmployeeRepo
        .validateNewEmployeeToken(addEmployeeToken)
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        Map<String, dynamic> responseBody = json.decode(
          response.responseBody!,
        );
        email = responseBody["Email"];
        storeName = responseBody["StoreName"];
        pageStatus = PageStatus.OK;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          title: response.responseTitle!,
          description: response.responseDescription,
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          isHappy: response.responseStatus == NetworkResponseStatus.alert,
        );
        pageStatus = PageStatus.WARNING;
        notifyListeners();
      }
    });
  }

  void createAccountEmployee(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    _createAccountEmployeeRepo
        .createAccountEmployee(
      addEmployeeToken,
      createAccountEmployeeFirstNameController.text,
      createAccountEmployeeLastNameController.text,
      createAccountEmployeePasswordController.text,
    )
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
        buttonText: response.responseStatus == NetworkResponseStatus.alert
            ? "Concluído"
            : "Voltar",
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
    });
  }

  bool missingTerms() {
    return !isAbove18 || !termsAgree;
  }

  void onTapTermosDeUso(BuildContext context) {
    Navigator.pushNamed(context, '/terms');
  }

  void onTapPoliticaDePrivacidade(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }
}
