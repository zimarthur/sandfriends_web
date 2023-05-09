import 'package:flutter/material.dart';

import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../Repository/CreateAccountEmployeeRepo.dart';

class CreateAccountEmployeeViewModel extends ChangeNotifier {
  final _createAccountEmployeeRepo = CreateAccountEmployeeRepo();

  PageStatus pageStatus = PageStatus.OK;
  SFMessageModal messageModal = SFMessageModal(
    message: "",
    onTap: () {},
    isHappy: true,
  );

  String addEmployeeToken = "";
  String email = "zim.arthur97@gmail.com";
  String storeName = "Beach Brasil";

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

  void initCreateAccountEmployeeViewModel(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    _createAccountEmployeeRepo
        .validateNewEmployeeToken(addEmployeeToken)
        .then((response) {
      email = response["Email"];
      storeName = response["Store"];
      pageStatus = PageStatus.OK;
      notifyListeners();
    }).onError((error, stackTrace) {
      messageModal = SFMessageModal(
        message: error.toString(),
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        isHappy: false,
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
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
        message: "feito",
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        isHappy: true,
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
    }).onError((error, stackTrace) {
      messageModal = SFMessageModal(
        message: error.toString(),
        onTap: () {
          pageStatus = PageStatus.OK;
          notifyListeners();
        },
        isHappy: false,
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
