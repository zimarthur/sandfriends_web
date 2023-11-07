import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Player.dart';

class PlayersRepo {
  Future<NetworkResponse?> addPlayer(
    BuildContext context,
    String accessToken,
    Player player,
  ) async {}
  Future<NetworkResponse?> deleteStorePlayer(
    BuildContext context,
    String accessToken,
    int idStorePlayer,
  ) async {}
  Future<NetworkResponse?> editPlayer(
    BuildContext context,
    String accessToken,
    Player player,
  ) async {}
}
