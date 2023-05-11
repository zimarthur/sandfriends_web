import 'dart:convert';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import 'CreateAccountEmployeeRepo.dart';

class CreateAccountEmployeeRepoImp implements CreateAccountEmployeeRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> validateNewEmployeeToken(String token) async {
    dynamic response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().validateNewEmployeeToken,
      jsonEncode(
        <String, Object>{
          "EmailConfirmationToken": token,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> createAccountEmployee(
    String token,
    String firstName,
    String lastName,
    String password,
  ) async {
    dynamic response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().createAccountEmployee,
      jsonEncode(
        <String, Object>{
          "EmailConfirmationToken": token,
          "FirstName": firstName,
          "LastName": lastName,
          "Password": password,
        },
      ),
    );
    return response;
  }
}
