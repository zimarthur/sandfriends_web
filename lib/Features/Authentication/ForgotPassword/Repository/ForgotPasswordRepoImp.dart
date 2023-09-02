import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';

import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'ForgotPasswordRepo.dart';

class ForgotPasswordRepoImp implements ForgotPasswordRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> forgotPassword(
      BuildContext context, String email) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().forgotPassword,
      ),
      jsonEncode(
        <String, Object>{
          "Email": email,
        },
      ),
    );
    return response;
  }
}
