import 'package:flutter/material.dart';

import '../../../Utils/PageStatus.dart';
import '../Repository/CreateAccountEmployeeRepo.dart';

class CreateAccountEmployeeViewModel extends ChangeNotifier {
  final _createAccountEmployeeRepo = CreateAccountEmployeeRepo();

  PageStatus pageStatus = PageStatus.OK;
  String modalTitle = "";
  String modalDescription = "";
  VoidCallback modalCallback = () {};

  TextEditingController createAccountEmployeeEmailController =
      TextEditingController();
  TextEditingController createAccountEmployeePasswordController =
      TextEditingController();
  TextEditingController createAccountEmployeePasswordConfirmController =
      TextEditingController();

  final createAccountEmployeeFormKey = GlobalKey<FormState>();

  void createAccountEmployee(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    _createAccountEmployeeRepo
        .createAccountEmployee(createAccountEmployeeEmailController.text,
            createAccountEmployeePasswordController.text)
        .then((value) {
      modalTitle = "feito";
      modalDescription = "feito";
      modalCallback = () {
        Navigator.pushNamed(context, '/login');
      };
      pageStatus = PageStatus.SUCCESS;
      notifyListeners();
    }).onError((error, stackTrace) {
      modalTitle = error.toString();
      modalDescription = "";
      modalCallback = () {
        pageStatus = PageStatus.OK;
        notifyListeners();
      };
      pageStatus = PageStatus.ERROR;
      notifyListeners();
    });
  }

  void goToCreateAccount(BuildContext context) {
    Navigator.pushNamed(context, '/create_account');
  }
}
