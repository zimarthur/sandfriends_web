import 'package:flutter/material.dart';

import '../../../../Remote/NetworkResponse.dart';

class CalendarRepo {
  Future<NetworkResponse?> updateMatchesList(
    BuildContext context,
    String accessToken,
    DateTime newSelectedDate,
  ) async {}

  Future<NetworkResponse?> cancelMatch(
    BuildContext context,
    String accessToken,
    int idMatch,
    String? cancelationReason,
  ) async {}

  Future<NetworkResponse?> cancelRecurrentMatch(
    BuildContext context,
    String accessToken,
    int idRecurrentMatch,
    String? cancelationReason,
  ) async {}

  Future<NetworkResponse?> blockUnblockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
    bool block,
    String blockReson,
    int idSport,
  ) async {}

  Future<NetworkResponse?> recurrentBlockUnblockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    int weekday,
    int hour,
    bool block,
    String blockReason,
    int idSport,
  ) async {}
}
