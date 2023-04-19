import 'dart:convert';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';
import 'CreateAccountEmployeeRepo.dart';

class CreateAccountEmployeeRepoImp implements CreateAccountEmployeeRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future createAccountEmployee(String email, String password) async {
    dynamic response = await _apiService
        .postResponse(
          _apiService.sandfriendsUrl,
          ApiEndPoints().createAccountEmployee,
          jsonEncode(
            <String, Object>{
              "Email": email,
              "Password": password,
            },
          ),
          false,
        )
        .onError((error, stackTrace) => throw error!);
    return response;
  }
}
