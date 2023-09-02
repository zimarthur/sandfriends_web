import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';

class ChangePasswordRepo {
  Future<NetworkResponse?> validateChangePasswordTokenUser(
      BuildContext context, String token) async {}
  Future<NetworkResponse?> validateChangePasswordTokenEmployee(
      BuildContext context, String token) async {}
  Future<NetworkResponse?> changePasswordUser(
      BuildContext context, String token, String newPassword) async {}
  Future<NetworkResponse?> changePasswordEmployee(
      BuildContext context, String token, String newPassword) async {}
}
