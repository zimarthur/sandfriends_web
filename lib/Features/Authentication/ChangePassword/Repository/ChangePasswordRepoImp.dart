import 'dart:convert';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import 'ChangePasswordRepo.dart';

class ChangePasswordRepoImp implements ChangePasswordRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> validateChangePasswordTokenUser(String token) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().changePasswordValidateTokenUser,
      jsonEncode(
        <String, Object>{
          "ChangePasswordToken": token,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> validateChangePasswordTokenEmployee(
      String token) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().changePasswordValidateTokenEmployee,
      jsonEncode(
        <String, Object>{
          "ChangePasswordToken": token,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> changePasswordUser(
      String token, String newPassword) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().changePasswordUser,
      jsonEncode(
        <String, Object>{
          "ChangePasswordToken": token,
          "NewPassword": newPassword,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> changePasswordEmployee(
      String token, String newPassword) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().changePasswordEmployee,
      jsonEncode(
        <String, Object>{
          "ResetPasswordToken": token,
          "NewPassword": newPassword,
        },
      ),
    );
    return response;
  }
}
