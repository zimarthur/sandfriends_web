import 'package:intl/intl.dart';

import 'Player.dart';
import 'RewardItem.dart';

class Reward {
  int idRewardUser;
  RewardItem rewardItem;
  DateTime claimedDate;
  Player player;

  Reward({
    required this.idRewardUser,
    required this.rewardItem,
    required this.claimedDate,
    required this.player,
  });

  String get hour => DateFormat.Hm().format(claimedDate);

  factory Reward.fromJson(Map<String, dynamic> parsedJson) {
    return Reward(
      idRewardUser: parsedJson["IdRewardUser"],
      player: Player.fromUserMinJson(
        parsedJson["User"],
      ),
      claimedDate: DateFormat("dd/MM/yyyy hh:mm").parse(
        parsedJson["RewardClaimedDate"],
      ),
      rewardItem: RewardItem.fromJson(parsedJson["RewardItem"]),
    );
  }
}
