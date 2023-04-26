import 'package:sandfriends_web/Authentication/CreateAccount/Model/CnpjStore.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/Model/CreateAccountStore.dart';

class CreateAccountRepo {
  Future<CnpjStore?> getStoreFromCnpj(String cnpj) async {
    return null;
  }

  Future createAccount(CreateAccountStore store) async {}
  Future createAccountEmployee(String email, String password) async {}
}
