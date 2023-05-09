import 'dart:convert';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'CreateAccountEmployeeRepo.dart';

class CreateAccountEmployeeRepoImp implements CreateAccountEmployeeRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future validateNewEmployeeToken(String token) async {
    dynamic response = await _apiService
        .postResponse(
          _apiService.sandfriendsUrl,
          ApiEndPoints().validateNewEmployeeToken,
          jsonEncode(
            <String, Object>{
              "Token": token,
            },
          ),
        )
        .onError((error, stackTrace) => throw error!);
    return response;
  }

  @override
  Future createAccountEmployee(
    String token,
    String firstName,
    String lastName,
    String password,
  ) async {
    dynamic response = await _apiService
        .postResponse(
          _apiService.sandfriendsUrl,
          ApiEndPoints().createAccountEmployee,
          jsonEncode(
            <String, Object>{
              "Token": token,
              "FirstName": firstName,
              "LastName": lastName,
              "Password": password,
            },
          ),
        )
        .onError((error, stackTrace) => throw error!);
    return response;
  }
}
