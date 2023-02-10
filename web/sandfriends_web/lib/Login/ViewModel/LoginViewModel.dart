import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/Model/CnpjStore.dart';
import 'package:sandfriends_web/Login/Repository/LoginRepoImp.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/create_account_court_widget.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/create_account_owner_widget.dart';
import 'package:sandfriends_web/Login/View/CreateAccount/create_account_widget.dart';
import 'package:sandfriends_web/View/Components/SFErrorWidget.dart';
import 'package:sandfriends_web/Login/View/login_success_widget.dart';
import 'package:sandfriends_web/View/Components/SFLoading.dart';
import 'package:sandfriends_web/View/Components/dashboard_screen.dart';
import 'package:sandfriends_web/remote/response/Status.dart';

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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
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
    if (_currentCreateAccountFormIndex == _createAccountForms.length - 1) {
    } else {
      _currentCreateAccountFormIndex++;
    }
    notifyListeners();
  }
}
