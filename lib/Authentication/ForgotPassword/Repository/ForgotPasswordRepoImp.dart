import 'dart:convert';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';

import 'ForgotPasswordRepo.dart';

class ForgotPasswordRepoImp implements ForgotPasswordRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future forgotPassword(String email) async {
    dynamic response = await _apiService
        .postResponse(
          _apiService.sandfriendsUrl,
          ApiEndPoints().forgotPassword,
          jsonEncode(
            <String, Object>{
              "Email": email,
            },
          ),
        )
        .onError((error, stackTrace) => throw error!);
  }
}