import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/Model/CnpjStore.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/Model/CreateAccountStore.dart';

import '../../../../Remote/NetworkResponse.dart';

class CreateAccountRepo {
  Future<NetworkResponse?> getStoreFromCnpj(
      BuildContext context, String cnpj) async {
    return null;
  }

  Future<NetworkResponse?> createAccount(
      BuildContext context, CreateAccountStore store) async {}
}
