import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';

class LoginRepo {
  Future<NetworkResponse?> login(
      BuildContext context, String email, String password) async {}
  Future<NetworkResponse?> validateToken(
      BuildContext context, String accessToken) async {}
}
