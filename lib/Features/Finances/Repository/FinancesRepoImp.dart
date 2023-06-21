import 'dart:convert';

import 'package:sandfriends_web/Features/Finances/Repository/FinancesRepo.dart';
import 'package:sandfriends_web/Features/Rewards/Repository/RewardsRepo.dart';
import 'package:intl/intl.dart';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepo.dart';

import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';

class FinancesRepoImp implements FinancesRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> searchCustomMatches(
    String accessToken,
    DateTime startDate,
    DateTime? endDate,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().searchCustomMatches,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "DateStart": DateFormat("dd/MM/yyyy").format(startDate),
          "DateEnd": endDate == null
              ? DateFormat("dd/MM/yyyy").format(startDate)
              : DateFormat("dd/MM/yyyy").format(endDate),
        },
      ),
    );
    return response;
  }
}