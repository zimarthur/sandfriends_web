import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';

class RewardsRepo {
  Future<NetworkResponse?> searchCustomRewards(
    BuildContext context,
    String accessToken,
    DateTime startDate,
    DateTime? endDate,
  ) async {}

  Future<NetworkResponse?> sendUserRewardCode(
    BuildContext context,
    String rewardCode,
  ) async {}

  Future<NetworkResponse?> userRewardSelected(
    BuildContext context,
    String accessToken,
    String rewardCode,
    int rewardItem,
  ) async {}
}
