import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';

class RewardsRepo {
  Future<NetworkResponse?> searchCustomRewards(
    String accessToken,
    DateTime startDate,
    DateTime? endDate,
  ) async {}

  Future<NetworkResponse?> sendUserRewardCode(
    String rewardCode,
  ) async {}

  Future<NetworkResponse?> userRewardSelected(
    String accessToken,
    String rewardCode,
    int rewardItem,
  ) async {}
}
