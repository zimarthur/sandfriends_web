import 'package:sandfriends_web/Login/Model/CnpjStore.dart';
import 'package:sandfriends_web/Login/Model/CreateAccountStore.dart';

class LoginRepo {
  Future<CnpjStore?> getStoreFromCnpj(String cnpj) async {}
  Future createAccount(CreateAccountStore store) async {}
}
