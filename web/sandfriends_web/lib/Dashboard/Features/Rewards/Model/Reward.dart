import '../../../../SharedComponents/Model/player.dart';
import 'package:intl/intl.dart';

class Reward {
  String reward;
  DateTime date;
  Player player;

  Reward({
    required this.reward,
    required this.date,
    required this.player,
  });

  String get hour => DateFormat.Hm().format(date);
}
