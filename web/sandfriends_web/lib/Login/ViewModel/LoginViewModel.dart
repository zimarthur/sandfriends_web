import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/Model/CnpjStore.dart';
import 'package:sandfriends_web/Login/Model/CreateAccountStore.dart';
import 'package:sandfriends_web/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/create_account_court_widget.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/create_account_owner_widget.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/create_account_widget.dart';
import 'package:sandfriends_web/View/Components/SFErrorWidget.dart';
import 'package:sandfriends_web/Login/View/login_success_widget.dart';
import 'package:sandfriends_web/View/Components/SFLoading.dart';
import 'package:sandfriends_web/View/Components/dashboard_screen.dart';
import 'package:sandfriends_web/remote/response/Status.dart';
import 'package:http/http.dart' as http;

import '../../remote/response/ApiResponse.dart';
import '../View/forgot_password_widget.dart';
import '../View/login_widget.dart';

class LoginViewModel extends ChangeNotifier {
  final _loginRepo = LoginRepoImp();

  Widget _loginWidget = LoginWidget();
  Widget get loginWidget => _loginWidget;

  bool showModal = false;
  Widget? modalWidget;

  //LOGIN SCREEN
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool keepConnected = true;

  void onTapLogin(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => DashboardScreen()),
    // );
    fetchDebug();
  }

  Future<void> fetchDebug() async {
    try {
      var response = await http.get(
        Uri.parse("https://www.sandfriends.com.br/debug"),
      );
      print(response.statusCode);
    } catch (e) {
      print("Error: $e");
    }
  }

  void onTapForgotPassword() {
    _loginWidget = ForgotPasswordWidget();
    notifyListeners();
  }

  void onTapCreateAccount() {
    _loginWidget = CreateAccountWidget();
    notifyListeners();
  }

  void onTapGoToLoginWidget() {
    _loginWidget = LoginWidget();
    notifyListeners();
  }

  //FORGOT PASSWORD
  TextEditingController forgotPasswordEmailController = TextEditingController();

  void sendForgotPassword() {
    //TODO

    _loginWidget = LoginSuccessWidget();
    notifyListeners();
  }

  //CREATE ACCOUNT
  TextEditingController cnpjController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController neighbourhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressNumberController = TextEditingController();
  bool noCnpj = false;

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController telephoneOwnerController = TextEditingController();
  bool isAbove18 = false;
  bool termsAgree = false;

  ApiResponse<CnpjStore> cnpjInfo = ApiResponse.loading();

  void onTapSearchCnpj() {
    if (cnpjController.text.isNotEmpty) {
      modalWidget = Container(
        height: 300,
        width: 300,
        child: SFLoading(size: 80),
      );
      showModal = true;
      fetchCnpj(cnpjController.text);
    }
  }

  void _setCnpjInfo(ApiResponse<CnpjStore> response) {
    print("MARAJ :: $response");
    cnpjInfo = response;
    if (response.status == Status.COMPLETED) {
      setCourtFormFields();
      showModal = false;
    } else if (response.status == Status.ERROR) {
      modalWidget = SFErrorWidget(
          title: "CNPJ não encontrado",
          description: "Verifique se digitou corretamente",
          onTap: () {
            showModal = false;
            notifyListeners();
          });
    }
    notifyListeners();
  }

  Future<void> fetchCnpj(String cnpj) async {
    _setCnpjInfo(ApiResponse.loading());
    _loginRepo
        .getStoreFromCnpj(cnpj)
        .then((value) => _setCnpjInfo(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setCnpjInfo(ApiResponse.error(error.toString())));
  }

  void setCourtFormFields() {
    storeNameController.text = cnpjInfo.data!.name;
    stateController.text = cnpjInfo.data!.state;
    cityController.text = cnpjInfo.data!.city;
    cepController.text = cnpjInfo.data!.cep;
    neighbourhoodController.text = cnpjInfo.data!.neighborhood;
    addressController.text = cnpjInfo.data!.street;
    addressNumberController.text = cnpjInfo.data!.number;
  }

  final List<Widget> _createAccountForms = [
    const CreateAccountCourtWidget(),
    const CreateAccountOwnerWidget()
  ];

  String missingCourtFormFields() {
    String missingFields = "";
    if (noCnpj && cpfController.text.isEmpty) missingFields += "CPF\n";
    if (!noCnpj && cnpjController.text.isEmpty) missingFields += "CNPJ\n";
    if (storeNameController.text.isEmpty)
      missingFields += "Nome do Estabelecimento\n";
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
    if (telephoneController.text.isEmpty)
      missingFields += "Telefone da Quadra\n";
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
    String missingfields;
    if (_currentCreateAccountFormIndex == _createAccountForms.length - 1) {
      missingfields = missingOwnerFormFields();
    } else {
      missingfields = missingCourtFormFields();
    }

    if (missingfields.isNotEmpty) {
      modalWidget = SFErrorWidget(
          title: "Para posseguir, preencha:",
          description: missingfields,
          onTap: () {
            showModal = false;
            notifyListeners();
          });
      showModal = true;
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
    _loginRepo
        .createAccount(CreateAccountStore(
          cnpj: cnpjController.text.isEmpty ? "" : cnpjController.text,
          name: storeNameController.text,
          cep: cepController.text,
          state: stateController.text,
          city: cityController.text,
          neighborhood: neighbourhoodController.text,
          street: addressController.text,
          number: addressNumberController.text,
          ownerName: ownerNameController.text,
          email: emailController.text,
          cpf: cpfController.text,
          telephone: telephoneController.text,
          telephoneOwner: telephoneOwnerController.text,
        ))
        .then((value) => null);
  }

  void onTapTermosDeUso() {
    //TODO
  }
  void onTapPoliticaDePrivacidade() {
    //TODO
  }
}
