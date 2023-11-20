import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepo.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginRepoImp implements LoginRepo {
  final BaseApiService _apiService = NetworkApiService();
  @override
  Future<NetworkResponse> login(
    BuildContext context,
    String email,
    String password,
    Tuple2<bool?, String?>? notificationsConfig,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().login,
      ),
      jsonEncode(
        <String, Object>{
          "Email": email,
          "Password": password,
          'UpdateNotifications': notificationsConfig != null,
          'AllowNotifications': notificationsConfig != null
              ? notificationsConfig.item1 ?? false
              : false,
          'NotificationsToken': notificationsConfig != null
              ? notificationsConfig.item2 ?? ""
              : "",
          'IsRequestFromApp': !kIsWeb,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> validateToken(
      BuildContext context, String accessToken) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().validateToken,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          'IsRequestFromApp': !kIsWeb,
        },
      ),
    );
    return response;
  }
}
