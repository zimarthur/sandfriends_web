import 'dart:convert';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import 'EmailConfirmationRepo.dart';

class EmailConfirmationRepoImp implements EmailConfirmationRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> emailConfirmationUser(String token) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().emailConfirmationUser,
      jsonEncode(
        <String, Object>{
          "EmailConfirmationToken": token,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> emailConfirmationStore(String token) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().emailConfirmationStore,
      jsonEncode(
        <String, Object>{
          "EmailConfirmationToken": token,
        },
      ),
    );
    return response;
  }
}
