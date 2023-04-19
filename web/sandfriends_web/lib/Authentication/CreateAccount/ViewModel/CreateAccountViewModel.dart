import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/Repository/CreateAccountRepo.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import '../../../Utils/PageStatus.dart';
import '../Model/CnpjStore.dart';
import '../Model/CreateAccountStore.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final _createAccountRepo = CreateAccountRepo();

  PageStatus pageStatus = PageStatus.OK;
  String modalTitle = "";
  String modalDescription = "";
  VoidCallback modalCallback = () {};

  void goToCreateAccountEmployee(BuildContext context) {
    Navigator.pushNamed(context, '/create_account_employee');
  }

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

  void nextForm() {
    String missingfields = "";
    if (_currentCreateAccountFormIndex == 0) {
      missingfields = missingCourtFormFields();
    } else {
      missingfields = missingOwnerFormFields();
    }

    if (missingfields.isNotEmpty) {
      modalTitle = "Para posseguir, preencha:";
      modalDescription = missingfields;
      modalCallback = () {
        pageStatus = PageStatus.OK;
        notifyListeners();
      };
      pageStatus = PageStatus.ERROR;
      notifyListeners();
      return;
    }

    if (_currentCreateAccountFormIndex == 1) {
      submitCreateAccount();
    } else {
      _currentCreateAccountFormIndex++;
    }

    notifyListeners();
  }

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
    _createAccountRepo.getStoreFromCnpj(cnpj).then((value) {
      setCourtFormFields(value!);
      pageStatus = PageStatus.OK;
      notifyListeners();
    }).onError(
      (error, stackTrace) {
        modalTitle = "CNPJ não encontrado";
        modalDescription = "Verifique se digitou corretamente";
        modalCallback = () {
          pageStatus = PageStatus.OK;
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

  void submitCreateAccount() {
    pageStatus = PageStatus.LOADING;
    notifyListeners();
    _createAccountRepo
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
        pageStatus = PageStatus.OK;
        notifyListeners();
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

  void onTapTermosDeUso(BuildContext context) {
    Navigator.pushNamed(context, '/terms');
  }

  void onTapPoliticaDePrivacidade(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }
}
