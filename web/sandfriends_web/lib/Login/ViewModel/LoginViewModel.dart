import 'dart:convert';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Login/Model/CnpjStore.dart';
import 'package:sandfriends_web/Login/Model/CreateAccountStore.dart';
import 'package:sandfriends_web/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/CreateAccountCourtWidget.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/CreateAccountOwnerWidget.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/CreateAccountWidget.dart';
import 'package:sandfriends_web/SharedComponents/Model/Court.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import 'package:sandfriends_web/Login/View/LoginSuccessWidget.dart';
import 'package:sandfriends_web/Dashboard/View/DashboardScreen.dart';
import '../../SharedComponents/Model/Store.dart';
import '../View/ForgotPasswordWidget.dart';
import '../View/LoginWidget.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final _loginRepo = LoginRepoImp();

  PageStatus pageStatus = PageStatus.SUCCESS;
  String modalTitle = "";
  String modalDescription = "";
  VoidCallback modalCallback = () {};

  Widget _loginWidget = const LoginWidget();
  Widget get loginWidget => _loginWidget;

  //LOGIN SCREEN
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool keepConnected = true;

  void onTapLogin(BuildContext context) async {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    final String responseStore =
        await rootBundle.loadString(r"assets/fakeJson/store.json");
    final dataStore = await json.decode(responseStore);
    Provider.of<DataProvider>(context, listen: false).store =
        Store.fromJson(dataStore);

    String responseCourt =
        await rootBundle.loadString(r"assets/fakeJson/court.json");
    List<dynamic> dataCourt = json.decode(responseCourt);
    for (var court in dataCourt) {
      Provider.of<DataProvider>(context, listen: false)
          .courts
          .add(Court.fromJson(court));

      String responseSport =
          await rootBundle.loadString(r"assets/fakeJson/sport.json");
      List<dynamic> dataSport = json.decode(responseSport);
      for (var sport in dataSport) {
        Provider.of<DataProvider>(context, listen: false)
            .sports
            .add(Sport.fromJson(sport));

        String responseHour =
            await rootBundle.loadString(r"assets/fakeJson/availableHours.json");
        List<dynamic> dataHour = json.decode(responseHour);
        for (var hour in dataHour) {
          Provider.of<DataProvider>(context, listen: false)
              .hours
              .add(Hour.fromJson(hour));
        }
      }
    }

    // _loginRepo
    //     .login(userController.text, passwordController.text)
    //     .then(
    //       (value) => Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => const DashboardScreen()),
    //       ),
    //     )
    //     .onError((error, stackTrace) {
    //   modalTitle = error.toString();
    //   modalDescription = "";
    //   modalCallback = () {
    //     pageStatus = PageStatus.SUCCESS;
    //     notifyListeners();
    //   };
    //   pageStatus = PageStatus.ERROR;
    //   notifyListeners();
    // });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  void onTapForgotPassword() {
    _loginWidget = const ForgotPasswordWidget();
    notifyListeners();
  }

  void onTapCreateAccount() {
    _loginWidget = const CreateAccountWidget();
    notifyListeners();
  }

  void onTapGoToLoginWidget() {
    _loginWidget = const LoginWidget();
    notifyListeners();
  }

  //FORGOT PASSWORD
  TextEditingController forgotPasswordEmailController = TextEditingController();

  void sendForgotPassword() {
    //TODO

    _loginWidget = const LoginSuccessWidget();
    notifyListeners();
  }

  //CREATE ACCOUNT
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

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController telephoneOwnerController =
      MaskedTextController(mask: '(00) 00000-0000');
  bool isAbove18 = true;
  bool termsAgree = true;

  void onTapSearchCnpj() {
    if (cnpjController.text.isNotEmpty) {
      pageStatus = PageStatus.LOADING;
      notifyListeners();
      fetchCnpj(cnpjController.text);
    }
  }

  Future<void> fetchCnpj(String cnpj) async {
    _loginRepo.getStoreFromCnpj(cnpj).then((value) {
      setCourtFormFields(value!);
      pageStatus = PageStatus.SUCCESS;
      notifyListeners();
    }).onError(
      (error, stackTrace) {
        modalTitle = "CNPJ não encontrado";
        modalDescription = "Verifique se digitou corretamente";
        modalCallback = () {
          pageStatus = PageStatus.SUCCESS;
          notifyListeners();
        };
        pageStatus = PageStatus.ERROR;
        notifyListeners();
      },
    );
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

  final List<Widget> _createAccountForms = [
    const CreateAccountCourtWidget(),
    const CreateAccountOwnerWidget()
  ];

  String missingCourtFormFields() {
    String missingFields = "";
    if (noCnpj && cpfController.text.isEmpty) missingFields += "CPF\n";
    if (!noCnpj && cnpjController.text.isEmpty) missingFields += "CNPJ\n";
    if (storeNameController.text.isEmpty) {
      missingFields += "Nome do Estabelecimento\n";
    }
    if (cepController.text.isEmpty) missingFields += "CEP\n";
    if (neighbourhoodController.text.isEmpty) missingFields += "Bairro\n";
    if (stateController.text.isEmpty) missingFields += "Estado\n";
    if (cityController.text.isEmpty) missingFields += "Cidade\n";
    if (addressController.text.isEmpty) missingFields += "Enderaço\n";
    if (addressNumberController.text.isEmpty) missingFields += "Nº\n";
    return missingFields;
  }

  String missingOwnerFormFields() {
    String missingFields = "";
    if (!noCnpj && cpfController.text.isEmpty) missingFields += "CPF\n";
    if (ownerNameController.text.isEmpty) missingFields += "Nome\n";
    if (emailController.text.isEmpty) missingFields += "Email\n";
    if (telephoneController.text.isEmpty) {
      missingFields += "Telefone da Quadra\n";
    }
    if (!isAbove18) missingFields += "Confirmação de maioridade\n";
    if (!termsAgree) missingFields += "Confirmação dos Termos\n";
    return missingFields;
  }

  int _currentCreateAccountFormIndex = 0;
  Widget get createAccountForm =>
      _createAccountForms[_currentCreateAccountFormIndex];

  void returnForm() {
    if (_currentCreateAccountFormIndex == 0) {
      onTapGoToLoginWidget();
    } else {
      _currentCreateAccountFormIndex--;
    }
    notifyListeners();
  }

  void nextForm() {
    String missingfields = "";
    if (_currentCreateAccountFormIndex == _createAccountForms.length - 1) {
      missingfields = missingOwnerFormFields();
    } else {
      missingfields = missingCourtFormFields();
    }

    if (missingfields.isNotEmpty) {
      modalTitle = "Para posseguir, preencha:";
      modalDescription = missingfields;
      modalCallback = () {
        pageStatus = PageStatus.SUCCESS;
        notifyListeners();
      };
      pageStatus = PageStatus.ERROR;
      notifyListeners();
      return;
    }

    if (_currentCreateAccountFormIndex == _createAccountForms.length - 1) {
      submitCreateAccount();
    } else {
      _currentCreateAccountFormIndex++;
    }

    notifyListeners();
  }

  void submitCreateAccount() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    _loginRepo
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
        ownerName: ownerNameController.text,
        email: emailController.text,
        cpf: cpfController.text.replaceAll(RegExp('[^0-9]'), ''),
        telephone: telephoneController.text.replaceAll(RegExp('[^0-9]'), ''),
        telephoneOwner: telephoneOwnerController.text.isEmpty
            ? ""
            : telephoneOwnerController.text.replaceAll(RegExp('[^0-9]'), ''),
      ),
    )
        .then((value) {
      modalTitle = "feito";
      modalDescription = "feito";
      modalCallback = () {
        pageStatus = PageStatus.SUCCESS;
        notifyListeners();
      };
      pageStatus = PageStatus.ACCOMPLISHED;
      notifyListeners();
    }).onError((error, stackTrace) {
      modalTitle = error.toString();
      modalDescription = "";
      modalCallback = () {
        pageStatus = PageStatus.SUCCESS;
        notifyListeners();
      };
      pageStatus = PageStatus.ERROR;
      notifyListeners();
    });
  }

  void onTapTermosDeUso() {
    //TODO
  }
  void onTapPoliticaDePrivacidade() {
    //TODO
  }

  final fakeStore = CreateAccountStore(
    cnpj: "12",
    name: "12",
    cep: "12",
    state: "RS",
    city: "Porto Alegre",
    neighborhood: "12",
    street: "12",
    number: "12",
    ownerName: "12",
    email: "12",
    cpf: "12",
    telephone: "12",
    telephoneOwner: "12",
  );
}
