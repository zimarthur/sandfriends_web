import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';

class EmployeeInfoRepo {
  Future<NetworkResponse?> addEmployee(
    BuildContext context,
    String accessToken,
    String employeeEmail,
  ) async {}

  Future<NetworkResponse?> changeEmployeeAdmin(
    BuildContext context,
    String accessToken,
    int employeeId,
    bool isAdmin,
  ) async {}

  Future<NetworkResponse?> renameEmployee(
    BuildContext context,
    String accessToken,
    String firstName,
    String lastName,
  ) async {}
  Future<NetworkResponse?> removeEmployee(
    BuildContext context,
    String accessToken,
    int idEmployee,
  ) async {}
}
