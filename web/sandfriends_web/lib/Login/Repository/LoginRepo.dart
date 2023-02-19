import 'package:sandfriends_web/Login/Model/CnpjStore.dart';
import 'package:sandfriends_web/Login/Model/CreateAccountStore.dart';

class LoginRepo {
  Future<CnpjStore?> getStoreFromCnpj(String cnpj) async {
    return null;
  }
  Future createAccount(CreateAccountStore store) async {}
  Future login(String email, String password) async {}

  Future debug() async {}
}
