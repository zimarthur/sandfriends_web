import '../../../../Remote/NetworkResponse.dart';

class EmployeeInfoRepo {
  Future<NetworkResponse?> addEmployee(
    String accessToken,
    String employeeEmail,
  ) async {}

  Future<NetworkResponse?> changeEmployeeAdmin(
      String accessToken, int employeeId, bool isAdmin) async {}

  Future<NetworkResponse?> renameEmployee(
      String accessToken, String firstName, String lastName) async {}
  Future<NetworkResponse?> removeEmployee(
    String accessToken,
    int idEmployee,
  ) async {}
}
