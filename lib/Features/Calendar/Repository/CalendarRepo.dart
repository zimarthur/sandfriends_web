import '../../../../Remote/NetworkResponse.dart';

class CalendarRepo {
  Future<NetworkResponse?> updateMatchesList(
    String accessToken,
    DateTime newSelectedDate,
  ) async {}

  Future<NetworkResponse?> cancelMatch(
    String accessToken,
    int idMatch,
    String? cancelationReason,
  ) async {}

  Future<NetworkResponse?> cancelRecurrentMatch(
    String accessToken,
    int idRecurrentMatch,
    String? cancelationReason,
  ) async {}

  Future<NetworkResponse?> blockUnblockHour(
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
    bool block,
    String blockReson,
  ) async {}

  Future<NetworkResponse?> recurrentBlockUnblockHour(
    String accessToken,
    int idStoreCourt,
    int weekday,
    int hour,
    bool block,
    String blockReason,
    int idSport,
  ) async {}
}
