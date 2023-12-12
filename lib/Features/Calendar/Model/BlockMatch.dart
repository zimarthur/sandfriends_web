import 'package:sandfriends_web/SharedComponents/Model/Player.dart';

import '../../../SharedComponents/Model/Hour.dart';

class BlockMatch {
  bool isRecurrent;
  int idStoreCourt;
  Hour timeBegin;
  Player player;
  String observation;
  int idSport;

  BlockMatch({
    required this.isRecurrent,
    required this.idStoreCourt,
    required this.timeBegin,
    required this.player,
    required this.observation,
    required this.idSport,
  });
}
