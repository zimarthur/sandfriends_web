import 'package:sandfriends_web/Features/Authentication/CreateAccount/Model/CnpjStore.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/Model/CreateAccountStore.dart';

import '../../../../Remote/NetworkResponse.dart';

class CreateAccountRepo {
  Future<NetworkResponse?> getStoreFromCnpj(String cnpj) async {
    return null;
  }

  Future<NetworkResponse?> createAccount(CreateAccountStore store) async {}
  Future<NetworkResponse?> createAccountEmployee(
      String email, String password) async {}
}
