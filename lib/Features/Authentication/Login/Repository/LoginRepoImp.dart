import 'dart:convert';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepo.dart';

import '../../../../Remote/NetworkResponse.dart';

class LoginRepoImp implements LoginRepo {
  final BaseApiService _apiService = NetworkApiService();
  @override
  Future<NetworkResponse> login(
    String email,
    String password,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().login,
      jsonEncode(
        <String, Object>{
          "Email": email,
          "Password": password,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> validateToken(String accessToken) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().validateToken,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
        },
      ),
    );
    return response;
  }
}
