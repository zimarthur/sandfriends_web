import 'dart:convert';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';

import '../../../../Remote/NetworkResponse.dart';
import 'ForgotPasswordRepo.dart';

class ForgotPasswordRepoImp implements ForgotPasswordRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> forgotPassword(String email) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().forgotPassword,
      jsonEncode(
        <String, Object>{
          "Email": email,
        },
      ),
    );
    return response;
  }
}
