import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Rewards/Repository/RewardsRepo.dart';
import 'package:intl/intl.dart';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepo.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';
import '../../../SharedComponents/ViewModel/EnvironmentProvider.dart';

class RewardsRepoImp implements RewardsRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> searchCustomRewards(
    BuildContext context,
    String accessToken,
    DateTime startDate,
    DateTime? endDate,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().searchCustomRewards,
      ),
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

  @override
  Future<NetworkResponse> sendUserRewardCode(
    BuildContext context,
    String rewardCode,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().sendUserRewardCode,
      ),
      jsonEncode(
        <String, Object>{
          "RewardClaimCode": rewardCode,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> userRewardSelected(
    BuildContext context,
    String accessToken,
    String rewardCode,
    int rewardItem,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().userRewardSelected,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "RewardClaimCode": rewardCode,
          "RewardItem": rewardItem,
        },
      ),
    );
    return response;
  }
}
