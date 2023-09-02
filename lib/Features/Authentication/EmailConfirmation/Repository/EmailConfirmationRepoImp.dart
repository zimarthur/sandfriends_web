import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'EmailConfirmationRepo.dart';

class EmailConfirmationRepoImp implements EmailConfirmationRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> emailConfirmationUser(
      BuildContext context, String token) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().emailConfirmationUser,
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
  Future<NetworkResponse> emailConfirmationStore(
      BuildContext context, String token) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().emailConfirmationStore,
      ),
      jsonEncode(
        <String, Object>{
          "EmailConfirmationToken": token,
        },
      ),
    );
    return response;
  }
}
