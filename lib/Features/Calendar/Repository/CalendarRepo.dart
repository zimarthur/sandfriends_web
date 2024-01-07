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

  Future<NetworkResponse?> blockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
    int idPlayer,
    int idSport,
    String obs,
    double price,
  ) async {}

  Future<NetworkResponse?> unblockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
  ) async {}

  Future<NetworkResponse?> recurrentBlockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    int weekday,
    int hour,
    int idPlayer,
    int idSport,
    String obs,
    double price,
  ) async {}
}
