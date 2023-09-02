import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';

class CreateAccountEmployeeRepo {
  Future<NetworkResponse?> validateNewEmployeeToken(
      BuildContext context, String token) async {}

  Future<NetworkResponse?> createAccountEmployee(
    BuildContext context,
    String token,
    String firstName,
    String lastName,
    String password,
  ) async {}
}
