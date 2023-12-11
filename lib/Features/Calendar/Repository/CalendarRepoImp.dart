import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Repository/CalendarRepo.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:intl/intl.dart';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';
import '../../../SharedComponents/ViewModel/EnvironmentProvider.dart';

class CalendarRepoImp implements CalendarRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> updateMatchesList(BuildContext context,
      String accessToken, DateTime newSelectedDate) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().updateMatchesList,
      ),
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
    BuildContext context,
    String accessToken,
    int idMatch,
    String? cancelationReason,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().cancelMatch,
      ),
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
    BuildContext context,
    String accessToken,
    int idRecurrentMatch,
    String? cancelationReason,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().cancelRecurrentMatch,
      ),
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
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
    bool block,
    int idPlayer,
    int idSport,
    String obs,
    int idMatch,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().blockUnblockHour,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
          "Date": DateFormat("dd/MM/yyyy").format(date),
          "IdHour": hour,
          "Blocked": block,
          "IdStorePlayer": idPlayer,
          "IdSport": idSport,
          "BlockedReason": obs,
          "IdMatch": idMatch,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> recurrentBlockUnblockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    int weekday,
    int hour,
    bool block,
    int idPlayer,
    int idSport,
    String obs,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().recurrentBlockUnblockHour,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
          "Weekday": weekday,
          "IdHour": hour,
          "Blocked": block,
          "IdStorePlayer": idPlayer,
          "IdSport": idSport,
          "BlockedReason": obs,
        },
      ),
    );
    return response;
  }
}
