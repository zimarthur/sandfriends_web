import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/BasicInfo/ViewModel/BasicInfoViewModel.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/BrandInfo/ViewModel/BrandInfoViewModel.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/EmployeeInfo/ViewModel/EmployeeInfoViewModel.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/FinanceInfo/ViewModel/FinanceInfoViewModel.dart';

class SettingsViewModel extends ChangeNotifier {
  final basicInfoViewModel = BasicInfoViewModel();
  final brandInfoViewModel = BrandInfoViewModel();
  final financeInfoViewModel = FinanceInfoViewModel();
  final employeeInfoViewModel = EmployeeInfoViewModel();

  int _currentForm = 0;
  int get currentForm => _currentForm;
  set currentForm(int value) {
    _currentForm = value;
    notifyListeners();
  }

  List<String> get formsTitle =>
      ["Dados básicos", "Marca", "Dados financeiros", "Equipe"];

  bool _storeInfoDif = false;
  bool get storeInfoDif => _storeInfoDif;

  void setFields(BuildContext context) {
    basicInfoViewModel.setBasicInfoFields(context);
    brandInfoViewModel.setBrandInfoFields(context);
    notifyListeners();
  }

  void storeInfoChanged(BuildContext context) {
    _storeInfoDif = basicInfoViewModel.basicInfoChanged(context) ||
        brandInfoViewModel.brandInfoChanged(context);
    notifyListeners();
  }

  void saveStoreDifChanges(BuildContext context) {
    // Provider.of<DataProvider>(context, listen: false).store!.name =
    //     nameController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.phoneNumber =
    //     telephoneController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.ownerPhoneNumber =
    //     telephoneOwnerController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.cep =
    //     cepController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.neighbourhood =
    //     neighbourhoodController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.address =
    //     addressController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.addressNumber =
    //     addressNumberController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.city.name =
    //     cityController.text; //tem q chegar do servidor a classe city certa
    // Provider.of<DataProvider>(context, listen: false).store!.city.state.uf =
    //     stateController.text; //tem q chegar do servidor a classe state certa
    // Provider.of<DataProvider>(context, listen: false).store!.description =
    //     descriptionController.text;
    // Provider.of<DataProvider>(context, listen: false).store!.instagram =
    //     instagramController.text;
    // storeAvatarRef = storeAvatar;
    // storePhotosRef = List.from(storePhotos);
    // storeInfoChanged(context);
  }
}
