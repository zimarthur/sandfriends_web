import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'CreateAccountEmployeeRepo.dart';

class CreateAccountEmployeeRepoImp implements CreateAccountEmployeeRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> validateNewEmployeeToken(
      BuildContext context, String token) async {
    dynamic response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().validateNewEmployeeToken,
      ),
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
    BuildContext context,
    String token,
    String firstName,
    String lastName,
    String password,
  ) async {
    dynamic response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().createAccountEmployee,
      ),
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
