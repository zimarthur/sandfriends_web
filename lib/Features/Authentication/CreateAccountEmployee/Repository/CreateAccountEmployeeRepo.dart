import '../../../../Remote/NetworkResponse.dart';

class CreateAccountEmployeeRepo {
  Future<NetworkResponse?> validateNewEmployeeToken(String token) async {}

  Future<NetworkResponse?> createAccountEmployee(
    String token,
    String firstName,
    String lastName,
    String password,
  ) async {}
}
