import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';

class MyCourtsRepo {
  Future<NetworkResponse?> addCourt(
    BuildContext context,
    String accessToken,
    Court newCourt,
  ) async {}
  Future<NetworkResponse?> removeCourt(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
  ) async {}
  Future<NetworkResponse?> saveCourtChanges(
    BuildContext context,
    String accessToken,
    List<Court> courts,
  ) async {}
}
