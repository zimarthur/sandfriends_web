import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'EmployeeInfoRepo.dart';
import 'package:provider/provider.dart';

class EmployeeInfoRepoImp implements EmployeeInfoRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> addEmployee(
      BuildContext context, String accessToken, String employeeEmail) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().addEmployee,
      ),
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "Email": employeeEmail,
      }),
    );
    return response;
  }

  @override
  Future<NetworkResponse> changeEmployeeAdmin(
    BuildContext context,
    String accessToken,
    int employeeId,
    bool isAdmin,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().changeEmployeeAdmin,
      ),
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "IdEmployee": employeeId,
        "IsAdmin": isAdmin,
      }),
    );
    return response;
  }

  @override
  Future<NetworkResponse> renameEmployee(
    BuildContext context,
    String accessToken,
    String firstName,
    String lastName,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().renameEmployee,
      ),
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "FirstName": firstName,
        "LastName": lastName,
      }),
    );
    return response;
  }

  @override
  Future<NetworkResponse> removeEmployee(
    BuildContext context,
    String accessToken,
    int idEmployee,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().removeEmployee,
      ),
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "IdEmployee": idEmployee,
      }),
    );
    return response;
  }
}
