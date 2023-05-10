import '../../../../Remote/NetworkResponse.dart';

class ChangePasswordRepo {
  Future<NetworkResponse?> validateChangePasswordTokenUser(
      String token) async {}
  Future<NetworkResponse?> validateChangePasswordTokenEmployee(
      String token) async {}
  Future<NetworkResponse?> changePasswordUser(
      String token, String newPassword) async {}
  Future<NetworkResponse?> changePasswordEmployee(
      String token, String newPassword) async {}
}
