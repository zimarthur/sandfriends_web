import 'dart:convert';

import 'package:sandfriends_web/Features/Calendar/Repository/CalendarRepo.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:intl/intl.dart';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';

class CalendarRepoImp implements CalendarRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> updateMatchesList(
      String accessToken, DateTime newSelectedDate) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().updateMatchesList,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "NewSelectedDate": DateFormat("dd/MM/yyyy").format(newSelectedDate),
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> cancelMatch(
    String accessToken,
    int idMatch,
    String? cancelationReason,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().cancelMatch,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdMatch": idMatch,
          "CancelationReason": cancelationReason ?? "",
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> cancelRecurrentMatch(
    String accessToken,
    int idRecurrentMatch,
    String? cancelationReason,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().cancelRecurrentMatch,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdRecurrentMatch": idRecurrentMatch,
          "CancelationReason": cancelationReason ?? "",
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> blockUnblockHour(
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
    bool block,
    String blockReson,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().blockUnblockHour,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
          "Date": DateFormat("dd/MM/yyyy").format(date),
          "IdHour": hour,
          "Blocked": block,
          "BlockedReason": blockReson,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> recurrentBlockUnblockHour(
    String accessToken,
    int idStoreCourt,
    int weekday,
    int hour,
    bool block,
    String blockReason,
    int idSport,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().recurrentBlockUnblockHour,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
          "Weekday": weekday,
          "IdHour": hour,
          "Blocked": block,
          "BlockedReason": blockReason,
          "IdSport": idSport,
        },
      ),
    );
    return response;
  }
}
