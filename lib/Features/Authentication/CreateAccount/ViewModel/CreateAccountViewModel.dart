import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/Repository/CreateAccountRepo.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:sandfriends_web/SharedComponents/View/SFMessageModal.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../Utils/PageStatus.dart';
import '../Model/CnpjStore.dart';
import '../Model/CreateAccountStore.dart';
import '../Repository/CreateAccountRepoImp.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final createAccountRepo = CreateAccountRepoImp();

  PageStatus pageStatus = PageStatus.OK;
  SFMessageModal messageModal = SFMessageModal(
    title: "",
    onTap: () {},
    isHappy: true,
  );

  int _currentCreateAccountFormIndex = 0;
  int get currentCreateAccountFormIndex => _currentCreateAccountFormIndex;

  void returnForm(BuildContext context) {
    if (_currentCreateAccountFormIndex == 0) {
      Navigator.pushNamed(context, '/login');
    } else {
      _currentCreateAccountFormIndex--;
    }
    notifyListeners();
  }

  void nextForm(BuildContext context) {
    if (_currentCreateAccountFormIndex == 0) {
      if (courtFormKey.currentState?.validate() == true) {
        _currentCreateAccountFormIndex++;
        notifyListeners();
      }
    } else {
      if (ownerFormKey.currentState?.validate() == true) {
        submitCreateAccount(context);
      }
    }
  }

  final courtFormKey = GlobalKey<FormState>();
  TextEditingController cnpjController =
      MaskedTextController(mask: '00.000.000/0000-00');
  TextEditingController cpfController =
      MaskedTextController(mask: '000.000.000-00');
  TextEditingController storeNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cepController = MaskedTextController(mask: '00000-000');
  TextEditingController neighbourhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressNumberController = TextEditingController();
  bool noCnpj = false;

  final ownerFormKey = GlobalKey<FormState>();
  TextEditingController ownerFirstNameController = TextEditingController();
  TextEditingController ownerLastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController telephoneController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController telephoneOwnerController =
      MaskedTextController(mask: '(00) 00000-0000');

  bool _isAbove18 = true;
  bool get isAbove18 => _isAbove18;
  set isAbove18(bool newValue) {
    _isAbove18 = newValue;
    notifyListeners();
  }

  bool _termsAgree = true;
  bool get termsAgree => _termsAgree;
  set termsAgree(bool newValue) {
    _termsAgree = newValue;
    notifyListeners();
  }

  void onTapSearchCnpj() {
    if (cnpjController.text.isNotEmpty) {
      pageStatus = PageStatus.LOADING;
      notifyListeners();
      fetchCnpj(cnpjController.text);
    }
  }

  bool get buttonNextEnabled {
    if (_currentCreateAccountFormIndex == 1 &&
        (isAbove18 == false || termsAgree == false)) {
      return false;
    } else {
      return true;
    }
  }

  void fetchCnpj(String cnpj) {
    createAccountRepo.getStoreFromCnpj(cnpj).then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        Map<String, dynamic> responseBody = json.decode(
          response.responseBody!,
        );
        setCourtFormFields(CnpjStore.fromJson(responseBody));
        pageStatus = PageStatus.OK;
        notifyListeners();
      } else {
        messageModal = SFMessageModal(
          title: "CNPJ não encontrado",
          onTap: () {
            pageStatus = PageStatus.OK;
            notifyListeners();
          },
          isHappy: false,
        );
        pageStatus = PageStatus.WARNING;
        notifyListeners();
      }
    });
  }

  void setCourtFormFields(CnpjStore cnpjInfo) {
    storeNameController.text = cnpjInfo.name;
    stateController.text = cnpjInfo.state;
    cityController.text = cnpjInfo.city;
    cepController.text = cnpjInfo.cep;
    neighbourhoodController.text = cnpjInfo.neighborhood;
    addressController.text = cnpjInfo.street;
    addressNumberController.text = cnpjInfo.number;
  }

  void submitCreateAccount(BuildContext context) {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    createAccountRepo
        .createAccount(
      CreateAccountStore(
        cnpj: cnpjController.text.isEmpty
            ? ""
            : cnpjController.text.replaceAll(RegExp('[^0-9]'), ''),
        name: storeNameController.text,
        cep: cepController.text.replaceAll(RegExp('[^0-9]'), ''),
        state: stateController.text,
        city: cityController.text,
        neighborhood: neighbourhoodController.text,
        street: addressController.text,
        number: addressNumberController.text,
        ownerFirstName: ownerFirstNameController.text,
        ownerLastName: ownerLastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        cpf: cpfController.text.replaceAll(RegExp('[^0-9]'), ''),
        telephone: telephoneController.text.replaceAll(RegExp('[^0-9]'), ''),
        telephoneOwner: telephoneOwnerController.text.isEmpty
            ? ""
            : telephoneOwnerController.text.replaceAll(RegExp('[^0-9]'), ''),
      ),
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
        buttonText: response.responseStatus == NetworkResponseStatus.alert
            ? "Concluído"
            : "Voltar",
        isHappy: response.responseStatus == NetworkResponseStatus.alert,
      );
      pageStatus = PageStatus.WARNING;
      notifyListeners();
    });
  }

  void onTapTermosDeUso(BuildContext context) {
    Navigator.pushNamed(context, '/terms');
  }

  void onTapPoliticaDePrivacidade(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }
}
