import 'dart:convert';

import 'package:sandfriends_web/Authentication/CreateAccount/Model/CnpjStore.dart';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';
import '../../CreateAccount/Model/CreateAccountStore.dart';
import 'package:sandfriends_web/Authentication/Login/Repository/LoginRepo.dart';

class LoginRepoImp implements LoginRepo {
  final BaseApiService _apiService = NetworkApiService();
  @override
  Future login(String email, String password) async {
    dynamic response = await _apiService
        .postResponse(
          _apiService.sandfriendsUrl,
          ApiEndPoints().login,
          jsonEncode(
            <String, Object>{
              "Email": email,
              "Password": password,
            },
          ),
          true,
        )
        .onError((error, stackTrace) => throw error!);
    return response;
  }
}
