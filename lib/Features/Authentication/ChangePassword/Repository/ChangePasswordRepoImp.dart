import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'ChangePasswordRepo.dart';

class ChangePasswordRepoImp implements ChangePasswordRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> validateChangePasswordTokenUser(
      BuildContext context, String token) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().changePasswordValidateTokenUser,
      ),
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
      BuildContext context, String token) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().changePasswordValidateTokenEmployee,
      ),
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
      BuildContext context, String token, String newPassword) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().changePasswordUser,
      ),
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
      BuildContext context, String token, String newPassword) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().changePasswordEmployee,
      ),
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
